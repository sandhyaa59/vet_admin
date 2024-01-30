import 'package:get/get.dart';

class ReloadController extends GetxController{
   bool isReloaded = false;

  @override
  void onInit() {
    super.onInit();
    isReloaded = true; // Set flag on initial load
  }
}