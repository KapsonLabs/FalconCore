from accounts.models import User
from django.contrib.auth import authenticate, login
from rest_framework import permissions
from accounts.serializers.token_serializer import TokenSerializer
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from ..serializers.user_serializer import UserDetailsSerializer, UserSerializer
from rest_framework_simplejwt.tokens import RefreshToken

def get_tokens_for_user(user):
    refresh = RefreshToken.for_user(user)

    return {
        'refresh': str(refresh),
        'token': str(refresh.access_token),
    }

class LoginView(APIView):
    """
    POST authorization/
    """
    # This permission class will overide the global permission
    # class setting
    permission_classes = (permissions.AllowAny,)


    def post(self, request, *args, **kwargs):
        username = request.data.get("username", "")
        password = request.data.get("password", "")
        user = authenticate(request, username=username, password=password)
        if user is not None:
            # login saves the user’s ID in the session,
            # using Django’s session framework.
            login(request, user)
            tokens = get_tokens_for_user(user)
            user_serializer = UserSerializer(user)
            login_data = {"user_data":user_serializer.data, "token_data":tokens}
            return Response(login_data)
        return Response(status=status.HTTP_404_NOT_FOUND)