from django.urls import path, include
from .views.product_view import ProductListView, ProductSubscriptionListView, ProductFeesListView

urlpatterns = [
    path('products', ProductListView.as_view(), name="products"),
    path('products/<int:pk>/subscriptions', ProductSubscriptionListView.as_view(), name="product_subscriptions"),
    path('products/<int:pk>/fees', ProductFeesListView.as_view(), name="product_fees"),
]