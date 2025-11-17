import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA), // Fondo premium suave
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo o ícono de farmacia
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

              // Título principal
              const Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF415696),
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Your health is our priority.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 40),

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

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot password?",
                  style: TextStyle(
                    color: Color(0xFF415696),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Botón premium
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

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // INPUT PREMIUM
  Widget _inputField({
    required String label,
    bool obscure = false,
    required IconData icon,
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
          )
        ],
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: TextField(
          obscureText: obscure,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
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
