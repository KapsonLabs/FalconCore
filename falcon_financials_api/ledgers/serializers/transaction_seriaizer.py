from rest_framework import serializers
from accounts.serializers.client_serializer import ClientDetailsSerializer
from accounts.serializers.user_serializer import UserDetailsSerializer
from ..models import Transaction

class TransactionCreateSerializer(serializers.ModelSerializer):
    """
    Save serializer for trnasactions
    """
    class Meta:
        model = Transaction
        fields = ('id' ,'transaction_id', 'transaction_related_product', 'transaction_category', 'transaction_amount', 'transaction_cleared_by', 'transaction_completed_by')