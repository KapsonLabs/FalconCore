from django.db import models
from accounts.models import User, Client
from .choices import PAYMENT_PERIOD

class Product(models.Model):
    product_name            =   models.CharField(max_length=250) 
    product_description     =   models.CharField(max_length=250) 
    product_code            =   models.CharField(max_length=250, null=True, blank=True)
    product_category        =   models.IntegerField()  #0-savings 1-loans
    created_by              =   models.ForeignKey(User, on_delete=models.CASCADE, related_name='product_creator')
    date_created            =   models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return "{} product created on {} ".format(self.product_name, self.date_created)

class ProductSubscriptions(models.Model):
    related_product_subscription    =   models.ForeignKey(Product, on_delete=models.CASCADE, related_name="related_product")
    related_client_subscription     =   models.ForeignKey(Client, on_delete=models.CASCADE, related_name="related_client_subscription")
    account_number                  =   models.CharField(max_length=25)
    added_by                        =   models.ForeignKey(User, on_delete=models.CASCADE, related_name="related_user_subscriber")
    subscription_status             =   models.BooleanField(default=True)
    date_subscribed                 =   models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return "{} subscribed to {} ".format(self.related_client_subscription, self.related_product_subscription)

class ProductFeesLevied(models.Model):
    related_product_fees    =   models.ForeignKey(Product, on_delete=models.CASCADE, related_name="related_product_fees")
    fee_category            =   models.IntegerField()   #0-percentage   1-fee
    percentage_levied       =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    fee_levied              =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    frequency_levied        =   models.IntegerField()  #0-every-action 1-weekly 2-monthly 3-quaterly 4-yearly 5-onetime
    fees_added_by           =   models.ForeignKey(User, on_delete=models.CASCADE, related_name="product_fee_adder")
    added_on                =   models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return "{} fee levied on {} ".format(self.percentage_levied, self.related_product_fees.product_name)

class Savings(models.Model):
    related_savings_subscription    =   models.ForeignKey(ProductSubscriptions, on_delete=models.CASCADE, related_name="related_savings_product_subscription")
    account_balance                  =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    account_status                   =   models.IntegerField()   #0-inactive 1-active 2-passive 3-suspended
    date_created                     =   models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return "{} balance on {} ".format(self.account_balance, self.related_savings_subscription.account_number)

class SavingsDeposits(models.Model):
    related_savings_account =   models.ForeignKey(Savings, on_delete=models.CASCADE, related_name="related_savings_account_deposit")
    amount_deposited        =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    fee_charged             =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    deposit_method          =   models.IntegerField()  #0-counter 1-electonic
    deposit_received_by     =   models.ForeignKey(User, on_delete=models.CASCADE, related_name="savings_deposit_receiver")
    deposit_cleared_by      =   models.ForeignKey(User, on_delete=models.CASCADE, related_name="savings_deposit_clearer")
    date_deposited          =   models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return "{} deposited on {} ".format(self.amount_deposited, self.related_savings_account.related_savings_subscription.account_number)

class SavingsWithdrawal(models.Model):
    related_savings_account_withdrawal  =   models.ForeignKey(Savings, on_delete=models.CASCADE, related_name="related_savings_account_withdraw")
    amount_withdrawn                    =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    fee_charged                         =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    withdraw_method                     =   models.IntegerField()   #0-counter 1-electonic
    withdraw_comment                    =   models.TextField(blank=True, null=True)
    withdrawal_authorized_by            =   models.ForeignKey(User, on_delete=models.CASCADE, related_name="savings_withdrawal_authorizer")
    withdrawal_cleared_by               =   models.ForeignKey(User, on_delete=models.CASCADE, related_name="savings_withdrawal_clearer")
    date_withdrawn                      =   models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return "{} withdrawn from {} ".format(self.amount_withdrawn, self.related_savings_account.related_subscription.account_number)

class LoanType(models.Model):
    loan_type_name          = models.CharField(max_length=250)
    loan_type_description   = models.TextField()
    loan_type_code          = models.CharField(max_length=250)
    related_product         = models.ForeignKey(Product, on_delete=models.CASCADE, related_name="loan_type_related_product")
    loan_type_added_by      = models.ForeignKey(User, on_delete=models.CASCADE, related_name="loan_type_creator")
    loan_type_added_on      = models.DateTimeField(auto_now_add=True)

