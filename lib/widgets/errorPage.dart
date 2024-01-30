import 'package:flutter/material.dart';

Widget showError(){
  return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            size: 50,
            color: Colors.red,
          ),
          const SizedBox(height: 20),
          const Text(
            'An error occurred',
            style: TextStyle(fontSize: 20, color: Colors.red),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
}