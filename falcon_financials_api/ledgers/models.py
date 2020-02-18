from django.db import models
from accounts.models import User, Client
from products.models import Product, ProductSubscriptions, Savings, SavingsDeposits, SavingsWithdrawal

from .choices import CATEGORY_CLASS, LEDGER_ENTRY_TYPE

class CategoryClass(models.Model):
    category_name   =   models.CharField(max_length=250) 
    category_class  =   models.CharField(max_length=250, choices=CATEGORY_CLASS) 
    date_created    =   models.DateTimeField(auto_now_add=True)

class ChartOfAccounts(models.Model):
    related_category    =   models.ForeignKey(CategoryClass, on_delete=models.CASCADE, related_name="related_category") 
    account_code        =   models.CharField(max_length=250)
    account_name        =   models.CharField(max_length=250)
    chart_level         =   models.IntegerField()
    is_final_level      =   models.BooleanField(default=False)
    date_created        =   models.DateTimeField(auto_now_add=True)


class Transaction(models.Model):
    transaction_id              =   models.CharField(max_length=250) 
    transaction_related_product =   models.ForeignKey(ProductSubscriptions, on_delete=models.CASCADE, related_name="related_transaction_product")
    transaction_description     =   models.CharField(max_length=250, null=True, blank=True) 
    transaction_category        =   models.IntegerField()  #0-savingsdeposit, 1-savingswithdrawal 2-loansdisbursement 3-loanrepayment 4-Fees
    transaction_amount          =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    transaction_cleared_by      =   models.ForeignKey(User, on_delete=models.CASCADE, related_name="transaction_clearer")
    transaction_completed_by    =   models.ForeignKey(User, on_delete=models.CASCADE, related_name="transaction_completer")
    date_created                =   models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return "{} transaction performed on {} ".format(self.transaction_id, self.date_created)

class ProductLedger(models.Model):
    related_ledger_transaction      =   models.ForeignKey(Transaction, on_delete=models.CASCADE, related_name="related_transaction_product_ledger")
    ledger_entry_type               =   models.CharField(max_length=250, choices=LEDGER_ENTRY_TYPE)
    amount                          =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    date_entered                    =   models.DateTimeField(auto_now_add=True)


class ChartLevelLedger(models.Model):
    related_chart_transaction       =   models.ForeignKey(Transaction, on_delete=models.CASCADE, related_name="related_transaction_product_chart_ledger")
    ledger_entry_type               =   models.CharField(max_length=250, choices=LEDGER_ENTRY_TYPE)
    amount                          =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    date_entered                    =   models.DateTimeField(auto_now_add=True)


class TrialBalanceLedger(models.Model):
    related_trial_transaction   =   models.ForeignKey(Transaction, on_delete=models.CASCADE, related_name="related_transaction_trial_balance")
    ledger_entry_type           =   models.CharField(max_length=250, choices=LEDGER_ENTRY_TYPE)
    amount                      =   models.DecimalField(max_digits=20, decimal_places=2, default=0)   
    date_entered                =   models.DateTimeField(auto_now_add=True)


class EndOfPeriod(models.Model):
    period_start            =   models.DateTimeField(auto_now_add=False)
    period_end              =   models.DateTimeField(auto_now_add=False)
    period_started_by       =   models.ForeignKey(User, on_delete=models.CASCADE, related_name="period_started_by")  
    period_ended_by         =   models.ForeignKey(User, on_delete=models.CASCADE, related_name="period_ended_by")


#INCOME STATEMENT
#BALANCE SHEET
#PROFIT AND LOSS STATEMENT



