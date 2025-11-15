import 'package:flutter/material.dart';
import 'package:pharmacy_app/widgets/support_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool allmedicine = true, suppliment = false, vitamins = false, herbal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 185, 183, 232),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // FOTO PERFIL
              ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.asset(
                  "images/perfil.png",
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 30),

              // TITULOS
              Text("Your Trusted", style: AppWidget.headlineTextStyle(26.0)),
              Text("Online Pharmacy", style: AppWidget.lightTextStyle(28.0)),

              const SizedBox(height: 30),

              // BARRA DE BÚSQUEDA
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white, width: 1.5),
                  color: const Color.fromARGB(255, 233, 230, 247),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search Medicine...",
                    hintStyle: AppWidget.lightTextStyle(18.0).copyWith(
                      color: const Color.fromARGB(255, 140, 137, 183),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    suffixIcon: Container(
                      margin: const EdgeInsets.only(top: 3, bottom: 3, right: 3),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(Icons.search, color: Colors.white, size: 24),
                    ),
                  ),
                  style: const TextStyle(fontSize: 18),
                ),
              ),

              const SizedBox(height: 20),

              // CATEGORÍAS
              Container(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    allmedicine
                        ? AppWidget.selectCategory("All Medicines")
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                allmedicine = true;
                                suppliment = false;
                                vitamins = false;
                                herbal = false;
                              });
                            },
                            child: Container(
                              height: 50,
                              child: Center(
                                child: Text("All Medicine", style: AppWidget.lightTextStyle(20.0)),
                              ),
                            ),
                          ),
                    SizedBox(width: 30),

                    suppliment
                        ? AppWidget.selectCategory("Suppliment")
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                allmedicine = false;
                                suppliment = true;
                                vitamins = false;
                                herbal = false;
                              });
                            },
                            child: Container(
                              height: 50,
                              child: Center(
                                child: Text("Suppliment", style: AppWidget.lightTextStyle(20.0)),
                              ),
                            ),
                          ),
                    SizedBox(width: 30),

                    vitamins
                        ? AppWidget.selectCategory("Vitamins")
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                allmedicine = false;
                                suppliment = false;
                                vitamins = true;
                                herbal = false;
                              });
                            },
                            child: Container(
                              height: 50,
                              child: Center(
                                child: Text("Vitamins", style: AppWidget.lightTextStyle(20.0)),
                              ),
                            ),
                          ),
                    SizedBox(width: 30),

                    herbal
                        ? AppWidget.selectCategory("Herbal")
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                allmedicine = false;
                                suppliment = false;
                                vitamins = false;
                                herbal = true;
                              });
                            },
                            child: Container(
                              height: 50,
                              child: Center(
                                child: Text("Herbal", style: AppWidget.lightTextStyle(20.0)),
                              ),
                            ),
                          ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // TODO el contenido largo → SCROLL
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      // TARJETA 1
                      buildMedicineCard(context),

                      SizedBox(height: 20),

                      // TARJETA 2
                      buildMedicineCard(context),

                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  // TARJETA REUTILIZABLE
  Widget buildMedicineCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 186, 179, 166),
            Color.fromARGB(255, 221, 215, 205),
            Color.fromARGB(255, 165, 156, 143),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffc8c1b5),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                "images/medicine.png",
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(253, 200, 193, 181),
                      border: Border.all(color: Colors.white, width: 1.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Unique Medicine", style: AppWidget.whiteTextStyle(20.0)),
                            Text("\$100.00", style: AppWidget.whiteTextStyle(20.0)),
                          ],
                        ),
                        Text("Oxmas", style: AppWidget.whiteTextStyle(20.0)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
