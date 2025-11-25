import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmacy_app/pages/bottom_nav.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final User? user = FirebaseAuth.instance.currentUser;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadUserFromFirestore();
  }

  /// ==========================
  /// 🔹 CARGAR DATOS CON UID
  /// ==========================
  Future<void> loadUserFromFirestore() async {
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();

    if (doc.exists) {
      nameController.text = doc["name"];
      emailController.text = doc["email"];
    }

    setState(() => loading = false);
  }

  /// ==========================
  /// 🔹 GUARDAR CAMBIOS DEL NOMBRE
  /// ==========================
  Future<void> updateUserName() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .update({"name": nameController.text});

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Profile updated")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF415696),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// ===========================
                    /// FOTO + NOMBRE DESDE FIRESTORE
                    /// ===========================
                    Center(
                      child: Column(
                        children: [
                          Container(
                            height: 110,
                            width: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Color(0xFF4B53A6), width: 3),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                "images/perfil.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          Text(
                            nameController.text,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4B53A6),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// ===========================
                    /// CAMPOS EDITABLES
                    /// ===========================
                    const Text("Name",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF4B53A6),
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    inputBox(nameController),

                    const SizedBox(height: 20),

                    const Text("Email",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF4B53A6),
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    inputBox(emailController, enabled: false),

                    const SizedBox(height: 35),

                    /// ===========================
                    /// MY ORDERS
                    /// ===========================
                    buildOptionTile(
                      icon: Icons.shopping_bag,
                      title: "My Orders",
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const BottomNav(initialTab: 1),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 25),

                    /// ===========================
                    /// SAVE CHANGES
                    /// ===========================
                    GestureDetector(
                      onTap: updateUserName,
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          color: Color(0xFF415696),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Center(
                          child: Text(
                            "Save Changes",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// ===========================
                    /// LOG OUT
                    /// ===========================
                    GestureDetector(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacementNamed(context, "/login");
                      },
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Center(
                          child: Text(
                            "Log Out",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }

  /// ===========================
  /// INPUT BOX
  /// ===========================
  Widget inputBox(TextEditingController controller, {bool enabled = true}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              blurRadius: 10, offset: Offset(0, 4), color: Colors.black12),
        ],
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        decoration: const InputDecoration(border: InputBorder.none),
      ),
    );
  }

  /// ===========================
  /// OPCIÓN DEL MENÚ
  /// ===========================
  Widget buildOptionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              offset: Offset(0, 5),
              color: Colors.black12,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Color(0xFF4B53A6), size: 28),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xFF4B53A6),
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios,
                size: 18, color: Colors.black38),
          ],
        ),
      ),
    );
  }
}
