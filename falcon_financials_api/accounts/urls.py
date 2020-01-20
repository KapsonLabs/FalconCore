from django.urls import path, include
from .views.login_view import LoginView
from .views.branch_view import BranchListView
from .views.user_view import UserListView

urlpatterns = [
    path('authorization/', LoginView.as_view(), name="auth-login"),
    path('accounts/branches', BranchListView.as_view(), name="branches"),
    path('accounts/users', UserListView.as_view(), name="users")
]