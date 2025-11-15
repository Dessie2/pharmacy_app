import 'package:flutter/material.dart';
import 'package:pharmacy_app/widgets/support_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool allmedicine = true, suppliment = false, vitamins=false, herbal=false;
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

              // BARRA DE BÚSQUEDA CORREGIDA
              Container(
                // Fondo para el campo de texto (el violeta claro)
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white, width: 1.5),
                  color: const Color.fromARGB(255, 233, 230, 247), // Color más similar al del fondo del campo de texto
                ),
                child: TextField(
                  // padding horizontal de 20 para el texto. El padding del Container ya no se usa.
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search Medicine...", // Corregido el texto de pista
                    hintStyle: AppWidget.lightTextStyle(18.0).copyWith(
                      color: const Color.fromARGB(255, 140, 137, 183), // Color de texto de pista más acorde
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Ajusta el padding interno del texto
                    suffixIcon: Container(
                      // El alto y ancho del botón de búsqueda.
                      width: 100, // Ajusta el ancho para ser una píldora
                      margin: const EdgeInsets.only(top: 3, bottom: 3, right: 3), // Pequeño margen para que se vea como un botón "pegado"
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30),
                         // Borde circular para el botón de búsqueda
                      ),
                      child: const Icon(Icons.search, color: Colors.white, size: 24),
                    ),
                  ),
                  style: const TextStyle(fontSize: 18), // Estilo para el texto que se escribe
                ),
              ), 


              const SizedBox(height: 20),

              // LISTA
              Container(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                   allmedicine? AppWidget.selectCategory("All Medicines"): GestureDetector(
                      onTap: (){
                        allmedicine = true;
                        suppliment = false;
                        vitamins = false;
                        herbal = false;
                        setState(() {

                        });
                      },
                    child: Container(
                      height: 50,
                      child: Center(child: Text("All Medicine", style: AppWidget.lightTextStyle(20.0),)))),
                    SizedBox(width: 30),
                    suppliment? AppWidget.selectCategory("Suppliment"): GestureDetector(
                      onTap: (){
                        allmedicine = false;
                        suppliment = true;
                        vitamins = false;
                        herbal = false;
                        setState(() {

                        });
                      },
                    child: Container(
                      height: 50,
                      child: Center(child: Text("supliment", style: AppWidget.lightTextStyle(20.0),)))),
                      SizedBox(width: 30),
                    vitamins? AppWidget.selectCategory("Vitamins"): GestureDetector(
                      onTap: (){
                        allmedicine = false;
                        suppliment = false;
                        vitamins = true;
                        herbal = false;
                        setState(() {

                        });
                      },
                    child: Container(
                      height: 50,
                      child: Center(child: Text("Vitamins", style: AppWidget.lightTextStyle(20.0),)))),
                       SizedBox(width: 30),
                    herbal? AppWidget.selectCategory("Herbal"): GestureDetector(
                      onTap: (){
                        allmedicine = false;
                        suppliment = false;
                        vitamins = false;
                        herbal = true;
                        setState(() {

                        });
                      },
                    child: Container(
                      height: 50,
                      child: Center(child: Text("Herbal", style: AppWidget.lightTextStyle(20.0),)))),
                  ],),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xffbab3a6),Color(0xffddd7cd)])),
                  child: Stack(children: [
                 Image.asset("images/medicine.png", height: 60, width: 60, fit: BoxFit.cover,),
                ],
                ),)
        ],),
        ),
      ),
    );
  }
}