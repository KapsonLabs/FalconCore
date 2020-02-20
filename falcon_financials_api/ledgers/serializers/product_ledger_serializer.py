from rest_framework import serializers
from accounts.serializers.client_serializer import ClientDetailsSerializer
from accounts.serializers.user_serializer import UserDetailsSerializer
from .transaction_seriaizer import TransactionCreateSerializer
from ..models import ProductLedger

class ProductLedgerCreateSerializer(serializers.ModelSerializer):
    """
    Save serializer for product ledgers
    """
    related_ledger_transaction = TransactionCreateSerializer(read_only=True)
    class Meta:
        model = ProductLedger
        fields = ('related_ledger_transaction', 'ledger_entry_type', 'amount')