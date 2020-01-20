from accounts.models import User

from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import permissions

from ..models import User, UserDetails
from ..serializers.user_serializer import UserDetailsSerializer, UserCreateSerializer, UserShortDetailsSerializer


class UserListView(APIView):
    """
    List all users and create a user.
    """
    permission_classes = (permissions.IsAuthenticated, )

    def get(self, request, format=None):
        serializer = UserDetailsSerializer(UserDetails.objects.all(), many=True)
        return Response({"status":200, "data":serializer.data}, status=status.HTTP_200_OK)

    def post(self, request, format=None):
        serializer = BranchCreateSerializer(data=request.data)
        if serializer.is_valid():
            branch_data = {
                'branch_name':serializer.data['branch_name'],
                'branch_location':serializer.data['branch_location'],
                'branch_description':serializer.data['branch_description'],
            }

            branch_creation = BranchSaveSerializer(data=branch_data)
            branch_creation.is_valid(raise_exception=True)
            branch_creation.save(created_by=request.user)
            return Response({"status":201, "data":branch_creation.data}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
