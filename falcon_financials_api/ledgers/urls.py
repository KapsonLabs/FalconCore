from django.urls import path, include
from .views.product_ledger_view import ProductLedgerListView 
from .views.transaction_view import TransactionListView
from .views.trial_balance_ledger_view import TrialBalanceListView

urlpatterns = [
    path('ledgers/product_ledger/', ProductLedgerListView.as_view(), name="product_ledgers"),
    path('ledgers/transactions/', TransactionListView.as_view(), name="transactions"),
    path('ledgers/trial_balance/', TrialBalanceListView.as_view(), name="trial_balances")
]
