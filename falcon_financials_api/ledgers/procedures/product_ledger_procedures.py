import uuid
import random

from ..models import ProductLedger
from ..serializers.product_ledger_serializer import ProductLedgerCreateSerializer

class ProductLedgerProcedure:

    def create_product_ledger(self, related_ledger_transaction, ledger_entry_type, amount):
        try:

            ledger_data = {
                'related_ledger_transaction': related_ledger_transaction,
                'ledger_entry_type':ledger_entry_type,
                'amount':amount
            }

            product_ledger_creation = ProductLedgerCreateSerializer(data=ledger_data)
            product_ledger_creation.is_valid(raise_exception=True)
            product_ledger_creation.save()
            return product_ledger_creation.data
        except: 
            return "Error"

    def get_product_ledger(self, serializer, product_id):
        try:
            transactions = serializer(self.ProductLedger.objects.all(), many=True)
            return transactions
        except:
            pass