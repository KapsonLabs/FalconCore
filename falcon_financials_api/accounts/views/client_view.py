from accounts.models import User

from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import permissions

from ..models import User, Client
from ..serializers.user_serializer import UserSerializer
from ..serializers.client_serializer import ClientCreateSerializer, ClientSaveSerializer, ClientBackgroundInformation, ClientDetailsSerializer


class ClientListView(APIView):
    """
    List all clients and create a client.
    """
    permission_classes = (permissions.IsAuthenticated, )

    def get(self, request, format=None):
        serializer = ClientDetailsSerializer(Client.objects.all(), many=True)
        return Response({"status":200, "data":serializer.data}, status=status.HTTP_200_OK)

    def post(self, request, format=None):
        serializer = ClientCreateSerializer(data=request.data)
        if serializer.is_valid():
            #create user instance first
            user_data = {
                'username':'A010',
                'first_name':serializer.data['first_name'],
                'last_name':serializer.data['last_name'],
                'email':serializer.data['email_address'],
                'password':'default123',
                'phone_number':serializer.data['phone_number'],
            }

            user_creation = UserSerializer(data=user_data)
            user_creation.is_valid(raise_exception=True)
            user_creation.save()

            # user_instance = User.objects.get(pk=user_creation.data['id'])

            #create client instance next
            client_data = {
                'related_user':         user_creation.data['id'],
                'client_type':          serializer.data['client_type'],    
                'client_branch':        serializer.data['client_branch'],
                'registration_date':    serializer.data['registration_date'],
                'sex':                  serializer.data['sex'],    
                'address':              serializer.data['address'],
                'area_parish':          serializer.data['area_parish'],
                'area_village':         serializer.data['area_village'],
                'area_county':          serializer.data['area_county'],
                'area_subcounty':       serializer.data['area_subcounty'],
                'area_district':        serializer.data['area_district'],
                'bank_verification_no': serializer.data['bank_verification_no'],
                'national_id_number':   serializer.data['national_id_number'],
                'signature_mandate':    serializer.data['signature_mandate'],
                'signatory_loans_officer': serializer.data['signatory_loans_officer'],
                'signatory_savings_officer': serializer.data['signatory_savings_officer'],
                'signatory_sales_officer':  serializer.data['signatory_sales_officer'],
            }

            client_creation = ClientSaveSerializer(data=client_data)
            client_creation.is_valid(raise_exception=True)
            client_creation.save(added_by=request.user)

            #create a background information record
            client_background = {
                'related_client': client_creation.data['id']
            }

            client_backgound_creation = ClientSaveSerializer(data=client_background)
            client_backgound_creation.is_valid(raise_exception=True)
            client_backgound_creation.save()

            return Response({"status":201, "data":client_creation.data}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)