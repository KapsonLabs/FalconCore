from django.urls import path, include
from .views.product_view import ProductListView, ProductSubscriptionListView, ProductFeesListView
from .views.savings_view import SavingDepositListView, SavingHistoryListView
from .views.loans_view import LoanRequestListView

urlpatterns = [
    path('products', ProductListView.as_view(), name="products"),
    path('products/<int:pk>/subscriptions', ProductSubscriptionListView.as_view(), name="product_subscriptions"),
    path('products/<int:pk>/fees', ProductFeesListView.as_view(), name="product_fees"),
    path('products/savings', SavingDepositListView.as_view(), name="savings"),
    path('products/savings/history', SavingHistoryListView.as_view(), name="savings_history"),
    path('products/<int:pk>/loans', LoanRequestListView.as_view(), name='loans_request') 
]