import 'package:flutter/material.dart';
import 'package:pharmacy_app/widgets/support_widget.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 185, 183, 232),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// BOTÓN REGRESAR PREMIUM
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 12,
                          offset: Offset(0, 4),
                          color: Colors.black.withOpacity(0.18),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Color(0xFF4B53A6),
                    ),
                  ),
                ),

                const SizedBox(height: 5),
                Center(
                    child: Image.asset(
                      "images/medicine.png",
                      height: MediaQuery.of(context).size.height * 0.40,
                      fit: BoxFit.contain,
                    ),
                  ),
                const SizedBox(height: 5),

                /// CONTENEDOR DETALLES
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(150, 255, 255, 255),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 18,
                        offset: Offset(0, 6),
                        color: Colors.black.withOpacity(0.10),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// TITULO + CONTADOR
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Hilma Tension\nRelief",
                            style: AppWidget.headlineTextStyle(22).copyWith(
                              color: Color(0xFF4B53A6),
                              height: 1.3,
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(200, 255, 255, 255),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Color(0xFF4B53A6)),
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (quantity > 1) {
                                      setState(() => quantity--);
                                    }
                                  },
                                  child: const Icon(Icons.remove,
                                      color: Color(0xFF4B53A6)),
                                ),

                                const SizedBox(width: 12),

                                Text(quantity.toString(),
                                    style: AppWidget.headlineTextStyle(18)),

                                const SizedBox(width: 12),

                                GestureDetector(
                                  onTap: () {
                                    setState(() => quantity++);
                                  },
                                  child: const Icon(Icons.add,
                                      color: Color(0xFF4B53A6)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      /// DESCRIPCIÓN
                      Text("Description",
                          style: AppWidget.headlineTextStyle(18).copyWith(
                            color: Color(0xFF4B53A6),
                          )),

                      const SizedBox(height: 10),

                      Text(
                        "Natural plant-based formula designed to relieve "
                        "head tension and discomfort quickly and safely.",
                        style: AppWidget.lightTextStyle(16),
                      ),

                      const SizedBox(height: 30),

                      /// TOTAL + BOTÓN
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(180, 255, 255, 255),
                          borderRadius: BorderRadius.circular(15),
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Total Price:",
                                    style: AppWidget.lightTextStyle(18)),
                                const SizedBox(height: 5),
                                Text(
                                  "\$ ${(24.99 * quantity).toStringAsFixed(2)}",
                                  style: AppWidget.headlineTextStyle(22)
                                      .copyWith(color: Color(0xFF4B53A6)),
                                ),
                              ],
                            ),

                            Container(
                              height: 50,
                              width: 180,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF4B53A6),
                                    Color(0xFF8C92E9),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 12,
                                    offset: Offset(0, 4),
                                    color: Colors.black.withOpacity(0.18),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  "Order Now",
                                  style: AppWidget.whiteTextStyle(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
