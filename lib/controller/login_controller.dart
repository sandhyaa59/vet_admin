import 'package:get/get.dart';
import 'package:vet_pharma/services/login_services.dart';

class LoginController extends GetxController{
  
  var isLoading=false.obs;
  var isVisible=false.obs;


  Future<dynamic> login(String email,String password)async{
    try {
       return await LoginService.doLogin(email, password);
    } catch (e) {
      isLoading.value=false;
    }finally
    {
      isLoading.value=false;
    }

  }
}