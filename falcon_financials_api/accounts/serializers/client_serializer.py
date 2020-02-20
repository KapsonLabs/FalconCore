from rest_framework import serializers
from ..models import Client, ClientBackgroundInformation

from ..serializers.user_serializer import UserSerializer

class ClientCreateSerializer(serializers.Serializer):
    """
    Create Serializer for the Client details
    """
    first_name              =   serializers.CharField(max_length=250)
    last_name               =   serializers.CharField(max_length=250)
    phone_number            =   serializers.CharField(max_length=250)
    email_address           =   serializers.CharField(max_length=250)
    client_type             =   serializers.IntegerField()
    client_branch           =   serializers.IntegerField()
    registration_date       =   serializers.DateField()
    sex                     =   serializers.CharField(max_length=10)
    address                 =   serializers.CharField(max_length=250)
    area_parish             =   serializers.CharField(max_length=250)
    area_village            =   serializers.CharField(max_length=250)
    area_subcounty          =   serializers.CharField(max_length=250)
    area_county             =   serializers.CharField(max_length=250)
    area_district           =   serializers.CharField(max_length=250)
    bank_verification_no    =   serializers.CharField(max_length=250)
    national_id_number      =   serializers.CharField(max_length=250)
    signature_mandate        =   serializers.CharField(max_length=250)
    signatory_loans_officer =   serializers.IntegerField()
    signatory_savings_officer = serializers.IntegerField()
    signatory_sales_officer  =  serializers.IntegerField()

class ClientSaveSerializer(serializers.ModelSerializer):
    """
    Save serializer for client details
    """
    class Meta:
        model = Client
        fields = ('id', 'related_user', 'client_account_number', 'client_type', 'client_branch', 'registration_date', 'sex', 'address', 'area_parish', 'area_village', 'area_county', 'area_subcounty', 'area_district', 'bank_verification_no', 'national_id_number', 'signature_mandate', 'signatory_loans_officer', 'signatory_savings_officer', 'signatory_sales_officer')

class ClientDetailsSerializer(serializers.ModelSerializer):
    """
    Client details serializer
    """
    related_user = UserSerializer(read_only=True)
    added_by     = UserSerializer(read_only=True)
    class Meta:
        model = Client
        fields = ('id', 'related_user', 'added_by', 'client_type', 'client_account_number', 'client_branch', 'registration_date', 'sex', 'address', 'area_parish', 'area_village', 'area_county', 'area_subcounty', 'area_district', 'bank_verification_no', 'national_id_number', 'signature_mandate', 'signatory_loans_officer', 'signatory_savings_officer', 'signatory_sales_officer')

class ClientShortDetailsSerializer(serializers.ModelSerializer):
    """
    Short details for client serializer
    """
    related_user = UserSerializer(read_only=True)
    class Meta:
        model = Client
        fields = ('id', 'related_user', 'client_account_number')

class ClientBackgroundInformationSerializer(serializers.ModelSerializer):
    """
    Serializer for client background information
    """
    class Meta:
        model = ClientBackgroundInformation
        fields = ('related_client')