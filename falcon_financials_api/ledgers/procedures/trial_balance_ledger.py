import uuid
import random

from ..models import TrialBalanceLedger
from ..serializers.trial_balance_serializer import TrialBalanceLedger

class TrialBalanceLedgerProcedure:

    def create_trial_balance(self, related_ledger_transaction, ledger_entry_type, amount):
        try:

            trial_balance_data = {
                'related_ledger_transaction': related_ledger_transaction,
                'ledger_entry_type':ledger_entry_type,
                'amount':amount
            }

            trial_balance_creation = TrialBalanceLedger(data=ledger_data)
            trial_balance_creation.is_valid(raise_exception=True)
            trial_balance_creation.save()
            return trial_balance_creation.data
        except: 
            return "Error"

    def get_product_ledger(self, serializer, product_id):
        try:
            transactions = serializer(self.TrialBalanceLedger.objects.all(), many=True)
            return transactions
        except:
            pass