import 'package:flutter/material.dart';
import 'package:vet_pharma/utils/constants.dart';

class ThemeUtil {
  static ThemeData lightTheme = ThemeData(
    
      primarySwatch: Colors.blue,
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      brightness: Brightness.light,
      textTheme: const TextTheme(
        titleMedium: TextStyle(
          color: Colors.white,
        ),
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        elevation: 4.0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff596cff),
              textStyle: const TextStyle(fontSize: 16.0, color: Colors.white))),
      dialogTheme: DialogTheme(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.0),
        ),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18.0),
        contentTextStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18.0),
      ),
      dropdownMenuTheme: const DropdownMenuThemeData(
          menuStyle: MenuStyle(), textStyle: TextStyle(color: Colors.black))

      // Add other theme configurations as needed
      );

  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.indigo,
    appBarTheme: const AppBarTheme(
      titleTextStyle: const TextStyle(color: Colors.black),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    brightness: Brightness.dark,
       elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff596cff),
              textStyle: const TextStyle(fontSize: 16.0, color: Colors.white))),
   
    // Add other theme configurations as needed
  );

  static ThemeMode getThemeMode(bool isDarkMode) {
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

// ThemeData elevatedButtonThemeData(){
//   return  ThemeData(
//     elevatedButtonTheme: ElevatedButtonThemeData(

//           style: ButtonStyle(
//             backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff596cff),),
//             textStyle: MaterialStateProperty.all<TextStyle>(
//               const TextStyle(fontSize: 18.0),
//             ),
//             padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
//            const  EdgeInsets.all(kPadding)
//             ),
//             shape: MaterialStateProperty.all<OutlinedBorder>(
//               RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//             ),
//           ),
//     )
//   );
// }
}

InputDecoration customInputDecoration(
    {String? labelText, String? hintText, IconButton? iconButton}) {
  return InputDecoration(
    labelText: labelText,
    hintText: hintText,
    suffixIcon: iconButton,
    contentPadding: const EdgeInsets.all(kPadding),
    focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
      color: Color(0xff596cff),
    )),
    errorBorder:
        const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
    focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
      color: Colors.red,
    )),
    enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
      color: Color(0xff596cff),
    )),
  );
}
