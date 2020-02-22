import random


def client_create_account_number():
    #FAL0999810GAH
    random_prefix = random.randint(100000, 99999999)
    return "FAL{}GAH".format(random_prefix)