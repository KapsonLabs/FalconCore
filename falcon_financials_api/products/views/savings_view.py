from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import permissions
from django.db.models import Q, F

from ..models import Product, ProductSubscriptions, ProductFeesLevied, Savings, SavingsDeposits, SavingsWithdrawal
from ..serializers.savings_serializer import (SavingsDepositAndWithdrawCreateSerializer, SavingsDepositSaveSerializer, SavingsWithdrawSaveSerializer, 
SavingsHistorySerializer
)
from ..serializers.savings_serializer import SavingsCreateSerializer
from ledgers.procedures.transaction_procedures import TransactionProcedure
import datetime 

class SavingDepositListView(APIView):
    """
    List all savings deposits and create a savings deposit.
    """
    permission_classes = (permissions.IsAuthenticated, )

    # def get(self, request, format=None):
    #     product_subscribed_to = 
    #     serializer = SavingsDepositSaveSerializer(Product.objects.all(), many=True)
    #     return Response({"status":200, "data":serializer.data}, status=status.HTTP_200_OK)

    def post(self, request, format=None):
        serializer = SavingsDepositAndWithdrawCreateSerializer(data=request.data)
        try:
            if serializer.is_valid():
                product_subscribed_to = ProductSubscriptions.objects.get(account_number=serializer.data['account_number'])

                if(product_subscribed_to.related_product_subscription.product_category==0):
                    savings_account = Savings.objects.get(related_savings_subscription=product_subscribed_to.pk)

                    if serializer.data['method']==0:
                        savings_deposit_data = {
                            'related_savings_account':savings_account.pk,
                            'amount_deposited':serializer.data['amount'],
                            'fee_charged':0,
                            'deposit_method':0,
                            'deposit_received_by':request.user.pk,
                            'deposit_cleared_by':request.user.pk
                        }

                        savings_deposit_creation = SavingsDepositSaveSerializer(data=savings_deposit_data)
                        savings_deposit_creation.is_valid(raise_exception=True)
                        savings_deposit_creation.save()

                        #create the transaction.
                        # transaction_data = {
                        #     'transaction_related_product':product_subscribed_to.pk,
                        #     'transaction_category':0,
                        #     'transaction_amount':serializer.data['amount'],
                        #     'transaction_cleared_by':request.user.pk,
                        #     'transaction_completed_by':request.user.pk
                        # }

                        transation = TransactionProcedure.create_transaction(self, product_subscribed_to.pk, 0, serializer.data['amount'], request.user.pk, request.user.pk)
                        

                        #update savings amount
                        savings_account.account_balance = F('account_balance') + float(serializer.data['amount'])
                        savings_account.save()

                        return Response({"status":201, "data": {"details":savings_deposit_creation.data, "transaction_id":transation['transaction_id']}}, status=status.HTTP_201_CREATED)
                    
                    if serializer.data['method']==1:
                        if serializer.data['amount'] < savings_account.account_balance:
                            savings_withdraw_data = {
                                'related_savings_account_withdrawal':savings_account.pk,
                                'amount_withdrawn':serializer.data['amount'],
                                'fee_charged':0,
                                'withdraw_method':0,
                                'withdrawal_authorized_by':request.user.pk,
                                'withdrawal_cleared_by':request.user.pk
                            }

                            savings_withdraw_creation = SavingsWithdrawSaveSerializer(data=savings_withdraw_data)
                            savings_withdraw_creation.is_valid(raise_exception=True)
                            savings_withdraw_creation.save()

                            transation = TransactionProcedure.create_transaction(self, product_subscribed_to.pk, 1, serializer.data['amount'], request.user.pk, request.user.pk)

                            #update savings amount
                            savings_account.account_balance = F('account_balance') - float(serializer.data['amount'])
                            savings_account.save()

                            return Response({"status":201, "data": {"details":savings_withdraw_creation.data}}, status=status.HTTP_201_CREATED)
                        else:
                            return Response({"status":406, "error":"Insufficient balance on account"})

                else:
                    return Response({"status":400, "error":"Product isn't a savings product"})

            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except:
            return Response({"error":"Invalid account number, Please check the account number"}, status=status.HTTP_400_BAD_REQUEST)

