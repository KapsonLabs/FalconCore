from django.contrib import admin

from .models import User, UserDetails, Branch

admin.site.register(User)
admin.site.register(UserDetails)
admin.site.register(Branch)
