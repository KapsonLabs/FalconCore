from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import permissions
from django.db.models import Q, F

from ..models import Product, ProductSubscriptions, ProductFeesLevied, Loans, LoansGuarantors, LoansDisbursements, LoanType, LoanTypeFeesApplicable
from ..serializers.loans_serializer import LoanSaveSerializer, LoanCreateSerializer, LoanGuarantorsSaveSerializer, LoanTypeSaveSerializer, LoanTypeFeesSaveSerializer, LoanTypeCreateSerializer

from ..serializers.savings_serializer import SavingsCreateSerializer

from ledgers.procedures.transaction_procedures import TransactionProcedure


class LoanTypeListView(APIView):
    """
    List all loan types and create a loan type.
    """
    permission_classes = (permissions.IsAuthenticated, )

    def get(self, request, format=None):
        product_code = self.request.query_params.get('product_code', None)
        product = Product.objects.get(product_code=product_code)
        serializer = LoanTypeSaveSerializer(LoanType.objects.filter(related_product=product), many=True)
        return Response({"status":200, "data":serializer.data}, status=status.HTTP_200_OK)

    def post(self, request, format=None):
        serializer = LoanTypeCreateSerializer(data=request.data)
        if serializer.is_valid():
            product_code = self.request.query_params.get('product_code', None)
            try:
                product = Product.objects.get(product_code=product_code)
                try:
                    existing_loan_type_code = LoanType.objects.get(loan_type_code=serializer.validated_data['loan_type_code'])
                    return Response({"status":400, "error":"Duplicate loan type code"}, status=status.HTTP_400_BAD_REQUEST)
                except:
                    loan_type_serializer = LoanTypeSaveSerializer(data={
                        "loan_type_name":serializer.validated_data['loan_type_name'],
                        "loan_type_description":serializer.validated_data['loan_type_description'],
                        "loan_type_code":serializer.validated_data['loan_type_code'],
                        "related_product":product.pk,
                        "loan_type_added_by": request.user.pk
                    })

                    loan_type_serializer.is_valid(raise_exception=True)
                    loan_type_serializer.save()

                    #create the loan type fees
                    try:
                        for fee in serializer.validated_data['fees']:
                            
                            loan_type_fees_serializer = LoanTypeFeesSaveSerializer(data={
                                "related_loan_type":loan_type_serializer.data['id'],
                                "related_loan_fee_category":serializer.validated_data['fees'][fee]['loan_fee_category'],
                                "amount":serializer.validated_data['fees'][fee]['amount'],
                                "added_by":request.user.pk
                            })
                            loan_type_fees_serializer.is_valid(raise_exception=True)
                            loan_type_fees_serializer.save()
                    except:
                        return Response({"status":400, "error":"Fess not being captured"})

                return Response({"status":200, "data":serializer.data}, status=status.HTTP_201_CREATED)
            except:
                return Response({"status":400, "error":"Bad product code"}, status=status.HTTP_400_BAD_REQUEST)
            # return Response({"status":201, "data":serializer.data}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class LoanTypeDetailView(APIView):
    """
    Retrieve a specific loan type with all it's related fees
    """

    def get(self, request, format=None):
        loan_type_code = self.request.query_params.get('loan_type_code', None)
        loan_type_serializer = LoanTypeSaveSerializer(LoanType.objects.get(loan_type_code=loan_type_code))
        loan_type_fees_serializer = LoanTypeFeesSaveSerializer(LoanTypeFeesApplicable.objects.filter(related_loan_type=loan_type_serializer.data['id']), many=True)
        return Response({"status":200, "loan_type":loan_type_serializer.data, "fees":loan_type_fees_serializer.data})


class LoanRequestListView(APIView):
    """
    List all loan requests and create a loan request.
    """
    permission_classes = (permissions.IsAuthenticated, )

    def get(self, request, pk,format=None):
        serializer = LoanCreateSerializer(Loans.objects.filter(related_loan_subscription=pk), many=True)
        return Response({"status":200, "data":serializer.data}, status=status.HTTP_200_OK)

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
                        transaction_data = {
                            'transaction_related_product':product_subscribed_to.pk,
                            'transaction_category':1,
                            'transaction_amount':serializer.data['amount'],
                            'transaction_cleared_by':request.user.pk,
                            'transaction_completed_by':request.user.pk
                        }

                        transation = TransactionProcedure.create_transaction(self, product_subscribed_to.pk, 1, serializer.data['amount'], request.user.pk, request.user.pk)
                        

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



class LoansHistoryListView(APIView):
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