class SavingHistoryListView(APIView):
    """
    List all savings deposits and create a savings deposit.
    """
    permission_classes = (permissions.IsAuthenticated, )

    def post(self, request, format=None):
        serializer = SavingsHistorySerializer(data=request.data)
        try:
            if serializer.is_valid():
                product_subscribed_to = ProductSubscriptions.objects.get(account_number=serializer.data['account_number'])

                if(product_subscribed_to.related_product_subscription.product_category==0):
                    savings_account = Savings.objects.get(related_savings_subscription=product_subscribed_to.pk)

                    if(serializer.data['method'] == 0):
                        savings_deposits = SavingsDepositSaveSerializer(SavingsDeposits.objects.filter(related_savings_account=savings_account.id), many=True)
                        return Response({"status":200, "data":savings_deposits.data}, status=status.HTTP_200_OK)

                    if(serializer.data['method'] == 1):
                        savings_withdrawals = SavingsWithdrawSaveSerializer(SavingsWithdrawal.objects.filter(related_savings_account_withdrawal=savings_account.id), many=True)
                        return Response({"status":200, "data":savings_withdrawals.data}, status=status.HTTP_200_OK)

                    if(serializer.data['method'] == 2):

                        return Response({"status":200, "data": savings_account.account_balance}, status=status.HTTP_200_OK)

                
                return Response({"status":404, "error":"savings account not found"}, status=status.HTTP_404_NOT_FOUND)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except:
            return Response({"error":"Invalid account number, Please check the account number"}, status=status.HTTP_400_BAD_REQUEST)
            
class SavingReportListView(APIView):
    """
    List all report deposits and create a savings deposit.
    """
    permission_classes = (permissions.IsAuthenticated, )
    
    def get(self, request, format=None):
        """
        @GET
        """
        try:
            data={"status":200, "data":self.process_saving_report()}            
            return Response(data)
        except Exception as e:
            return Response({"error":True, "msg":str(e)}, status=status.HTTP_400_BAD_REQUEST)

    def process_saving_report(self):
        """
        Begin processing saving report.
        """
        saving_report = []
        savings = Savings.objects.all()
        
        for sav in savings:
            deposit = SavingsDeposits.objects.filter(related_savings_account=sav)
            deposit_amount = 0.0
            
            if(deposit):
                
                # Just incase the saving returns more than one instance
                if(deposit.count() > 1):
                    for dep in deposit:
                        deposit_amount += dep.amount_deposited
                else:
                    deposit = deposit.first()
                    deposit_amount = deposit.amount_deposited
                    
            withdrawn = SavingsWithdrawal.objects.filter(related_savings_account_withdrawal=sav)
            withdrawn_amount = 0.0
            
            if(withdrawn):
                
                # Just incase the withdrawn returns more than one instance
                if(withdrawn.count() > 1):
                    for withd in withdrawn:
                        withdrawn_amount += withd.amount_withdrawn
                else:
                    withdrawn = withdrawn.first()
                    withdrawn_amount = withdrawn.amount_withdrawn
                    
            saving_report.append({
                "saving_type":sav.related_savings_subscription.related_product_subscription.product_name,
                "total_amount_deposited":deposit_amount,
                "total_amount_withdrawn":withdrawn_amount
                }
            )
        return saving_report
        
class SavingStatisticsListView(APIView):
    """
    Basic statistics for saving.
    """
    permission_classes = (permissions.IsAuthenticated, )
    
    def get(self, request, format=None):
        """
        @GET
        """
        try:
            data={"status":200, "data":self.filter_saving_by_date()}            
            return Response(data)
        except Exception as e:
            return Response({"error":True, "msg":str(e)}, status=status.HTTP_400_BAD_REQUEST)

    def filter_saving_by_date(self):
        """
        Filters all loan by current year and month
        """
        DEFAULT_MONTHS=[1,2,3,4,5,6,7,8,9,10,11,12] # This months don't change
        DEFAULT_MONTHS_NAME={1:"January", 2:"February", 3:"March", 4:"April", 5:"May", 6:"June", 7:"July", 8:"August",
                             9:"September", 10:"October", 11:"November", 12:"December"
                            } # This don't change
                            
        YEAR = datetime.datetime.now().year
        response = []
        
        for month in DEFAULT_MONTHS:
            response.append(
                {DEFAULT_MONTHS_NAME.get(month):Savings.objects.filter(date_created__year=YEAR, date_created__month=month).count()}
            )
        return response 
