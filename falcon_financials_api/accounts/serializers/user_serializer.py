from rest_framework import serializers
from ..models import User, UserDetails
from ..serializers.branch_serializer import BranchDetailsSerializer

class UserCreateSerializer(serializers.Serializer):
    """
    Create Serializer for the User and Details models
    """
    username            =   serializers.CharField(max_length=250)
    first_name          =   serializers.CharField(max_length=250)
    last_name           =   serializers.CharField(max_length=250)
    email               =   serializers.CharField(max_length=250)
    password            =   serializers.CharField(max_length=250)
    role                =   serializers.CharField(max_length=250)
    role_description    =   serializers.CharField(max_length=250)
    phone_number        =   serializers.CharField(max_length=250)
    current_branch      =   serializers.IntegerField()


class UserSerializer(serializers.ModelSerializer):
    """
    Model serializer for the User Model
    """
    password = serializers.CharField(write_only=True)

    class Meta:
        model = User
        fields = ('id', 'first_name', 'last_name', 'email', 'password', 'phone_number')


class UserShortDetailsSerializer(serializers.ModelSerializer):
    """
    Model serializer for the UserDetails Model
    """
    related_user = UserSerializer(read_only=True)
    class Meta:
        model = UserDetails
        fields = ('id', 'related_user', 'role', 'assigned_on')


class UserDetailsSerializer(serializers.ModelSerializer):
    """
    Model serializer for the UserDetails Model
    """
    related_user = UserSerializer(read_only=True)
    created_by  = UserSerializer(read_only=True)
    current_branch = BranchDetailsSerializer(read_only=True)
    previous_branch = BranchDetailsSerializer(read_only=True)
    class Meta:
        model = UserDetails
        fields = ('id', 'related_user', 'created_by' , 'role', 'role_description', 'current_branch', 'previous_branch', 'transfered_on', 'assigned_on')