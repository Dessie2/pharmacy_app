import 'package:flutter/material.dart';

class AppWidget {

  static TextStyle headlineTextStyle (double size){
   return TextStyle(color: Colors.black, fontSize: size,fontWeight: FontWeight.bold,);
  }
  static TextStyle lightTextStyle (double size){
   return TextStyle(color: Colors.black, fontSize: size,fontFamily: "Raleway",fontWeight: FontWeight.w400,);
  }
}