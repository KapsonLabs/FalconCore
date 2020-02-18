import uuid
import random

from ..models import Transaction
from ..serializers.transaction_seriaizer import TransactionCreateSerializer 

from .product_ledger_procedures import ProductLedgerProcedure
from .trial_balance_ledger_procedure import TrialBalanceLedgerProcedure

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

            #create the required ledger entry
            if transaction_category==0:
                ledger = ProductLedgerProcedure.create_product_ledger(self, transaction_creation.data['id'], 'DR', transaction_amount)
                trial_balance = TrialBalanceLedgerProcedure.create_trial_balance(self, transaction_creation.data['id'], 'CR', transaction_amount)
                print(trial_balance)

            if transaction_category==1:
                ledger = ProductLedgerProcedure.create_product_ledger(self, transaction_creation.data['id'], 'CR', transaction_amount)
                trial_balance = TrialBalanceLedgerProcedure.create_trial_balance(self, transaction_creation.data['id'], 'DR', transaction_amount)

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