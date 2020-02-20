from rest_framework import serializers
from accounts.serializers.client_serializer import ClientDetailsSerializer, ClientShortDetailsSerializer
from ..models import Product, ProductFeesLevied, ProductSubscriptions

class ProductCreateSerializer(serializers.ModelSerializer):
    """
    Save serializer for product details
    """
    class Meta:
        model = Product
        fields = ('id', 'product_name', 'product_code', 'product_description', 'product_category')

class ProductDetailsSerializer(serializers.ModelSerializer):
    """
    Details serializer for product details
    """
    class Meta:
        model = Product
        fields = ('id', 'product_name', 'product_code' ,'product_description', 'product_category', 'created_by', 'date_created')

class ProductShortDetailsSerializer(serializers.ModelSerializer):
    """
    SHort Details serializer for product
    """
    class Meta:
        model = Product
        fields = ('product_name', 'product_code') 


class ProductSubscriptionCreateSerializer(serializers.Serializer):
    related_client  = serializers.IntegerField()

class ProductSubscriptionSaveSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductSubscriptions
        fields = ('id', 'related_product_subscription', 'related_client_subscription', 'account_number')


class ProductSubscriptionDetailSerializer(serializers.ModelSerializer):
    related_product_subscription = ProductDetailsSerializer(read_only=True)
    related_client_subscription = ClientDetailsSerializer(read_only=True)
    class Meta:
        model = ProductSubscriptions
        fields = ('related_product_subscription', 'related_client_subscription', 'account_number', 'added_by', 'subscription_status', 'date_subscribed')

class ProductSubscriptionShortDetailSerializer(serializers.ModelSerializer):
    related_product_subscription = ProductShortDetailsSerializer(read_only=True)
    related_client_subscription = ClientShortDetailsSerializer(read_only=True)
    class Meta:
        model = ProductSubscriptions
        fields = ('related_product_subscription', 'related_client_subscription', 'account_number')


class ProductFeesCreateSerializer(serializers.Serializer):
    fee_category        =   serializers.IntegerField()
    percentage_levied   =   serializers.IntegerField()
    fee_levied          =   serializers.IntegerField()
    frequency_levied    =   serializers.IntegerField()

class ProductFeesSaveSerializer(serializers.ModelSerializer):
    """
    Create serializer for Product fees
    """
    class Meta:
        model = ProductFeesLevied
        fields = ('related_product_fees', 'fee_category', 'percentage_levied', 'fee_levied', 'frequency_levied')

class ProductFeesDetailSerializer(serializers.ModelSerializer):
    """
    Create serializer for Product fees
    """
    related_product_fees = ProductDetailsSerializer(read_only=True)
    class Meta:
        model = ProductFeesLevied
        fields = ('related_product_fees', 'fee_category', 'percentage_levied', 'fee_levied', 'frequency_levied', 'fees_added_by', 'added_on')

class ClientProductSubscriptionSerializer(serializers.Serializer):
    client_account_number   =   serializers.CharField(max_length=200)