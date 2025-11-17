import 'package:flutter/material.dart';
import 'package:pharmacy_app/pages/detail_page.dart';

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
      backgroundColor: const Color(0xFFF4F6FA), // Fondo premium
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ---------------------------------------
              ///        CABECERA 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset(
                      "images/perfil.png",
                      height: 55,
                      width: 55,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Icon(
                    Icons.notifications_none_rounded,
                    size: 32,
                    color: Color(0xFF415696),
                  )
                ],
              ),

              const SizedBox(height: 28),

              /// TITULOS PREMIUM
              Text("Your Trusted",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF415696),
                  )),
              Text("Online Pharmacy",
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  )),

              const SizedBox(height: 28),

              /// ---------------------------------------
              ///        SEARCH BAR
              /// ---------------------------------------
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search medicine...",
                    hintStyle: TextStyle(
                      color: Colors.black38,
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(Icons.search_rounded,
                        size: 28, color: Color(0xFF415696)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              /// ---------------------------------------
              ///       CATEGORÍAS PREMIUM
              /// ---------------------------------------
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    premiumCategory("All", allmedicine, () {
                      setState(() {
                        allmedicine = true;
                        suppliment = false;
                        vitamins = false;
                        herbal = false;
                      });
                    }),
                    SizedBox(width: 15),
                    premiumCategory("Supplements", suppliment, () {
                      setState(() {
                        allmedicine = false;
                        suppliment = true;
                        vitamins = false;
                        herbal = false;
                      });
                    }),
                    SizedBox(width: 15),
                    premiumCategory("Vitamins", vitamins, () {
                      setState(() {
                        allmedicine = false;
                        suppliment = false;
                        vitamins = true;
                        herbal = false;
                      });
                    }),
                    SizedBox(width: 15),
                    premiumCategory("Herbal", herbal, () {
                      setState(() {
                        allmedicine = false;
                        suppliment = false;
                        vitamins = false;
                        herbal = true;
                      });
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              /// ---------------------------------------
              ///        LISTA DE MEDICINAS (CARDS)
              /// ---------------------------------------
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      buildMedicineCard(context),
                      const SizedBox(height: 25),
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

  /// -------------------------------------------------
  ///       CATEGORÍA PREMIUM 
  /// -------------------------------------------------
  Widget premiumCategory(String title, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        decoration: BoxDecoration(
          color: active ? Color(0xFF415696) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Color(0xFF415696),
            width: 1.4,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: active ? 10 : 5,
            )
          ],
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

  /// -------------------------------------------------
  ///         TARJETA DE MEDICINA
  /// -------------------------------------------------
  Widget buildMedicineCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const DetailPage()),
        );
      },
      child: Container(
        height: 270,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(0, 6),
            )
          ],
        ),
        child: Row(
          children: [
            /// Imagen del medicamento
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Image.asset(
                  "images/medicine.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),

            /// Información
            Expanded(
              flex: 5,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Unique Medicine",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF415696),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Oxmas – Premium Healing Formula",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "\$100.00",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF415696),
                      ),
                    ),
                  )

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
