from django.contrib import admin

from .models import CategoryClass, ChartOfAccounts, Transaction, ProductLedger, TrialBalanceLedger
admin.site.register(CategoryClass)
admin.site.register(ChartOfAccounts)
admin.site.register(Transaction)
admin.site.register(ProductLedger)
admin.site.register(TrialBalanceLedger)

