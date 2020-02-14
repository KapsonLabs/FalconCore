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

class SavingsDepositAndWithdrawCreateSerializer(serializers.Serializer):
    method             =   serializers.IntegerField()
    account_number     =   serializers.CharField(max_length=250)
    amount             =   serializers.IntegerField()


class SavingsHistorySerializer(serializers.Serializer):
    method             =   serializers.IntegerField()
    account_number     =   serializers.CharField(max_length=250)


class SavingsDepositSaveSerializer(serializers.ModelSerializer):
    """
    save serializer for savings deposits
    """
    class Meta:
        model = SavingsDeposits
        fields = ('related_savings_account', 'amount_deposited', 'fee_charged', 'deposit_method', 'deposit_received_by', 'deposit_cleared_by')

class SavingsWithdrawSaveSerializer(serializers.ModelSerializer):
    """
    save serializer for savings withdraws
    """
    class Meta:
        model = SavingsWithdrawal
        fields = ('related_savings_account_withdrawal', 'amount_withdrawn', 'fee_charged', 'withdraw_method', 'withdrawal_authorized_by', 'withdrawal_cleared_by')

