import 'package:get/get.dart';
import 'package:vet_pharma/services/login_services.dart';

class LoginController extends GetxController{
  
  var isLoading=false.obs;
  var isVisible=false.obs;


  Future<dynamic> login(String email,String password)async{
    try {
      isLoading.value=true;
       var res= await LoginService.doLogin(email, password);
       isLoading.value=false;
       return res;

    } catch (e) {
      isLoading.value=false;
    }finally
    {
      isLoading.value=false;
    }

  }
}