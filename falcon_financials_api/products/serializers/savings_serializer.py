from rest_framework import serializers
from accounts.serializers.client_serializer import ClientDetailsSerializer
from accounts.serializers.user_serializer import UserDetailsSerializer
from ..models import Savings, SavingsDeposits, SavingsWithdrawal

class SavingsCreateSerializer(serializers.ModelSerializer):
    """
    Save serializer for savings accounts
    """
    class Meta:
        model = Savings
        fields = ('related_savings_subscription', 'account_balance', 'account_status')

class SavingsDepositeCreateSerializer(serializers.ModelSerializer):
    """
    save serializer for savings deposits
    """
    class Meta:
        model = SavingsDeposits
        fields = ('related_savings_account', 'amount_deposited', 'fee_charged', 'deposit_method', 'deposit_received_by', 'deposit_created_by')

# class ProductSubscriptionCreateSerializer(serializers.Serializer):
#     related_client  = serializers.IntegerField()

# class ProductSubscriptionSaveSerializer(serializers.ModelSerializer):
#     related_product_subscription = ProductDetailsSerializer(read_only=True)
#     related_client_subscription = ClientDetailsSerializer(read_only=True)
#     class Meta:
#         model = ProductSubscriptions
#         fields = ('related_product_subscription', 'related_client_subscription', 'account_number')


# class ProductFeesCreateSerializer(serializers.Serializer):
#     fee_category        =   serializers.IntegerField()
#     percentage_levied   =   serializers.IntegerField()
#     fee_levied          =   serializers.IntegerField()
#     frequency_levied    =   serializers.IntegerField()

# class ProductFeesSaveSerializer(serializers.ModelSerializer):
#     """
#     Create serializer for Product fees
#     """
#     class Meta:
#         model = ProductFeesLevied
#         fields = ('related_product_fees', 'fee_category', 'percentage_levied', 'fee_levied', 'frequency_levied')

# class ProductFeesDetailSerializer(serializers.ModelSerializer):
#     """
#     Create serializer for Product fees
#     """
#     related_product_fees = ProductDetailsSerializer(read_only=True)
#     class Meta:
#         model = ProductFeesLevied
#         fields = ('related_product_fees', 'fee_category', 'percentage_levied', 'fee_levied', 'frequency_levied', 'fees_added_by', 'added_on')