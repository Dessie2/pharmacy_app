import 'package:pharmacy_app/services/shared_pref.dart';
import 'package:random_string/random_string.dart';
import 'package:pharmacy_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  bool loading = false;

  //===========================================================
  //               REGISTRO COMPLETO CON FIREBASE
  //===========================================================
  Future<void> registration() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPassController.text.trim();

    // ----------------------------------------------------------
    // Validaciones básicas
    // ----------------------------------------------------------
    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      showSnack("All fields are required", Colors.red);
      return;
    }

    if (password.length < 6) {
      showSnack("Password must be at least 6 characters", Colors.red);
      return;
    }

    if (password != confirmPassword) {
      showSnack("Passwords do not match", Colors.red);
      return;
    }

    setState(() => loading = true);

    try {
      // Crear usuario en Auth
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // ID único
      String id = randomAlphaNumeric(12);

      // Datos para Firestore
      Map<String, dynamic> userInfoMap = {
        "id": id,
        "name": name,
        "email": email,
        "createdAt": DateTime.now().millisecondsSinceEpoch,
      };

      // Guardar en SharedPreferences
      await SharedpreferencesHelper().saveUserId(id);
      await SharedpreferencesHelper().saveUserEmail(email);
      await SharedpreferencesHelper().saveUserName(name);

      // Guardar en Firestore
      await DatabaseMethods().addUserInfo(userInfoMap, id);
     

      showSnack("Registered Successfully!", Colors.green);

      // Navegar al Home
      Navigator.pushNamed(context, '/home');

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnack("The password provided is too weak.", Colors.red);
      } else if (e.code == 'email-already-in-use') {
        showSnack("This email is already registered.", Colors.red);
      } else {
        showSnack("Error: ${e.message}", Colors.red);
      }
    }

    setState(() => loading = false);
  }

  //===========================================================
  //                  MENSAJES (Snackbars)
  //===========================================================
  void showSnack(String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(text),
      ),
    );
  }

  //===========================================================
  //                          UI
  //===========================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/welcome');
                },
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
                "Create Account",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF415696),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Start your journey to better health.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 40),

              _inputField(label: "Full Name", icon: Icons.person_outline, controller: nameController),
              const SizedBox(height: 18),

              _inputField(label: "Email", icon: Icons.email_outlined, controller: emailController),
              const SizedBox(height: 18),

              _inputField(label: "Password", obscure: true, icon: Icons.lock_outline, controller: passwordController),
              const SizedBox(height: 18),

              _inputField(label: "Confirm Password", obscure: true, icon: Icons.lock_outline, controller: confirmPassController),

              const SizedBox(height: 35),

              loading
                  ? const CircularProgressIndicator(color: Color(0xFF415696))
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF415696),
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        elevation: 5,
                      ),
                      onPressed: registration,
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),

              const SizedBox(height: 28),

              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/login'),
                child: const Text(
                  "Already have an account? Login",
                  style: TextStyle(
                    color: Color(0xFF415696),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  //===========================================================
  //                  INPUT FIELDS PREMIUM
  //===========================================================
  static Widget _inputField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    bool obscure = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Color(0xFF415696),
          width: 1.4,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
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
            labelStyle: const TextStyle(
              color: Colors.black54,
            ),
            prefixIcon: Icon(icon, color: Color(0xFF415696)),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
