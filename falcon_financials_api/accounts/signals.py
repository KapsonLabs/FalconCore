from django.db.models.signals import post_save
from django.dispatch import receiver
from accounts.models import (NotificationMessages, Branch, Client, User
)
from products.models import (Product, ProductSubscriptions, ProductFeesLevied, Savings, SavingsDeposits,
SavingsWithdrawal, LoanType, LoanTypeFeesApplicable, Loans, LoansGuarantors, LoansDisbursements,
LoansDisbursementFeesLevied, LoansRepayments, LoansRepaymentsFeesLevied
)

@receiver(post_save, sender=LoansRepaymentsFeesLevied, dispatch_uid='new_loan_repayment_levied_created')
def new_loan_repayment_levied_created(sender, instance, **kwargs):
    """
    Signal for when LoansRepaymentsFeesLevied has been created
    """
    if(kwargs.get("created") == True):
        
        # Incase there is an exception just skipt this and we continue
        try:
            msg = "LoansRepaymentsFeesLevied was recently made and the amount levied is {0}".format(str(instance.amount_levied))
            title = "New LoansRepaymentsFeesLevied made"
        
            notification = NotificationMessages.objects.create(
                        title=title, message=msg,
                        notification_object=instance
            )
        except Exception as e:
            print("ERROR, but we are continuing....", e)
            
@receiver(post_save, sender=LoansRepayments, dispatch_uid='new_loan_repayment_created')
def new_loan_repayment_created(sender, instance, **kwargs):
    """
    Signal for when LoansRepayments has been created
    """
    if(kwargs.get("created") == True):
        
        # Incase there is an exception just skipt this and we continue
        try:
            msg = "LoansRepayments was recently made and the amount is {0}".format(str(instance.amount_paid))
            title = "New LoansRepayments made"
        
            notification = NotificationMessages.objects.create(
                        title=title, message=msg,
                        notification_object=instance
            )
        except Exception as e:
            print("ERROR, but we are continuing....", e)
            
@receiver(post_save, sender=LoansDisbursementFeesLevied, dispatch_uid='new_loan_disbursement_levied_created')
def new_loan_disbursement_levied_created(sender, instance, **kwargs):
    """
    Signal for when LoansDisbursementFeesLevied has been created
    """
    if(kwargs.get("created") == True):
        
        # Incase there is an exception just skipt this and we continue
        try:
            msg = "LoansDisbursementFeesLevied was recently made and the  levied amount is {0}".format(str(instance.amount_levied))
            title = "New LoansDisbursementFeesLevied made"
        
            notification = NotificationMessages.objects.create(
                        title=title, message=msg,
                        notification_object=instance
            )
        except Exception as e:
            print("ERROR, but we are continuing....", e)
            
@receiver(post_save, sender=LoansDisbursements, dispatch_uid='new_loan_disbursement_created')
def new_loan_disbursement_created(sender, instance, **kwargs):
    """
    Signal for when LoansDisbursements has been created
    """
    if(kwargs.get("created") == True):
        
        # Incase there is an exception just skipt this and we continue
        try:
            msg = "A new Loans Disbursements was recently made and the  amount is {0}".format(str(instance.amount_disbursed))
            title = "New LoansDisbursements made"
        
            notification = NotificationMessages.objects.create(
                        title=title, message=msg,
                        notification_object=instance
            )
        except Exception as e:
            print("ERROR, but we are continuing....", e)
            
@receiver(post_save, sender=LoansGuarantors, dispatch_uid='new_loanguarantor_created')
def new_loanguarantor_created(sender, instance, **kwargs):
    """
    Signal for when LoansGuarantors has been created
    """
    if(kwargs.get("created") == True):
        
        # Incase there is an exception just skipt this and we continue
        try:
            msg = "LoansGuarantors information was added recently"
            title = "New LoansGuarantors added"
        
            notification = NotificationMessages.objects.create(
                        title=title, message=msg,
                        notification_object=instance
            )
        except Exception as e:
            print("ERROR, but we are continuing....", e)
            
@receiver(post_save, sender=Loans, dispatch_uid='new_loan_created')
def new_loan_created(sender, instance, **kwargs):
    """
    Signal for when Loans has been created
    """
    if(kwargs.get("created") == True):
        
        # Incase there is an exception just skipt this and we continue
        try:
            msg = "A new Loans information was added recently with amount {0}".format(str(instance.loan_amount))
            title = "New LoanTypeFeesApplicable added"
        
            notification = NotificationMessages.objects.create(
                        title=title, message=msg,
                        notification_object=instance
            )
        except Exception as e:
            print("ERROR, but we are continuing....", e)
            
@receiver(post_save, sender=LoanTypeFeesApplicable, dispatch_uid='new_loan_type_fee_created')
def new_loan_type_fee_created(sender, instance, **kwargs):
    """
    Signal for when LoanTypeFeesApplicable has been created
    """
    if(kwargs.get("created") == True):
        
        # Incase there is an exception just skipt this and we continue
        try:
            msg = "There was a new LoanTypeFeesApplicable recently added by {0}".format(str(instance.added_by.email))
            title = "New LoanTypeFeesApplicable added"
        
            notification = NotificationMessages.objects.create(
                        title=title, message=msg,
                        notification_object=instance
            )
        except Exception as e:
            print("ERROR, but we are continuing....", e)
            
