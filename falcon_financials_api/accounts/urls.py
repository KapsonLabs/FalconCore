from django.urls import path, include
from .views.login_view import LoginView
from .views.branch_view import BranchListView
from .views.user_view import UserListView
from .views.group_view import GroupListView, GroupClientListView
from .views.client_view import ClientListView

urlpatterns = [
    path('authorization/', LoginView.as_view(), name="auth-login"),
    path('accounts/branches', BranchListView.as_view(), name="branches"),
    path('accounts/users', UserListView.as_view(), name="users"),
    path('accounts/groups', GroupListView.as_view(), name="groups"),
    path('accounts/clients', ClientListView.as_view(), name="clients"),
    path('accounts/groups/<int:pk>/clients', GroupClientListView.as_view(), name="groupclients")
]