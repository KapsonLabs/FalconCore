from django.db import models
from django.contrib.auth.models import AbstractUser

class User(AbstractUser):
    phone_number        =   models.CharField(max_length=12)

class Branch(models.Model):
    branch_name         =   models.CharField(max_length=250)    
    branch_location     =   models.CharField(max_length=250)
    branch_description  =   models.TextField(null=True, blank=True)
    created_by          =   models.ForeignKey(User, on_delete=models.CASCADE, related_name='branch_creator')
    created_on          =   models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return "{} branch located in {}".format(self.branch_name, self.branch_location)

class UserDetails(models.Model):
    related_user        =   models.ForeignKey(User, on_delete=models.CASCADE, related_name='related_user')
    created_by          =   models.ForeignKey(User, on_delete=models.CASCADE, related_name='user_creator')
    role                =   models.CharField(max_length=250, null=True, blank=True)
    role_description    =   models.TextField(null=True, blank=True)
    current_branch      =   models.ForeignKey(Branch, on_delete=models.CASCADE, related_name='current_branch')
    previous_branch     =   models.ForeignKey(Branch, on_delete=models.CASCADE, related_name='previous_branch')
    transfered_on       =   models.DateTimeField(auto_now_add=False, null=True, blank=True)
    assigned_on         =   models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return "{} belongs to {} branch".format(self.related_user, self.current_branch.branch_name)

class Client(models.Model):
    related_user        =   models.ForeignKey(User, on_delete=models.CASCADE, related_name='client')
    added_by            =   models.ForeignKey(User, on_delete=models.CASCADE, related_name='client_creator')
    client_type         =   models.IntegerField()
    client_branch       =   models.ForeignKey(Branch, on_delete=models.CASCADE, related_name='client_branch')
    registration_date   =   models.DateField(null=True, blank=True)
    sex                 =   models.CharField(max_length=12, null=True, blank=True)
    address             =   models.CharField(max_length=50, null=True, blank=True)
    area_parish         =   models.CharField(max_length=50, null=True, blank=True)
    area_village        =   models.CharField(max_length=50, null=True, blank=True)
    area_county         =   models.CharField(max_length=50, null=True, blank=True)
    area_subcounty      =   models.CharField(max_length=50, null=True, blank=True)
    area_district       =   models.CharField(max_length=50, null=True, blank=True)
    bank_verification_no=   models.CharField(max_length=50, null=True, blank=True)
    national_id_number  =   models.CharField(max_length=50, null=True, blank=True)
    signature_mandate           = models.TextField()
    signatory_loans_officer     = models.ForeignKey(User, on_delete=models.CASCADE, related_name='signatory_loans_officer')
    signatory_savings_officer   = models.ForeignKey(User, on_delete=models.CASCADE, related_name='signatory_savings_officer')
    signatory_sales_officer     = models.ForeignKey(User, on_delete=models.CASCADE, related_name='signatory_sales_officer')
    added_on            =   models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return "{} belongs to {} branch".format(self.related_user.first_name, self.client_branch.branch_name)

class ClientBackgroundInformation(models.Model):
    related_client        =   models.ForeignKey(User, on_delete=models.CASCADE, related_name='client_portfolio')
    outstanding_portfolio       =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    portfolio_at_risk           =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    operating_cost_ratio        =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    debt_equity_ratio           =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    operating_self_sufficiency  =   models.DecimalField(max_digits=20, decimal_places=2, default=0)


class Group(models.Model):
    group_name          =   models.CharField(max_length=250) 
    related_branch      =   models.ForeignKey(Branch, on_delete=models.CASCADE, related_name='group_branch')
    group_type          =   models.IntegerField(null=True, blank=True)
    created_on          =   models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return "{}".format(self.group_name)

class GroupClients(models.Model):
    related_group       =   models.ForeignKey(Group, on_delete=models.CASCADE, related_name='client_group')
    related_client      =   models.ForeignKey(Client, on_delete=models.CASCADE, related_name='related_client')
    added_on            =   models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return "{} belongs to {} group".format(self.related_client, self.related_group)