@receiver(post_save, sender=LoanType, dispatch_uid='new_loantype_created')
def new_loantype_created(sender, instance, **kwargs):
    """
    Signal for when LoanType has been created
    """
    if(kwargs.get("created") == True):
        
        # Incase there is an exception just skipt this and we continue
        try:
            msg = "There was a new LoanType recently added"
            title = "New LoanType added"
        
            notification = NotificationMessages.objects.create(
                        title=title, message=msg,
                        notification_object=instance
            )
        except Exception as e:
            print("ERROR, but we are continuing....", e)
            
@receiver(post_save, sender=SavingsWithdrawal, dispatch_uid='new_widthdraw_created')
def new_widthdraw_created(sender, instance, **kwargs):
    """
    Signal for when SavingsWithdrawal has been created
    """
    if(kwargs.get("created") == True):
        
        # Incase there is an exception just skipt this and we continue
        try:
            msg = "There was a new SavingsWithdrawal recently made with amount {0}".format(str(instance.amount_withdrawn))
            title = "New SavingsWithdrawal made"
        
            notification = NotificationMessages.objects.create(
                        title=title, message=msg,
                        notification_object=instance
            )
        except Exception as e:
            print("ERROR, but we are continuing....", e)
            
@receiver(post_save, sender=SavingsDeposits, dispatch_uid='new_savingdeposit_created')
def new_savingdeposit_created(sender, instance, **kwargs):
    """
    Signal for when SavingsDeposits has been created
    """
    if(kwargs.get("created") == True):
        
        # Incase there is an exception just skipt this and we continue
        try:
            msg = "There as been a new SavingsDeposits added recently with fee {0}".format(str(instance.fee_charged))
            title = "New SavingsDeposits Created"
        
            notification = NotificationMessages.objects.create(
                        title=title, message=msg,
                        notification_object=instance
            )
        except Exception as e:
            print("ERROR, but we are continuing....", e)
            
@receiver(post_save, sender=Savings, dispatch_uid='new_saving_created')
def new_saving_created(sender, instance, **kwargs):
    """
    Signal for when ProductFeesLevied has been created
    """
    if(kwargs.get("created") == True):
        
        # Incase there is an exception just skipt this and we continue
        try:
            msg = "There as been a new Savings added recently account balance {0}".format(instance.account_balance)
            title = "New Savings Created"
        
            notification = NotificationMessages.objects.create(
                        title=title, message=msg,
                        notification_object=instance
            )
        except Exception as e:
            print("ERROR, but we are continuing....", e)
            
@receiver(post_save, sender=ProductFeesLevied, dispatch_uid='new_product_fee_levied_created')
def new_product_fee_levied_created(sender, instance, **kwargs):
    """
    Signal for when ProductFeesLevied has been created
    """
    if(kwargs.get("created") == True):
        
        # Incase there is an exception just skipt this and we continue
        try:
            msg = "There as been a new ProductFeesLevied added By user {0}".format(instance.fees_added_by.email)
            title = "New ProductFeesLevied Created"
        
            notification = NotificationMessages.objects.create(
                        title=title, message=msg,
                        notification_object=instance
            )
        except Exception as e:
            print("ERROR, but we are continuing....", e)
            
@receiver(post_save, sender=ProductSubscriptions, dispatch_uid='new_product_subscription_created')
def new_product_subscription_created(sender, instance, **kwargs):
    """
    Signal for when ProductSubscriptions has been created
    """
    if(kwargs.get("created") == True):
        
        # Incase there is an exception just skipt this and we continue
        try:
            msg = "There as been a new ProductSubscriptions added By user {0}".format(instance.added_by.email)
            title = "New ProductSubscriptions Added"
        
            notification = NotificationMessages.objects.create(
                        title=title, message=msg,
                        notification_object=instance
            )
        except Exception as e:
            print("ERROR, but we are continuing....", e)
            
@receiver(post_save, sender=Product, dispatch_uid='new_product_created')
def new_product_created(sender, instance, **kwargs):
    """
    Signal for when branch has been created
    """
    if(kwargs.get("created") == True):
        
        # Incase there is an exception just skipt this and we continue
        try:
            msg = "There as been a new product added with name {0} By user {1}".format(str(instance.product_name), instance.created_by.email)
            title = "New Product Added"
        
            notification = NotificationMessages.objects.create(
                        title=title, message=msg,
                        notification_object=instance
            )
        except Exception as e:
            print("ERROR, but we are continuing....", e)
            
@receiver(post_save, sender=Branch, dispatch_uid='new_branch_created')
def new_branch_created(sender, instance, **kwargs):
    """
    Signal for when branch has been created
    """
    if(kwargs.get("created") == True):
        
        # Incase there is an exception just skipt this and we continue
        try:
            msg = "New branch has been updated with ID {0} By user {1}".format(str(instance.id), instance.created_by.email)
            title = "Branch created!"
        
            notification = NotificationMessages.objects.create(
                        title=title, message=msg,
                        notification_object=instance
            )
        except Exception as e:
            print("ERROR, but we are continuing....", e)
            
@receiver(post_save, sender=Client, dispatch_uid='new_client_added')
def new_client_added(sender, instance, **kwargs):
    """
    Signal for when client has been created
    """
    if(kwargs.get("created") == True):
        
        # Incase there is an exception just skipt this and we continue
        try:
            msg = "There has been a new client that has been added recently".format(str(instance.id))
            title = "New client added"
        
            notification = NotificationMessages.objects.create(
                        title=title, message=msg,
                        notification_object=instance
            )
        except Exception as e:
            print("ERROR, but we are continuing....", e)
