from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import permissions
from django.db.models import Q

from ..models import Transaction
from ..serializers.transaction_seriaizer import TransactionCreateSerializer, TransactionDetailSerializer


class TransactionListView(APIView):
    """
    List all transactions
    """
    permission_classes = (permissions.IsAuthenticated, )

    def get(self, request, format=None):
        serializer = TransactionDetailSerializer(Transaction.objects.all(), many=True)
        return Response({"status":200, "data":serializer.data}, status=status.HTTP_200_OK)