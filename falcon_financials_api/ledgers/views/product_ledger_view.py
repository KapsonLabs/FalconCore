from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import permissions
from django.db.models import Q

from ..models import ProductLedger
from ..serializers.product_ledger_serializer import ProductLedgerCreateSerializer


class ProductLedgerListView(APIView):
    """
    List all product ledgers
    """
    permission_classes = (permissions.IsAuthenticated, )

    def get(self, request, format=None):
        serializer = ProductLedgerCreateSerializer(ProductLedger.objects.all(), many=True)
        return Response({"status":200, "data":serializer.data}, status=status.HTTP_200_OK)