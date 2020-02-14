import random


def create_account_number():
    # product_prefix = product_name[0:2] 
    # first_name_prefix = first_name[0:2]
    # year_prefix = year_of_birth[2:4]
    random_prefix = random.randint(10000, 99999)
    return "ACM{}".format(random_prefix)