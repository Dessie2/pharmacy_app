import 'package:flutter/material.dart';
import 'package:pharmacy_app/widgets/support_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 185, 183, 232),
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.asset("images/perfil.png",height: 60, width: 60, fit: BoxFit.cover,),),
            SizedBox(height: 30.0,),
               Text("Your Trusted", style:AppWidget.headlineTextStyle(26.0)),
                Text("Online Pharmacy", style:AppWidget.lightTextStyle(28.0)),
            SizedBox(height: 30.0,),
        Padding(
          padding: const EdgeInsets.only(right: 30.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                padding: EdgeInsets.only(left: 30.0),
              
                decoration: BoxDecoration(color: Color.fromARGB(255, 225, 229, 248),borderRadius: BorderRadius.circular(30), border:Border.all(color: Colors.white, width: 1.5)),
                child: Center(
                  child: TextField(
                    decoration: InputDecoration(border:InputBorder.none, hintText: "Search medicine", hintStyle: AppWidget.lightTextStyle(18.0), suffixIcon: Container(
                                margin: EdgeInsets.all(3),
                                width: 100,
                                
                                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(30)),
                                child: Icon(Icons.search, color: Colors.white,),
                              )),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.0,),
            
          ],
                ),
        ),
        ListView(children: [
          Container(
            decoration: BoxDecoration(color: Colors.black),
            child: Text("All medicine", style: TextStyle(color: Colors.white),),
          )
        ],)
          ],),),
    );
  }
}