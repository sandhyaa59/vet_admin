import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vet_pharma/utils/route.dart';
import 'package:vet_pharma/utils/theme.dart';
import 'package:vet_pharma/widgets/scroll.dart';
// import 'dart:js' as js;
// import 'dart:html' as html;

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await GetStorage.init();
  //  setupPageReload();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((_) {
    runApp(MyApp());
  });
  runApp(const MyApp());
}

// void setupPageReload() {
//   onBeforeUnloadCallback(dynamic event) {
//     const message = 'Do you really want to leave?';
//     event.returnValue = message; // Standard for most browsers
//     return message; // For some older browsers
//   }
 
//   js.context['onbeforeunload'] = onBeforeUnloadCallback;
//   html.window.onBeforeUnload.listen((html.Event event) {
//     print('Page is reloading...');
//     Get.offAllNamed(Routes.INITIAL_LOAD);
//     // onBeforeUnloadCallback(event);
//   });
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: CustomScroll(),
      title: 'Trackyoe',
      debugShowCheckedModeBanner: false,
      
      theme: ThemeUtil.lightTheme,
      darkTheme: ThemeUtil.darkTheme,
      // themeMode: ThemeUtil.getThemeMode(),
       initialRoute: Routes.INITIAL_LOAD,
      getPages: AppPages.pages,
      // initialBinding: AuthMiddleware(),
    );
  }
}
