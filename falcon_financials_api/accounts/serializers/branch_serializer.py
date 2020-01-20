from rest_framework import serializers
from ..models import Branch

# from ..serializers.user_serializer import UserSerializer

class BranchCreateSerializer(serializers.Serializer):
    """
    Create Serializer for the Branch details
    """
    branch_name         =   serializers.CharField(max_length=250)
    branch_location     =   serializers.CharField(max_length=250)
    branch_description  =   serializers.CharField(max_length=250)

class BranchSaveSerializer(serializers.ModelSerializer):
    """
    Save serializer for branch details
    """
    class Meta:
        model = Branch
        fields = ('id', 'branch_name', 'branch_location', 'branch_description')

class BranchDetailsSerializer(serializers.ModelSerializer):
    """
    Branch details serializer
    """
    # created_by = UserSerializer(read_only=True)
    class Meta:
        model = Branch
        fields =  ('id', 'branch_name', 'branch_location', 'branch_description', 'created_by', 'created_on')