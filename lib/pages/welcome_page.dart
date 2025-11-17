import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool isLoginSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),

            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8ECF8),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.local_pharmacy_rounded,
                      color: Color(0xFF4156A6),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Text(
                    "Pharmacy+",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Raleway",
                      color: Color(0xFF26314F),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // ------------------- IMAGEN ------------------- //
            SizedBox(
              height: 270,
              child: Image.asset(
                "images/welcome.png",
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 35),

            // ------------------- TÍTULO ------------------- //
            const Text(
              "Your Health,\nOur Priority",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C2C2C),
                height: 1.2,
              ),
            ),

            const SizedBox(height: 15),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Text(
                "Find trusted medicines, supplements\nand health essentials at the best price.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF707070),
                  height: 1.4,
                ),
              ),
            ),

            const SizedBox(height: 80),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // LOGIN
                isLoginSelected
                    ? _primaryButton(
                        label: "Login",
                        onTap: () {
                          setState(() => isLoginSelected = true);
                          Navigator.pushNamed(context, "/login");
                        },
                      )
                    : _textButton(
                        label: "Login",
                        onTap: () {
                          setState(() => isLoginSelected = true);
                          Navigator.pushNamed(context, "/login");
                        },
                      ),

                const SizedBox(width: 20),

                // REGISTER
                !isLoginSelected
                    ? _primaryButton(
                        label: "Register",
                        onTap: () {
                          setState(() => isLoginSelected = false);
                          Navigator.pushNamed(context, "/signup");
                        },
                      )
                    : _textButton(
                        label: "Register",
                        onTap: () {
                          setState(() => isLoginSelected = false);
                          Navigator.pushNamed(context, "/signup");
                        },
                      ),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ------------------- BOTÓN PRINCIPAL (RELLENO) ------------------- //
  Widget _primaryButton({required String label, required VoidCallback onTap}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4156A6),
        padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        elevation: 5,
      ),
      onPressed: onTap,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 18,
          fontFamily: 'Raleway',
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ------------------- BOTÓN DE TEXTO ------------------- //
  Widget _textButton({required String label, required VoidCallback onTap}) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 18,
          fontFamily: 'Raleway',
          color: Color(0xFF26314F),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
