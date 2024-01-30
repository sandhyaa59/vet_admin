import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

showToastMessage(Color color,String message,String title){

return Get.showSnackbar(GetSnackBar(message: message,backgroundColor: color,title: title,duration: const Duration(seconds: 2),));
}

 dynamic handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      // Successful response
      var res = response.body;
    
      return res;
    } else if (response.statusCode >= 400) {
      // Error response
      showToastMessage(
        Colors.red,
        jsonDecode(response.body)["message"],
        "Error",
      );
      return;
    }else {
      showToastMessage(Colors.red, "Something went Wrong", "Error");
      return;
    }
    
  }

  

convertTimeStamp(String dateTimes){
 
if(dateTimes.isNotEmpty){
  // Parse the timestamp string to DateTime
    final dateTime = DateTime.parse(dateTimes);

    // Define the date and time format
    final dateFormat = DateFormat('yyyy-MM-dd h:mm a');

    // Format the date and time
    final formattedDate = dateFormat.format(dateTime);
    return formattedDate;
}else{
  return "";
}
  
}
 Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    final Uri uri=Uri.parse(googleUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not open the map.';
    }
  }