from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import permissions
from django.db.models import Q, F
from rest_framework import status
import datetime 

from ..models import Product, ProductSubscriptions, ProductFeesLevied, Loans, LoansGuarantors, LoansDisbursements, LoanType, LoanTypeFeesApplicable
from ..serializers.loans_serializer import (LoanSaveSerializer, LoanCreateSerializer, LoanGuarantorsSaveSerializer, LoanTypeSaveSerializer, 
LoanTypeFeesSaveSerializer, LoanTypeCreateSerializer, LoanDetailsSerializer, LoanApproveSerializer, LoansDisbursementSerializer
)
from ..serializers.savings_serializer import SavingsCreateSerializer

from ledgers.procedures.transaction_procedures import TransactionProcedure


class LoanStatistics(APIView):
    """
    Process reports for a particular loans
    """
    permission_classes = (permissions.IsAuthenticated, )

    def get(self, request, format=None):
        """
        @GET
        """
        try:
            data={"status":200, "data":self.filter_loan_by_date()}            
            return Response(data)
        except Exception as e:
            return Response({"status":400, "error":str(e)}, status=status.HTTP_400_BAD_REQUEST)
            
    def filter_loan_by_date(self):
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
                {DEFAULT_MONTHS_NAME.get(month):Loans.objects.filter(date_requested__year=YEAR, date_requested__month=month).count()}
            )
        return response 
        
class LoanReports(APIView):
    """
    Process reports for a particular loans
    """
    permission_classes = (permissions.IsAuthenticated, )

    def get(self, request, format=None):
        """
        @GET
        """
        try:
            data={"status":200, "data":self.process_loan_report()}            
            return Response(data)
        except Exception as e:
            return Response({"status":400, "error":str(e)}, status=status.HTTP_400_BAD_REQUEST)
    
    def process_loan_report(self):
        """
        Performs basic loan processing
        """
        loans = Loans.objects.all()
        loan_report = []
        
        for loan in loans:
            disembursed = LoansDisbursements.objects.filter(related_loan_disbursement=loan).first()
            
            amount_disbursed = 0.0
            if(disembursed):
                amount_disbursed = disembursed.amount_disbursed
                
            loan_report.append({
                "loan_type":loan.related_loan_type_loans.loan_type_name,
                "total_amount_requested":loan.loan_amount,
                "total_amount_disbursed":amount_disbursed
            })
        return loan_report
        
class LoanTypeListView(APIView):
    """
    List all loan types and create a loan type.
    """
    permission_classes = (permissions.IsAuthenticated, )

    def get(self, request, format=None):
        try:
            
            product_code = self.request.query_params.get('product_code', None)
            product = Product.objects.get(product_code=product_code)
            serializer = LoanTypeSaveSerializer(LoanType.objects.filter(related_product=product), many=True)
            return Response({"status":200, "data":serializer.data}, status=status.HTTP_200_OK)
            
        except Product.DoesNotExist as e:
            response = {"status":404, "msg":str(e)}
            return Response(response)
            
        except LoanTypeSaveSerializer.DoesNotExist as e:
            response = {"status":404, "msg":str(e)}
            return Response(response)
            
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
        try:
            
            loan_type_code = self.request.query_params.get('loan_type_code', None)
            loan_type_serializer = LoanTypeSaveSerializer(LoanType.objects.get(loan_type_code=loan_type_code))
            loan_type_fees_serializer = LoanTypeFeesSaveSerializer(LoanTypeFeesApplicable.objects.filter(related_loan_type=loan_type_serializer.data['id']), many=True)
            return Response({"status":200, "loan_type":loan_type_serializer.data, "fees":loan_type_fees_serializer.data})
            
        except LoanType.DoesNotExist as e:
            response = {"status":404, "msg":str(e)}
            return Response(response)

class LoanRequestListView(APIView):
    """
    List all loan requests and create a loan request.
    """
    permission_classes = (permissions.IsAuthenticated, )

    def get(self, request, format=None):
        serializer = LoanSaveSerializer(Loans.objects.all(), many=True)
        return Response({"status":200, "data":serializer.data}, status=status.HTTP_200_OK)

    def post(self, request, format=None):
        serializer = LoanCreateSerializer(data=request.data)
        try:
            if serializer.is_valid():
                product_subscribed_to = ProductSubscriptions.objects.get(account_number=serializer.data['account_number'])

                loan_creation_serializer = LoanSaveSerializer(data={
                    "related_loan_subscription":product_subscribed_to.pk,
                    "related_loan_type_loans":serializer.validated_data['loan_type'],
                    "loan_amount":serializer.validated_data['amount'],
                    "loan_received_by":request.user.pk,
                    "payment_duration": serializer.validated_data['payment_duration'],
                    "payment_period": serializer.validated_data['payment_period']
                })

                loan_creation_serializer.is_valid(raise_exception=True)
                loan_creation_serializer.save()

                #create the loan type fees
                try:
                    for guarantor in serializer.validated_data['guarantors']:
                        
                        loan_guarantor_serializer = LoanGuarantorsSaveSerializer(data={
                            "related_loan_guaranted":loan_creation_serializer.data['id'],
                            "guarantor": serializer.validated_data['guarantors'][guarantor]
                        })
                        loan_guarantor_serializer.is_valid(raise_exception=True)
                        loan_guarantor_serializer.save()
                except:
                    return Response({"status":400, "error":"Guarantor addition failing"})

                return Response({"status":400, "loan_details":loan_creation_serializer.data})

            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except:
            return Response({"error":"Invalid account number, Please check the account number"}, status=status.HTTP_400_BAD_REQUEST)

class LoansSpecificView(APIView):
    """
    Actions that can be performed on a specific loam
    """
    permission_classes = (permissions.IsAuthenticated, )

    def get_object(self, pk):
        return Loans.objects.get(pk=pk)

    def get(self, request, pk):
        try:
            serializer = LoanDetailsSerializer(self.get_object(pk))
            return Response({"status":200, "data":serializer.data}, status=status.HTTP_200_OK)
        except Loans.DoesNotExist as e:
            response = {"status":404, "msg":str(e)}
            return Response(response)
            
    def post(self, request, pk):
        serializer = LoanApproveSerializer(data=request.data)
        if serializer.is_valid():
            if serializer.data['action']=="approve":
                Loans.objects.update_or_create(
                    id=pk, defaults={'status': 1}
                )
                return Response({"status":200, "data":"Successfully Approved"}, status=status.HTTP_200_OK) 
            else:
                Loans.objects.update_or_create(
                    id=pk, defaults={'status': 2}
                )
                return Response({"status":200, "data":"Successfully Declined"}, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class LoansDisbursementView(APIView):
    """
    Disburse Particular loan
    """
    permission_classes = (permissions.IsAuthenticated, )
    
    def post(self, request, pk, format=None):
        serializer = LoansDisbursementSerializer(data=request.data)
        if serializer.is_valid():
            
            loan_disbursement_serializer = LoansDisbursementSerializer(data={
                    "related_loan_disbursement":pk,
                    "amount_disbursed":serializer.validated_data['amount_disbursed'],
                    "disbursement_method":serializer.validated_data['disbursement_method'],
                    "disbursement_cleared_by":request.user.pk,
                    "disbursed_by": request.user.pk,
                })
            loan_disbursement_serializer.is_valid(raise_exception=True)
            loan_disbursement_serializer.save()
            return Response({"status":201, "data":loan_disbursement_serializer.data}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


