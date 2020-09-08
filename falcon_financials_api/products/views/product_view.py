from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import permissions
from django.db.models import Q

from ..models import Product, ProductSubscriptions, ProductFeesLevied, LoanType
from accounts.models import Client
from ..serializers.product_serializer import (ProductCreateSerializer, ProductDetailsSerializer, ProductSubscriptionCreateSerializer, 
ProductSubscriptionSaveSerializer, ProductFeesCreateSerializer, ProductFeesSaveSerializer, ProductFeesDetailSerializer, 
ProductSubscriptionDetailSerializer, ClientProductSubscriptionSerializer, ProductSubscriptionShortDetailSerializer
)
from ..serializers.savings_serializer import SavingsCreateSerializer
from ..serializers.loans_serializer import LoanTypeSaveSerializer
from ..helpers.account_management import create_account_number
import datetime 

class ProductListView(APIView):
    """
    List all products and create a product.
    """
    permission_classes = (permissions.IsAuthenticated, )

    def get(self, request, format=None):
        serializer = ProductDetailsSerializer(Product.objects.all(), many=True)
        return Response({"status":200, "data":serializer.data}, status=status.HTTP_200_OK)

    def post(self, request, format=None):
        serializer = ProductCreateSerializer(data=request.data)
        if serializer.is_valid():
            try:
                existing_product_code = Product.objects.get(product_code=serializer.validated_data['product_code'])
                return Response({"status":400, "error":"Duplicate product code"}, status=status.HTTP_400_BAD_REQUEST)
            except:
                serializer.save(created_by=request.user)
                if serializer.data['product_category'] == 1:
                    #Create a default loan type for the system
                    default_loan_type_serializer = LoanTypeSaveSerializer(data={
                        "loan_type_name":"DEFAULT",
                        "loan_type_description":"Default loan type created by the system",
                        "loan_type_code":"DEF0001",
                        "loan_type_added_by": request.user.pk,
                        "related_product": serializer.data['id']
                    })
                    default_loan_type_serializer.is_valid(raise_exception=True)
                    default_loan_type_serializer.save()
                return Response({"status":201, "data":serializer.data}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class ProductSubscriptionListView(APIView):
    """
    List all product subscriptions and add a client to a product
    """
    permission_classes = (permissions.IsAuthenticated, )

    def get(self, request, pk, format=None):
        serializer = ProductSubscriptionDetailSerializer(ProductSubscriptions.objects.filter(related_product_subscription=pk), many=True)
        return Response({"status":200, "data":serializer.data}, status=status.HTTP_200_OK)

    def post(self, request, pk, format=None):
        serializer = ProductSubscriptionCreateSerializer(data=request.data)
        if serializer.is_valid():
            
            try:
                existing_product_subscription = ProductSubscriptions.objects.get(Q(related_product_subscription=pk), Q(related_client_subscription=serializer.data['related_client']))

                if existing_product_subscription:
                    return Response({'status':400, 'error': 'Client already subscribed to product'}, status=status.HTTP_400_BAD_REQUEST)
            
            except:

                product_subscription_data = {
                        'related_product_subscription': pk,
                        'related_client_subscription': serializer.data['related_client'],
                        'account_number': create_account_number()
                    }

                product_subscription_creation = ProductSubscriptionSaveSerializer(data=product_subscription_data)
                product_subscription_creation.is_valid(raise_exception=True)
                product_subscription_creation.save(added_by=request.user)

                #create a new account depending on the product, 0 for savings account and 1 for loans account

                try:
                    product = Product.objects.get(pk=pk)
                    if(product.product_category==0):
                        savings_account_data = {
                            'related_savings_subscription':product_subscription_creation.data['id'],
                            'account_balance':0,
                            'account_status':0
                        }

                        savings_account_creation = SavingsCreateSerializer(data=savings_account_data)
                        savings_account_creation.is_valid(raise_exception=True)
                        savings_account_creation.save()

                        return Response({"status":201, "data":{'product':product_subscription_creation.data, 'savings_account':savings_account_creation.data}}, status=status.HTTP_201_CREATED)
                    else:
                        pass
                        
                except Product.DoesNotExist as e:
                    response = {"status":404, "msg":str(e)}
                    return Response(response) 
                
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class ProductFeesListView(APIView):
    """
    List all product fees and add a fee to a product
    """
    permission_classes = (permissions.IsAuthenticated, )

    def get(self, request, pk, format=None):
        serializer = ProductFeesDetailSerializer(ProductFeesLevied.objects.filter(related_product_fees=pk), many=True)
        return Response({"status":200, "data":serializer.data}, status=status.HTTP_200_OK)

    def post(self, request, pk, format=None):
        serializer = ProductFeesCreateSerializer(data=request.data)
        if serializer.is_valid():
            
            product_fees_data = {
                'related_product_fees': pk,
                'fee_category': serializer.data['fee_category'],
                'percentage_levied': serializer.data['percentage_levied'],
                'fee_levied': serializer.data['fee_levied'],
                'frequency_levied': serializer.data['frequency_levied'],
            }

            product_fees_creation = ProductFeesSaveSerializer(data=product_fees_data)
            product_fees_creation.is_valid(raise_exception=True)
            product_fees_creation.save(fees_added_by=request.user)

            return Response({"status":201, "data":product_fees_creation.data}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class ProductClientSubscriptions(APIView):
    """
    Interactions between client and product
    """
    permission_classes = (permissions.IsAuthenticated, )

    def post(self, request, format=None):
        serializer = ClientProductSubscriptionSerializer(data=request.data)
        if serializer.is_valid():
            try:
                related_client = Client.objects.get(client_account_number=serializer.data['client_account_number'])
                related_subscriptions = ProductSubscriptionShortDetailSerializer(ProductSubscriptions.objects.filter(related_client_subscription=related_client.id), many=True)
                return Response({"status":200, "data":related_subscriptions.data}, status=status.HTTP_200_OK)
            except:
                return Response({"status":400, "error":"Invalid account number"}, status=status.HTTP_400_BAD_REQUEST)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class ProductSubscriptionReport(APIView):
    """
    Processing reportings for subscription
    """
    #permission_classes = (permissions.IsAuthenticated, )
    
    def get(self, request, format=None):
        """
        @GET
        """
        try:
            report = self.generate_product_report()            
            data={"status":200, "data":report}
            return Response(data)
        except Exception as e:
            return Response({"status":400, "error":"Invalid account number"}, status=status.HTTP_400_BAD_REQUEST)
    
    def generate_product_report(self):
        """
        Generates product reports.
        """
        report = []
        product_query = Product.objects.all()
        for product in product_query:
            report.append({"product_name":product.product_name, "product_code":product.product_code,
                            "no_of_subscribers":ProductSubscriptions.objects.filter(related_product_subscription=product).count()
                        })
        return report 
        
    def post(self, request, format=None):
        """
        @POST
        """
        try:
            return Response({})
        except Exception as e:
            return Response({"status":400, "error":"Invalid account number"}, status=status.HTTP_400_BAD_REQUEST)

class ProductSubscriptionStatistics(APIView):
    """
    Processing statistics for subscription
    """
    permission_classes = (permissions.IsAuthenticated, )
    
    def get(self, request, format=None):
        """
        @GET
        """
        try:
            data={"status":200, "data":self.filter_subscription_by_date()}            
            return Response(data)
        except Exception as e:
            return Response({"status":400, "error":"Invalid account number"}, status=status.HTTP_400_BAD_REQUEST)
    
    def filter_subscription_by_date(self):
        """
        Filters all subscriptions by current year, and month
        """
        DEFAULT_MONTHS=[1,2,3,4,5,6,7,8,9,10,11,12] # This months don't change
        DEFAULT_MONTHS_NAME={1:"January", 2:"February", 3:"March", 4:"April", 5:"May", 6:"June", 7:"July", 8:"August",
                             9:"September", 10:"October", 11:"November", 12:"December"
                            } # This don't change
                            
        YEAR = datetime.datetime.now().year
        response = []
        
        for month in DEFAULT_MONTHS:
            response.append(
                {DEFAULT_MONTHS_NAME.get(month):ProductSubscriptions.objects.filter(date_subscribed__year=YEAR, date_subscribed__month=month).count()}
            )
        return response 
        
    def post(self, request, format=None):
        """
        @POST
        """
        try:
            return Response({})
        except Exception as e:
            return Response({"status":400, "error":"Invalid account number"}, status=status.HTTP_400_BAD_REQUEST)

