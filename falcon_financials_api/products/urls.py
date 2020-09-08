from django.urls import path, include
from .views.product_view import (ProductListView, ProductSubscriptionListView, ProductFeesListView, ProductClientSubscriptions,
ProductSubscriptionReport, ProductSubscriptionStatistics
)
from .views.savings_view import (SavingDepositListView, SavingHistoryListView, SavingReportListView,
SavingStatisticsListView
)
from .views.loans_view import (LoanRequestListView, LoanTypeListView, LoanTypeDetailView, LoansSpecificView, LoansDisbursementView,
LoanReports, LoanStatistics
)

urlpatterns = [
    path('products/', ProductListView.as_view(), name="products"),
    path('products/<int:pk>/subscriptions/', ProductSubscriptionListView.as_view(), name="product_subscriptions"),
    path('products/subscriptions/report/', ProductSubscriptionReport.as_view(), name="subscriptions_report"),
    path('products/subscriptions/statistics/', ProductSubscriptionStatistics.as_view(), name="subscriptions_stats"),
    
    path('products/<int:pk>/fees/', ProductFeesListView.as_view(), name="product_fees"),
    path('products/savings/', SavingDepositListView.as_view(), name="savings"),
    path('products/savings/history/', SavingHistoryListView.as_view(), name="savings_history"),
    path('products/savings/report/', SavingReportListView.as_view(), name="savings_report"),
    path('products/savings/statistics/', SavingStatisticsListView.as_view(), name="savings_stats"),
    
    path('products/client_subscriptions/', ProductClientSubscriptions.as_view(), name="client_subscriptions"),
    path('products/loans/', LoanRequestListView.as_view(), name='loans_request'), 
    path('products/loans/<int:pk>/', LoansSpecificView.as_view(), name='loans_specific'),
    path('products/loans/types/', LoanTypeListView.as_view(), name='loan_types'),
    path('products/loans/report/', LoanReports.as_view(), name='loan_report'),
    path('products/loans/statistics/', LoanStatistics.as_view(), name='loan_stats'),
    
    path('products/loans/types/detail/', LoanTypeDetailView.as_view(), name='loan_type_detail'),
    path('products/loans/<int:pk>/disburse/', LoansDisbursementView.as_view(), name='loans_disbursement'),
]
