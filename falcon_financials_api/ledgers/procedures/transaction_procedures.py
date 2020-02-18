import uuid
import random

from ..models import Transaction
from ..serializers.transaction_seriaizer import TransactionCreateSerializer 

class TransactionProcedure:

    @staticmethod
    def generate_transaction_id():
        return str(uuid.uuid4())

    def create_transaction(self, transaction_related_product, transaction_category, transaction_amount, transaction_cleared_by, transaction_completed_by):
        try:
            transaction_id = random.randint(1000000, 9999999)

            transaction_data = {
                'transaction_id': transaction_id,
                'transaction_related_product':transaction_related_product,
                'transaction_category':transaction_category,
                'transaction_amount':transaction_amount,
                'transaction_cleared_by':transaction_cleared_by,
                'transaction_completed_by':transaction_completed_by
            }

            transaction_creation = TransactionCreateSerializer(data=transaction_data)
            transaction_creation.is_valid(raise_exception=True)
            transaction_creation.save()
            return transaction_creation.data
        except: 
            return "Error"

    def get_transactions(self, serializer):
        try:
            transactions = serializer(self.Transaction.objects.all(), many=True)
            return transactions
        except:
            pass

    def get_individual_transaction(self, serializer, transaction_id):
        try:
            pass

        except:
            pass