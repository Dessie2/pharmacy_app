import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmacy_app/services/shared_pref.dart';
import 'add_product.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool loading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ------------ LOGIN ADMIN ---------------
  loginUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage("All fields are required");
      return;
    }

    setState(() => loading = true);

    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;

      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();

      if (!userDoc.exists || userDoc.get('role') != 'admin') {
        await _auth.signOut();

        if (!mounted) return;
        _showMessage("You are not an administrator");

        setState(() => loading = false);
        return;
      }

      await SharedpreferencesHelper().saveUserEmail(email);

      if (!mounted) return;
      _showMessage("Welcome Admin!", success: true);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AddProductPage()),
      );
    } catch (e) {
      if (!mounted) return;
      _showMessage("Login error: $e");
    }

    if (mounted) {
      setState(() => loading = false);
    }
  }

  void _showMessage(String text, {bool success = false}) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: success ? Colors.green : Colors.red,
        content: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF415696)),
            )
          : Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(28),
                child: Column(
                  children: [
                    const Icon(
                      Icons.admin_panel_settings,
                      size: 100,
                      color: Color(0xFF415696),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Admin Login",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF415696),
                      ),
                    ),

                    const SizedBox(height: 30),

                    _inputField(
                      label: "Admin Email",
                      controller: emailController,
                      icon: Icons.email_outlined,
                    ),

                    const SizedBox(height: 18),

                    _inputField(
                      label: "Password",
                      controller: passwordController,
                      obscure: true,
                      icon: Icons.lock_outline,
                    ),

                    const SizedBox(height: 30),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF415696),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: () => loginUser(),
                      child: const Text(
                        "Login",
                        style:
                            TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _inputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool obscure = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border:
            Border.all(color: const Color(0xFF415696), width: 1.3),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
            prefixIcon: Icon(icon, color: Color(0xFF415696)),
          ),
        ),
      ),
    );
  }
}
