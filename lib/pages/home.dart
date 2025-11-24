import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmacy_app/pages/detail_page.dart';
import 'package:pharmacy_app/pages/welcome_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool allmedicine = true, suppliment = false, vitamins = false, herbal = false;

  Stream<QuerySnapshot>? productStream;

  getProducts(String category) async {
    productStream = FirebaseFirestore.instance
        .collection("products")
        .where("category", isEqualTo: category)
        .snapshots();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getProducts("Medicine");
  }

  Widget allProducts() {
    if (productStream == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return StreamBuilder(
      stream: productStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data.docs.length == 0) {
          return const Center(
            child: Text(
              "No products found",
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            var ds = snapshot.data.docs[index];
            return buildMedicineCard(
              context,
              ds["name"],
              ds["description"],
              ds["company"],
              ds["price"].toString(),
              ds["category"],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 BARRA SUPERIOR SIN CAMPANA
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  PopupMenuButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    offset: const Offset(0, 60),
                    iconSize: 55,
                    icon: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.asset(
                        "images/perfil.png",
                        height: 55,
                        width: 55,
                        fit: BoxFit.cover,
                      ),
                    ),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: "logout",
                        child: Row(
                          children: const [
                            Icon(Icons.logout, color: Colors.red),
                            SizedBox(width: 10),
                            Text("Cerrar sesión"),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (value) async {
                      if (value == "logout") {
                        await FirebaseAuth.instance.signOut();

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WelcomePage(),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),

              const SizedBox(height: 25),
              const Text(
                "Your Trusted",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF415696),
                ),
              ),
              const Text(
                "Online Pharmacy",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 25),

              /// 🔹 CATEGORÍAS
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    premiumCategory("Medicine", allmedicine, () {
                      setState(() {
                        allmedicine = true;
                        suppliment = vitamins = herbal = false;
                      });
                      getProducts("Medicine");
                    }),
                    SizedBox(width: 15),
                    premiumCategory("Supplement", suppliment, () {
                      setState(() {
                        suppliment = true;
                        allmedicine = vitamins = herbal = false;
                      });
                      getProducts("Supplement");
                    }),
                    SizedBox(width: 15),
                    premiumCategory("Vitamins", vitamins, () {
                      setState(() {
                        vitamins = true;
                        allmedicine = suppliment = herbal = false;
                      });
                      getProducts("Vitamins");
                    }),
                    SizedBox(width: 15),
                    premiumCategory("Herbal", herbal, () {
                      setState(() {
                        herbal = true;
                        allmedicine = suppliment = vitamins = false;
                      });
                      getProducts("Herbal");
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Expanded(child: allProducts()),
            ],
          ),
        ),
      ),
    );
  }

  Widget premiumCategory(String title, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        decoration: BoxDecoration(
          color: active ? Color(0xFF415696) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xFF415696), width: 1.4),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: active ? Colors.white : Color(0xFF415696),
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  /// 🔹 TARJETA DE PRODUCTO CON IMAGEN SEGÚN CATEGORÍA
  Widget buildMedicineCard(
    BuildContext context,
    String name,
    String description,
    String company,
    String price,
    String category,
  ) {
    // Imagen según categoría
    String imagePath = "images/medicine.png";

    if (category == "Supplement") imagePath = "images/supplements.png";
    if (category == "Vitamins") imagePath = "images/vitamins.png";
    if (category == "Herbal") imagePath = "images/herbal.png";

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              name: name,
              description: description,
              company: company,
              price: price,
              image: imagePath, // imagen dinámica
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        height: 260,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Image.asset(imagePath, fit: BoxFit.contain),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF415696),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      company,
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "\$$price",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF415696),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
