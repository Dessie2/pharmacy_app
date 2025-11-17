import 'package:flutter/material.dart';
import 'package:pharmacy_app/widgets/support_widget.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 185, 183, 232),
        body: Container(
            margin: EdgeInsets.only(top: 50.0),
            child: Column(children: [
                SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.only(left: 30.0),
            child: Row(children:[
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(60)),
                  child: Icon(Icons.arrow_back, color: Colors.black,),
              ),
            ],),
          ),
          Image.asset("images/medicine.png", height: MediaQuery.of( context).size.height/2.5, fit: BoxFit.cover,),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 30.0, right: 30.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: const Color.fromARGB(122, 255, 255, 255), border: Border.all(color: Colors.white, width: 2.0),borderRadius: BorderRadius.circular(20)),
            child: Stack(

                children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Hilma Tension\nRelief", style: AppWidget.headlineTextStyle(20),),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                            decoration: BoxDecoration(color: const Color.fromARGB(159, 255, 255, 255), borderRadius: BorderRadius.circular(30)),
                            child: Row(children: [
                                Icon(Icons.remove, color: Colors.black,),
                                SizedBox(width: 10.0),
                                Text(" 1 ", style: AppWidget.headlineTextStyle(18),),
                                SizedBox(width: 10.0),
                                Icon(Icons.add, color: Colors.black,),
                            ],),
                        )
                      ],
                    ),
                SizedBox(height: 20,),
                Text("Description", style: AppWidget.headlineTextStyle(16),),
                SizedBox(height: 10,),
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries. "),
                 ],
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(color: const Color.fromARGB(159, 255, 255, 255)),
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/4),
                  width: MediaQuery.of(context).size.width,
                    child: Row(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total Price:", style: AppWidget.lightTextStyle(18),),
                            Text(" \$ 34.99", style: AppWidget.headlineTextStyle(20),),
                         ],
                        ),
                        Container(
                          decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(30)),
                        )
                      ],),
                )
            ],
            ),
          )
        ],),),
    );
  }
}