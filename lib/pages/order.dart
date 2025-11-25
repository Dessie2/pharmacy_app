import 'package:flutter/material.dart';
import 'package:pharmacy_app/pages/bottom_nav.dart';
import 'package:pharmacy_app/services/database.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// BOTÓN REGRESAR
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BottomNav(initialTab: 0),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Color(0xFF415696),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Order Page",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF415696),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// 🔥 LISTA DE ÓRDENES DESDE FIRESTORE
              Expanded(
                child: StreamBuilder(
                  stream: DatabaseMethods().getOrders(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final orders = snapshot.data!.docs;

                    if (orders.isEmpty) {
                      return const Center(
                        child: Text(
                          "No orders yet",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final data =
                            orders[index].data() as Map<String, dynamic>;
                        final id = orders[index].id;

                        return buildOrderCard(
                          id: id,
                          name: data["name"],
                          quantity: data["quantity"].toString(),
                          company: data["company"],
                          totalPrice: data["totalPrice"].toString(),
                          image: data["image"],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔥 CARD DE ÓRDENES CON DELETE FIRESTORE
  Widget buildOrderCard({
    required String id,
    required String name,
    required String quantity,
    required String company,
    required String totalPrice,
    required String image,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          /// IMAGEN
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              image,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 15),

          /// INFO DE LA ORDEN
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF415696),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "Quantity : $quantity",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),

                Text(
                  company,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "Total Price : \$$totalPrice",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF415696),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          /// 🔥 BOTÓN ELIMINAR DESDE FIRESTORE
          IconButton(
            onPressed: () {
              DatabaseMethods().deleteOrder(id);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
