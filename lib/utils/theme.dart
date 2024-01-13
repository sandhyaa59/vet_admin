import 'package:flutter/material.dart';
import 'package:vet_pharma/utils/constants.dart';

class ThemeUtil {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,

    brightness: Brightness.light,
    // Add other theme configurations as needed
  );

  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.indigo,

    brightness: Brightness.dark,
    // Add other theme configurations as needed
  );

  static ThemeMode getThemeMode(bool isDarkMode) {
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

ThemeData elevatedButtonThemeData(){
  return  ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(

          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff596cff),),
            textStyle: MaterialStateProperty.all<TextStyle>(
              TextStyle(fontSize: 18.0),
            ),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
           const  EdgeInsets.all(kPadding)
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
    )
  );
}
}

InputDecoration customInputDecoration({
     String ?labelText,
     String ?hintText,
    IconButton? iconButton

  }) {
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

