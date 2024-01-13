import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vet_pharma/utils/route.dart';
import 'package:vet_pharma/utils/theme.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized();
   GetStorage.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((_) {
    runApp(MyApp());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Vet Pharma',
      debugShowCheckedModeBanner: false,
      
      theme: ThemeUtil.lightTheme,
      darkTheme: ThemeUtil.darkTheme,
      // themeMode: ThemeUtil.getThemeMode(),
       initialRoute: Routes.INITIAL_LOAD,
      getPages: AppPages.pages,
      
    );
  }
}
