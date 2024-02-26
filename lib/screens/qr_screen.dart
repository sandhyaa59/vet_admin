import 'package:flutter/material.dart';
import 'package:vet_pharma/widgets/appbar.dart';

class QRscreen extends StatelessWidget {
  const QRscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text("QR"),),
      body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width*0.6, // Set the width of the container
            height: MediaQuery.of(context).size.height*0.5, // Set the height of the container
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black), // Optional border
            ),
            child: Image.asset(
              "asset/images/qr.jpeg", // Replace with your image URL
              fit: BoxFit.contain, // Adjust the image fit as needed
            ),
          ),
        ),
      
      
    );
  }
}