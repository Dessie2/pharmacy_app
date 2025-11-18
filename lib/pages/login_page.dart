import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmacy_app/services/shared_pref.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controladores
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool loading = false;

  // =========================
  //       LOGIN FIREBASE
  // =========================
  loginUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage("All fields are required");
      return;
    }

    setState(() => loading = true);

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Guardar datos del usuario localmente
      await SharedpreferencesHelper().saveUserEmail(email);

      _showMessage("Welcome back!", success: true);

      // Ir al home
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        _showMessage("No user found with that email");
      } else if (e.code == "wrong-password") {
        _showMessage("Incorrect password");
      } else if (e.code == "invalid-email") {
        _showMessage("Invalid email format");
      } else {
        _showMessage("Login failed: ${e.message}");
      }
    }

    setState(() => loading = false);
  }

  void _showMessage(String text, {bool success = false}) {
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

      // LOADING
      body: loading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF415696)))
          : Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // LOGO
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/welcome'),
                      child: Container(
                        height: 95,
                        width: 95,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 12,
                              offset: Offset(0, 4),
                            )
                          ],
                        ),
                        child: const Icon(
                          Icons.local_pharmacy_rounded,
                          color: Color(0xFF415696),
                          size: 55,
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    const Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF415696),
                        letterSpacing: 0.5,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // INPUT EMAIL
                    _inputField(
                      label: "Email",
                      controller: emailController,
                      icon: Icons.email_outlined,
                    ),

                    const SizedBox(height: 18),

                    // INPUT PASSWORD
                    _inputField(
                      label: "Password",
                      controller: passwordController,
                      obscure: true,
                      icon: Icons.lock_outline,
                    ),

                    const SizedBox(height: 30),

                    // BOTÓN LOGIN
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF415696),
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 80,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        elevation: 5,
                      ),
                      onPressed: () => loginUser(),
                      child: const Text(
                        "Sign in",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/signup'),
                      child: const Text(
                        "Create a new account",
                        style: TextStyle(
                          color: Color(0xFF415696),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  // =========================
  //  INPUT FIELD PREMIUM
  // =========================
  Widget _inputField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    bool obscure = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF415696),
          width: 1.4,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 3),
          )
        ],
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Colors.black54),
            prefixIcon: Icon(icon, color: Color(0xFF415696)),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
