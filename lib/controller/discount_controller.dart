import 'package:get/get.dart';
import 'package:vet_pharma/model/discount_list_response.dart';
import 'package:vet_pharma/model/discount_request.dart';
import 'package:vet_pharma/services/discount_service.dart';

class DiscountController extends GetxController{
  var isLoading=false.obs;


 var discount = <DiscountListResponse>[].obs;
 var dis=<DiscountListResponse>[].obs;
  var discountList=DiscountListResponse().obs;
  var selectedDiscountType = 'PERCENTAGE'.obs;


  @override
  void onInit() {
    fetchDiscounts();
    super.onInit();
  }

  void fetchDiscounts() async {
    try {
      isLoading(true);
       discount.value = await DiscountService.fetchDiscount();
   if(discount.isNotEmpty){
     dis.value = discount;
   }
           

    } catch (e) {
      print('Error fetching discount: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<dynamic> addDiscount(DiscountRequest discountRequest) async {
    try {
      isLoading(true);
    var res=  await DiscountService.addDiscount(discountRequest);
   
    isLoading(false);
      return res;
    
    } catch (e) {
      print('Error adding discount: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<dynamic> updateDiscount( discountUpdateRequest,id)async{
  try{
    isLoading.value=true;
var result=await DiscountService.updateDiscount(discountUpdateRequest,id);
 isLoading.value=false;
 return result;
  }
  catch(e){
isLoading.value=false;
  }
  }
}