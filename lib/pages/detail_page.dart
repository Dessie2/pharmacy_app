import 'package:flutter/material.dart';
import 'package:pharmacy_app/pages/bottom_nav.dart';

/// Clase global para almacenar las órdenes
class OrderData {
  static List<Map<String, dynamic>> orders = [];
}

class DetailPage extends StatefulWidget {
  final String name;
  final String description;
  final String company;
  final String price;
  final String image;

  const DetailPage({
    super.key,
    required this.name,
    required this.description,
    required this.company,
    required this.price,
    this.image = "images/medicine.png",
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    double unitPrice = double.tryParse(widget.price) ?? 0.0;
    double totalPrice = unitPrice * quantity;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 185, 183, 232),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                /// BOTÓN REGRESAR
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

                const SizedBox(height: 10),

                /// IMAGEN
                Center(
                  child: Image.asset(
                    widget.image, // <-- Imagen dinámica por categoría
                    height: MediaQuery.of(context).size.height * 0.30,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 20),

                /// CONTENEDOR PRINCIPAL
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

                      /// TÍTULO + CONTADOR
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          
                          Expanded(
                            child: Text(
                              widget.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4B53A6),
                                height: 1.3,
                              ),
                            ),
                          ),

                          /// CONTADOR
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
                                  child: const Icon(Icons.remove, color: Color(0xFF4B53A6)),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  quantity.toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                GestureDetector(
                                  onTap: () => setState(() => quantity++),
                                  child: const Icon(Icons.add, color: Color(0xFF4B53A6)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      /// COMPAÑÍA
                      Text(
                        widget.company,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// DESCRIPTION
                      const Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4B53A6),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        widget.description,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 30),

                      /// TOTAL + BOTÓN ORDENAR
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(180, 255, 255, 255),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            
                            /// TOTAL
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Total Price:",
                                  style: TextStyle(fontSize: 18, color: Colors.black54),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "\$${totalPrice.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 26,
                                    color: Color(0xFF4B53A6),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            /// BOTÓN ORDENAR
                            GestureDetector(
                              onTap: () {
                                double total =
                                    (double.tryParse(widget.price) ?? 0) * quantity;

                                // Guardar orden
                                OrderData.orders.add({
                                  "name": widget.name,
                                  "company": widget.company,
                                  "description": widget.description,
                                  "quantity": quantity,
                                  "price": widget.price,
                                  "totalPrice": total,
                                  "image": widget.image,
                                });

                                // Mandar a Order dentro de BottomNav TAB 1
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const BottomNav(initialTab: 1),
                                  ),
                                );
                              },
                              child: Container(
                                height: 50,
                                width: 180,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF4B53A6),
                                      Color(0xFF8C92E9),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 12,
                                      offset: Offset(0, 4),
                                      color: Colors.black26,
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Text(
                                    "Order Now",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
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
