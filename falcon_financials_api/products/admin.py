from django.contrib import admin

from .models import Product, ProductSubscriptions, ProductFeesLevied, Savings, SavingsDeposits

admin.site.register(Product)
admin.site.register(ProductSubscriptions)
admin.site.register(ProductFeesLevied)
admin.site.register(Savings)
admin.site.register(SavingsDeposits)
