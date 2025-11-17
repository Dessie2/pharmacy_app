import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA), // Fondo premium
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              // LOGO CLICKEABLE
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
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Icon(
                    Icons.local_pharmacy_rounded,
                    color: Color(0xFF415696),
                    size: 55,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // TÍTULO PREMIUM
              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF415696),
                  letterSpacing: 0.5,
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

              // CAMPOS PREMIUM
              _inputField(
                label: "Full Name",
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 18),

              _inputField(
                label: "Email",
                icon: Icons.email_outlined,
              ),
              const SizedBox(height: 18),

              _inputField(
                label: "Password",
                obscure: true,
                icon: Icons.lock_outline,
              ),
              const SizedBox(height: 18),

              _inputField(
                label: "Confirm Password",
                obscure: true,
                icon: Icons.lock_outline,
              ),

              const SizedBox(height: 35),

              // BOTÓN PREMIUM
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
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                child: const Text(
                  "Sign up",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    letterSpacing: 0.5,
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

  // INPUT PREMIUM FARMACIA
  static Widget _inputField({
    required String label,
    required IconData icon,
    bool obscure = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF415696),
          width: 1.4,
        ),
        boxShadow: [
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
          obscureText: obscure,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
              color: Colors.black54,
            ),
            prefixIcon: Icon(
              icon,
              color: Color(0xFF415696),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
