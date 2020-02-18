from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import permissions
from django.db.models import Q, F

from ..models import Product, ProductSubscriptions, ProductFeesLevied, Savings, SavingsDeposits, SavingsWithdrawal
from ..serializers.savings_serializer import SavingsDepositAndWithdrawCreateSerializer, SavingsDepositSaveSerializer, SavingsWithdrawSaveSerializer, SavingsHistorySerializer

from ..serializers.savings_serializer import SavingsCreateSerializer

from ledgers.procedures.transaction_procedures import TransactionProcedure



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
                        pass

                    if(serializer.data['method'] == 1):
                        pass

                    if(serializer.data['method'] == 2):

                        return Response({"status":200, "data": savings_account.account_balance}, status=status.HTTP_200_OK)

                
                return Response({"status":404, "error":"savings account not found"}, status=status.HTTP_404_NOT_FOUND)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except:
            return Response({"error":"Invalid account number, Please check the account number"}, status=status.HTTP_400_BAD_REQUEST)
