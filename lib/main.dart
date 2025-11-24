import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pharmacy_app/admin/AdminLoginPage.dart';
import 'firebase_options.dart';

// Importaciones de las páginas de usuario
import 'package:pharmacy_app/pages/home.dart';
//import 'package:pharmacy_app/pages/detail_page.dart';
import 'package:pharmacy_app/pages/login_page.dart';
import 'package:pharmacy_app/pages/signup_page.dart';
import 'package:pharmacy_app/pages/welcome_page.dart';
import 'package:pharmacy_app/pages/bottom_nav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase con las opciones generadas por FlutterFire
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Definimos el color principal para las rutas que no usan el Theme
    // const Color primaryColor = Color(0xFF415696);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pharmacy App',

      theme: ThemeData(
        // Puedes ajustar la seedColor a tu color principal (ej. 0xFF415696)
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF415696)),
        useMaterial3: true,
      ),

      routes: {
        // --- RUTAS DE USUARIO GENERALES ---
        '/welcome': (context) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const Home(),
        //widgets'/detail': (context) => const DetailPage(),
        '/bottom-nav': (context) => const BottomNav(),

        // --- RUTAS DEL ADMINISTRADOR ---
        '/admin/login': (context) => const AdminLoginPage(),
      },

      initialRoute: '/welcome',
    );
  }
}
