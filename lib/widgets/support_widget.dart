import 'package:flutter/material.dart';

class AppWidget {

  static TextStyle headlineTextStyle (double size){
   return TextStyle(color: Colors.black, fontSize: size,fontWeight: FontWeight.bold,);
  }
  static TextStyle lightTextStyle (double size){
   return TextStyle(color: Colors.black, fontSize: size,fontFamily: "Raleway",fontWeight: FontWeight.w400,);
  }
  static  Widget selectCategory( String name){
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Material(
        elevation: 3.0,
          borderRadius: BorderRadius.circular(30),
            child: Container(

              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 50,
              decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
              child: Text(name,style: TextStyle(color: Colors.white, fontSize: 18),
               ),
             ),
          ),
       ),
    );
  }
  static TextStyle whiteTextStyle (double size){
   return TextStyle(color: Colors.white, fontSize: size,fontWeight: FontWeight.bold,);
  }
}