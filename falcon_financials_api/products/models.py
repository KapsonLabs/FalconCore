from django.db import models
from accounts.models import User, Client

class Product(models.Model):
    product_name            =   models.CharField(max_length=250) 
    product_description     =   models.CharField(max_length=250) 
    product_category        =   models.IntegerField()  #0-savings 1-loans
    created_by              =   models.ForeignKey(User, on_delete=models.CASCADE, related_name='product_creator')
    date_created            =   models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return "{} product created on {} ".format(self.product_name, self.date_created)

class ProductSubscriptions(models.Model):
    related_product         =   models.ForeignKey(Product, on_delete=models.CASCADE, related_name="related_product")
    related_client          =   models.ForeignKey(Client, on_delete=models.CASCADE, related_name="related_client")
    account_number          =   models.CharField(max_length=25)
    added_by                =   models.ForeignKey(User, on_delete=models.CASCADE, related_name="related_user_subscriber")
    subscription_status     =   models.BooleanField(default=True)
    date_subscribed         =   models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return "{} subscribed to {} ".format(self.related_client, self.related_product)

class ProductFeesLevied(models.Model):
    related_product         =   models.ForeignKey(Product, on_delete=models.CASCADE, related_name="related_product")
    fee_category            =   models.IntegerField()   #0-percentage   1-fee
    percentage_levied       =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    fee_levied              =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    frequency_levied        =   models.IntegerField()  #0-every-action 1-weekly 2-monthly 3-quaterly 4-yearly 5-onetime
    added_by                =   models.ForeignKey(User, on_delete=models.CASCADE, related_name="product_fee_adder")
    added_on                =   models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return "{} fee levied on {} ".format(self.percentage_levied, self.related_product.product_name)

class Savings(models.Model):
    related_subscription    =   models.ForeignKey(ProductSubscriptions, on_delete=models.CASCADE, related_name="related_product_subscription")
    account_balance         =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    account_status          =   models.IntegerField()   #0-passive 1-active 2-inactive 3-suspended
    date_created            =   models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return "{} balance on {} ".format(self.account_balance, self.related_subscription.account_number)

class SavingsDeposits(models.Model):
    related_savings_account =   models.ForeignKey(Savings, on_delete=models.CASCADE, related_name="related_savings_account_deposit")
    amount_deposited        =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    fee_charged             =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    deposit_method          =   models.IntegerField()  #0-counter 1-electonic
    received_by             =   models.ForeignKey(User, on_delete=models.CASCADE, related_name="savings_deposit_receiver")
    cleared_by              =   models.ForeignKey(User, on_delete=models.CASCADE, related_name="savings_deposit_clearer")
    date_deposited          =   models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return "{} deposited on {} ".format(self.amount_deposited, self.related_savings_account.related_subscription.account_number)

class SavingsWithdrawal(models.Model):
    related_savings_account =   models.ForeignKey(Savings, on_delete=models.CASCADE, related_name="related_savings_account_withdraw")
    amount_withdrawn        =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    fee_charged             =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    withdraw_method         =   models.IntegerField()   #0-counter 1-electonic
    withdraw_comment        =   models.TextField(blank=True, null=True)
    authorized_by           =   models.ForeignKey(User, on_delete=models.CASCADE, related_name="savings_deposit_receiver")
    cleared_by              =   models.ForeignKey(User, on_delete=models.CASCADE, related_name="savings_deposit_receiver")
    date_withdrawn          =   models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return "{} withdrawn from {} ".format(self.amount_withdrawn, self.related_savings_account.related_subscription.account_number)

class Loans(models.Model):
    related_subscription    =   models.ForeignKey(ProductSubscriptions, on_delete=models.CASCADE, related_name="related_product_subscription")
    loan_amount             =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    received_by             =   models.ForeignKey(User, on_delete=models.CASCADE, related_name="savings_deposit_receiver")
    cleared_by              =   models.ForeignKey(User, on_delete=models.CASCADE, related_name="savings_deposit_receiver")     
    status                  =   models.IntegerField()   #0-unapproved 1-cleared 2-declined
    date_cleared            =   models.DateTimeField(auto_now_add=False, blank=True, null=True)
    date_declined           =   models.DateTimeField(auto_now_add=False, blank=True, null=True) 
    date_requested          =   models.DateTimeField(auto_now_add=True)

class LoansGuarantors(models.Model):
    related_loan            =   models.ForeignKey(Loans, on_delete=models.CASCADE, related_name="related_loan_guarantors")
    guarantor               =   models.ForeignKey(Client, on_delete=models.CASCADE, related_name="savings_deposit_receiver")
    date_added              =   models.DateTimeField(auto_now_add=True)

class LoansDisbursements(models.Model):
    related_loan            =   models.ForeignKey(Loans, on_delete=models.CASCADE, related_name="related_loan_disbursements")
    amount_disbursed        =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    disbursement_method     =   models.IntegerField()   #0-counter 1-electonic
    loan_status             =   models.IntegerField() #0-no payments yet 1-in payment 2-completed 3-extended 4-writtenoff
    disbursed_by            =   models.ForeignKey(User, on_delete=models.CASCADE, related_name="savings_deposit_receiver")
    cleared_by              =   models.ForeignKey(User, on_delete=models.CASCADE, related_name="savings_deposit_receiver")
    disbursed_on            =   models.DateTimeField(auto_now_add=True)
    date_completed          =   models.DateTimeField(auto_now_add=False, blank=True, null=True)
    date_extended           =   models.DateTimeField(auto_now_add=False, blank=True, null=True)
    date_written_off        =   models.DateTimeField(auto_now_add=False, blank=True, null=True)

class LoansDisbursementFeesLevied(models.Model):
    related_loan            =   models.ForeignKey(LoansDisbursements, on_delete=models.CASCADE, related_name="related_loan_disbursement_fees")
    related_fee             =   models.ForeignKey(ProductFeesLevied, on_delete=models.CASCADE, related_name="related_product_fees_levied")
    amount_levied           =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    date_levied             =   models.DateTimeField(auto_now_add=True)

class LoansRepayments(models.Model):
    related_loan            =   models.ForeignKey(Loans, on_delete=models.CASCADE, related_name="related_loan_repayments") 
    amount_paid             =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    payment_method          =   models.IntegerField()   #0-counter 1-electonic
    paid_on                 =   models.DateTimeField(auto_now_add=True)

class LoansRepaymentsFeesLevied(models.Model):
    related_repayment       =   models.ForeignKey(LoansRepayments, on_delete=models.CASCADE, related_name="related_loan_repayment_fees")
    related_fee             =   models.ForeignKey(ProductFeesLevied, on_delete=models.CASCADE, related_name="related_product_repayment_fees_levied")
    amount_levied           =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    date_levied             =   models.DateTimeField(auto_now_add=True)


