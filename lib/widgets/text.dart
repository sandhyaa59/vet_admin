import 'package:flutter/material.dart';


showTitleContent(String title, String content) {
    return  RichText(
                  text: TextSpan(children: [
                 TextSpan(
                    text: title,
                    style:const TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff004792),
                        fontWeight: FontWeight.bold)),
                TextSpan(
                    text:
                        content,
                    style: const TextStyle(
                        fontSize: 14.0, fontWeight: FontWeight.w600))
              ]));
  }