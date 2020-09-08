from accounts.models import User

from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import permissions

from ..models import User, UserDetails, NotificationMessages
from ..serializers.user_serializer import (UserDetailsSerializer, UserCreateSerializer, UserShortDetailsSerializer, UserDetailsSaveSerializer, 
UserSerializer, NotificationMessagesSerializer
)

class UserNotifications(APIView):
    """
    List all users and create a user.
    """
    #permission_classes = (permissions.IsAuthenticated, )

    def get(self, request, format=None):
        serializer = NotificationMessagesSerializer(NotificationMessages.objects.all(), many=True)
        return Response({"status":200, "data":serializer.data}, status=status.HTTP_200_OK)

class UserListView(APIView):
    """
    List all users and create a user.
    """
    permission_classes = (permissions.IsAuthenticated, )

    def get(self, request, format=None):
        serializer = UserDetailsSerializer(UserDetails.objects.all(), many=True)
        return Response({"status":200, "data":serializer.data}, status=status.HTTP_200_OK)

    def post(self, request, format=None):
        serializer = UserCreateSerializer(data=request.data)
        if serializer.is_valid():
            #create user instance first
            user_data = {
                'username':serializer.data['username'],
                'first_name':serializer.data['first_name'],
                'last_name':serializer.data['last_name'],
                'email':serializer.data['email'],
                'password':serializer.data['password'],
                'phone_number':serializer.data['phone_number'],
            }

            user_creation = UserSerializer(data=user_data)
            user_creation.is_valid(raise_exception=True)
            user_creation.save()

            user_meta_data = {
                'related_user':user_creation.data['id'],
                'role':serializer.data['role'],
                'role_description':serializer.data['role_description'],
                'current_branch':serializer.data['current_branch'],
                'previous_branch':serializer.data['current_branch'],
            }


            user_meta_creation = UserDetailsSaveSerializer(data=user_meta_data)
            user_meta_creation.is_valid(raise_exception=True)
            user_meta_creation.save(created_by=request.user)
            return Response({"status":201, "data":user_meta_creation.data}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
