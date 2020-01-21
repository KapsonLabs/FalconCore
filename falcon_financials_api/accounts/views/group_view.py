from accounts.models import User

from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import permissions

from ..models import Group, GroupClients
from ..serializers.group_serializer import GroupSaveSerializer, GroupDetailsSerializer, GroupClientDetailSerializer, GroupClientCreateSerializer, GroupClientSaveSerializer


class GroupListView(APIView):
    """
    List all groups and create a group.
    """
    permission_classes = (permissions.IsAuthenticated, )

    def get(self, request, format=None):
        serializer = GroupDetailsSerializer(Group.objects.all(), many=True)
        return Response({"status":200, "data":serializer.data}, status=status.HTTP_200_OK)

    def post(self, request, format=None):
        serializer = GroupSaveSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({"status":201, "data":serializer.data}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class GroupClientListView(APIView):
    """
    List all group clients and add a client to a group
    """
    permission_classes = (permissions.IsAuthenticated, )

    def get(self, request, pk, format=None):
        serializer = GroupClientDetailSerializer(GroupClients.objects.filter(related_group=pk), many=True)
        return Response({"status":200, "data":serializer.data}, status=status.HTTP_200_OK)

    def post(self, request, pk, format=None):
        serializer = GroupClientCreateSerializer(data=request.data)
        if serializer.is_valid():
            
            group_client_data = {
                'related_group': pk,
                'related_client': serializer.data['related_client']
            }

            group_client_creation = GroupClientSaveSerializer(data=group_client_data)
            group_client_creation.is_valid(raise_exception=True)
            group_client_creation.save()

            return Response({"status":201, "data":group_client_creation.data}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
