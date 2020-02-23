from rest_framework import serializers
from accounts.serializers.client_serializer import ClientDetailsSerializer
from accounts.serializers.user_serializer import UserDetailsSerializer
from .transaction_seriaizer import TransactionCreateSerializer, TransactionDetailSerializer
from ..models import TrialBalanceLedger

class TrialBalanceCreateSerializer(serializers.ModelSerializer):
    """
    Save serializer for trnasactions
    """
    class Meta:
        model = TrialBalanceLedger
        fields = ('related_trial_transaction', 'ledger_entry_type', 'amount')


class TrialBalanceDetailSerializer(serializers.ModelSerializer):
    """
    Save serializer for trnasactions
    """
    related_trial_transaction = TransactionDetailSerializer(read_only=True)
    class Meta:
        model = TrialBalanceLedger
        fields = ('related_trial_transaction', 'ledger_entry_type', 'amount')