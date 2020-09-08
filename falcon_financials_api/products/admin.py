from django.contrib import admin

from .models import (Product, ProductSubscriptions, ProductFeesLevied, Savings, SavingsDeposits, Loans,
LoanType, LoansDisbursements, SavingsWithdrawal, LoanTypeFeesApplicable, LoansGuarantors,LoansRepayments,
LoansDisbursementFeesLevied, LoansRepaymentsFeesLevied
)

admin.site.register(LoansRepaymentsFeesLevied)
admin.site.register(LoansRepayments)
admin.site.register(LoansDisbursementFeesLevied)
admin.site.register(LoansGuarantors)
admin.site.register(LoanTypeFeesApplicable)
admin.site.register(SavingsWithdrawal)
admin.site.register(LoansDisbursements)
admin.site.register(LoanType)
admin.site.register(Loans)
admin.site.register(Product)
admin.site.register(ProductSubscriptions)
admin.site.register(ProductFeesLevied)
admin.site.register(Savings)
admin.site.register(SavingsDeposits)
