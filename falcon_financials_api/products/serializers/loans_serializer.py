from rest_framework import serializers
from accounts.serializers.client_serializer import ClientDetailsSerializer
from accounts.serializers.user_serializer import UserDetailsSerializer
from ..models import Loans, LoansGuarantors, LoansDisbursements, LoansDisbursementFeesLevied, LoansRepayments, LoansRepaymentsFeesLevied

class LoanSaveSerializer(serializers.ModelSerializer):
    """
    Save serializer for loans creation
    """
    class Meta:
        model = Loans
        fields = ('related_loan_subscription', 'loan_amount', 'loan_received_by', 'status', 'payment_duration', 'payment_period')

class LoanCreateSerializer(serializers.Serializer):
    account_number     =   serializers.CharField(max_length=250)
    amount             =   serializers.IntegerField()
    payment_duration   =   serializers.IntegerField()
    payment_period     =   serializers.CharField(max_length=250)
    guarantor1         =   serializers.IntegerField() 
    guarantor2         =   serializers.IntegerField()
    guarantor3         =   serializers.IntegerField()


class LoanGuarantorsSaveSerializer(serializers.ModelSerializer):
    """
    Save serializer for loan guarantor creation
    """
    class Meta:
        model = LoansGuarantors
        fields = ('related_loan_guaranted', 'guarantor')

