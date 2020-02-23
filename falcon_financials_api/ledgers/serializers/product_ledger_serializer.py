from rest_framework import serializers
from accounts.serializers.client_serializer import ClientDetailsSerializer
from accounts.serializers.user_serializer import UserDetailsSerializer
from .transaction_seriaizer import TransactionCreateSerializer, TransactionDetailSerializer
from ..models import ProductLedger

class ProductLedgerCreateSerializer(serializers.ModelSerializer):
    """
    Save serializer for product ledgers
    """
    class Meta:
        model = ProductLedger
        fields = ('related_ledger_transaction', 'ledger_entry_type', 'amount')


class ProductLedgerDetailSerializer(serializers.ModelSerializer):
    """
    Save serializer for product ledgers
    """
    related_ledger_transaction = TransactionDetailSerializer(read_only=True)
    class Meta:
        model = ProductLedger
        fields = ('related_ledger_transaction', 'ledger_entry_type', 'amount')