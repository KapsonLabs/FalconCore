from rest_framework import serializers
from accounts.serializers.client_serializer import ClientDetailsSerializer
from accounts.serializers.user_serializer import UserDetailsSerializer
from .product_serializer import ProductSubscriptionDetailSerializer
from ..models import Loans, LoansGuarantors, LoansDisbursements, LoansDisbursementFeesLevied, LoansRepayments, LoansRepaymentsFeesLevied, LoanType, LoanTypeFeesApplicable, LoansDisbursements


class LoanTypeCreateSerializer(serializers.Serializer):
    loan_type_name     =   serializers.CharField(max_length=250)
    loan_type_description     =   serializers.CharField(max_length=250)
    loan_type_code     =   serializers.CharField(max_length=250)
    fees               =   serializers.DictField()

class LoanTypeSaveSerializer(serializers.ModelSerializer):
    """
    Save serializer for loan type creation
    """
    class Meta:
        model = LoanType
        fields = ('id', 'loan_type_name', 'loan_type_description', 'loan_type_code', 'loan_type_added_by', 'related_product')

class LoanTypeFeesSaveSerializer(serializers.ModelSerializer):
    """
    Save Serializer for loan type fees
    """
    class Meta:
        model = LoanTypeFeesApplicable
        fields = ('related_loan_type', 'related_loan_fee_category', 'amount',  'added_by')

class LoanSaveSerializer(serializers.ModelSerializer):
    """
    Save serializer for loans creation
    """
    class Meta:
        model = Loans
        fields = ('id', 'related_loan_subscription', 'related_loan_type_loans', 'loan_amount', 'loan_received_by', 'payment_duration', 'payment_period')

class LoanDetailsSerializer(serializers.ModelSerializer):
    """
    Details serializer for loans
    """
    related_loan_subscription = ProductSubscriptionDetailSerializer(read_only=True)
    class Meta:
        model = Loans
        fields = '__all__'

class LoanCreateSerializer(serializers.Serializer):
    account_number     =   serializers.CharField(max_length=250)
    loan_type          =   serializers.IntegerField()
    amount             =   serializers.IntegerField()
    payment_duration   =   serializers.IntegerField()
    payment_period     =   serializers.CharField(max_length=250)
    guarantors         =   serializers.DictField()


class LoanGuarantorsSaveSerializer(serializers.ModelSerializer):
    """
    Save serializer for loan guarantor creation
    """
    class Meta:
        model = LoansGuarantors
        fields = ('related_loan_guaranted', 'guarantor')

class LoanApproveSerializer(serializers.Serializer):
    action          = serializers.CharField(max_length=10)

class LoansDisbursementSerializer(serializers.ModelSerializer):
    model = LoansDisbursements
    fields = ('related_loan_disbursement' ,'amount_disbursed', 'disbursement_method', 'disbursement_cleared_by', 'disbursed_by')

