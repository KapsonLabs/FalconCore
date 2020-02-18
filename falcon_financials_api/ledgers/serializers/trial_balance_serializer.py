from rest_framework import serializers
from accounts.serializers.client_serializer import ClientDetailsSerializer
from accounts.serializers.user_serializer import UserDetailsSerializer
from ..models import TrialBalanceLedger

class TrialBalanceCreateSerializer(serializers.ModelSerializer):
    """
    Save serializer for trnasactions
    """
    class Meta:
        model = TrialBalanceLedger
        fields = ('related_ledger_transaction', 'ledger_entry_type', 'amount')