class LoanTypeFeesApplicable(models.Model):
    related_loan_type           = models.ForeignKey(LoanType, on_delete=models.CASCADE, related_name="related_loan_fee")
    related_loan_fee_category   = models.IntegerField()  #0-flat_fee 1-Percentage
    amount                      = models.DecimalField(max_digits=20, decimal_places=2, default=0)
    date_added                  = models.DateTimeField(auto_now_add=True)
    added_by                    = models.ForeignKey(User, on_delete=models.CASCADE, related_name="loan_type_fee_creator")


class Loans(models.Model):
    related_loan_subscription    =   models.ForeignKey(ProductSubscriptions, on_delete=models.CASCADE, related_name="related_loan_product_subscription")
    related_loan_type_loans      =   models.ForeignKey(LoanType, on_delete=models.CASCADE, related_name="related_loan_type_loans")
    loan_amount                  =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    loan_received_by             =   models.ForeignKey(User, on_delete=models.CASCADE, related_name="laons_deposit_receiver")
    loan_cleared_by              =   models.ForeignKey(User, on_delete=models.CASCADE, related_name="loans_deposit_clearer", null=True, blank=True)     
    status                       =   models.IntegerField(default=0)   #0-unapproved 1-cleared 2-declined
    payment_duration             =   models.IntegerField()  
    payment_period               =   models.CharField(max_length=10, choices=PAYMENT_PERIOD)
    date_cleared                 =   models.DateTimeField(auto_now_add=False, blank=True, null=True)
    date_declined                =   models.DateTimeField(auto_now_add=False, blank=True, null=True) 
    date_requested               =   models.DateTimeField(auto_now_add=True)

class LoansGuarantors(models.Model):
    related_loan_guaranted  =   models.ForeignKey(Loans, on_delete=models.CASCADE, related_name="related_loan_guarantors")
    guarantor               =   models.ForeignKey(Client, on_delete=models.CASCADE, related_name="loans_guarantor")
    date_added              =   models.DateTimeField(auto_now_add=True)

class LoansDisbursements(models.Model):
    related_loan_disbursement  =   models.ForeignKey(Loans, on_delete=models.CASCADE, related_name="related_loan_disbursements")
    amount_disbursed        =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    disbursement_method     =   models.IntegerField()   #0-counter 1-electonic
    loan_status             =   models.IntegerField(default=0) #0-no payments yet 1-in payment 2-completed 3-extended 4-writtenoff
    disbursed_by            =   models.ForeignKey(User, on_delete=models.CASCADE, related_name="loans_disburser")
    disbursement_cleared_by =   models.ForeignKey(User, on_delete=models.CASCADE, related_name="loans_disbursement_clearer")
    disbursed_on            =   models.DateTimeField(auto_now_add=True)
    date_completed          =   models.DateTimeField(auto_now_add=False, blank=True, null=True)
    date_extended           =   models.DateTimeField(auto_now_add=False, blank=True, null=True)
    date_written_off        =   models.DateTimeField(auto_now_add=False, blank=True, null=True)

class LoansDisbursementFeesLevied(models.Model):
    disbursement_related_loan   =   models.ForeignKey(LoansDisbursements, on_delete=models.CASCADE, related_name="related_loan_disbursement_fees")
    disbursement_related_fee    =   models.ForeignKey(ProductFeesLevied, on_delete=models.CASCADE, related_name="related_product_fees_levied")
    amount_levied               =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    date_levied                 =   models.DateTimeField(auto_now_add=True)

class LoansRepayments(models.Model):
    related_loan_repayment  =   models.ForeignKey(Loans, on_delete=models.CASCADE, related_name="related_loan_repayments") 
    amount_paid             =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    payment_method          =   models.IntegerField()   #0-counter 1-electonic
    paid_on                 =   models.DateTimeField(auto_now_add=True)

class LoansRepaymentsFeesLevied(models.Model):
    related_repayment_fee   =   models.ForeignKey(LoansRepayments, on_delete=models.CASCADE, related_name="related_loan_repayment_fees")
    related_repayment_fee   =   models.ForeignKey(ProductFeesLevied, on_delete=models.CASCADE, related_name="related_product_repayment_fees_levied")
    amount_levied           =   models.DecimalField(max_digits=20, decimal_places=2, default=0)
    date_levied             =   models.DateTimeField(auto_now_add=True)


