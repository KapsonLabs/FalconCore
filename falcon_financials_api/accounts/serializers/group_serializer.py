from rest_framework import serializers
from ..models import Group, GroupClients

from ..serializers.branch_serializer import BranchDetailsSerializer

class GroupSaveSerializer(serializers.ModelSerializer):
    """
    Save serializer for group details
    """
    class Meta:
        model = Group
        fields = ('id', 'group_name', 'related_branch', 'group_type')

class GroupDetailsSerializer(serializers.ModelSerializer):
    """
    group details serializer
    """
    related_branch = BranchDetailsSerializer(read_only=True)
    class Meta:
        model = Group
        fields = ('id', 'group_name', 'related_branch', 'group_type','created_on')

class GroupClientCreateSerializer(serializers.Serializer):
    related_client  = serializers.IntegerField()

class GroupClientSaveSerializer(serializers.ModelSerializer):
    class Meta:
        model = GroupClients
        fields = ('related_group', 'related_client')

class GroupClientDetailSerializer(serializers.ModelSerializer):
    class Meta:
        model = GroupClients
        fields = ('related_group', 'related_client', 'added_on')
