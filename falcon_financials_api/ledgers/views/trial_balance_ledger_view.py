from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import permissions
from django.db.models import Q

from ..models import TrialBalanceLedger
from ..serializers.trial_balance_serializer import TrialBalanceCreateSerializer, TrialBalanceDetailSerializer


class TrialBalanceListView(APIView):
    """
    List all trial balances
    """
    permission_classes = (permissions.IsAuthenticated, )

    def get(self, request, format=None):
        serializer = TrialBalanceDetailSerializer(TrialBalanceLedger.objects.all(), many=True)
        return Response({"status":200, "data":serializer.data}, status=status.HTTP_200_OK)
