import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_app/pages/home.dart';
import 'package:pharmacy_app/pages/order.dart';
import 'package:pharmacy_app/pages/profile.dart';
import 'package:pharmacy_app/pages/wallet.dart';

class BottomNav extends StatefulWidget {
  final int initialTab;

  const BottomNav({super.key, this.initialTab = 0});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late List<Widget> pages;

  late Home home;
  late Profile profile;
  late Wallet wallet;
  late Order order;

  int currentTabIndex = 0;

  static const Color _scaffoldBackgroundColor = Color(0xFFF4F6FA);

  @override
  void initState() {
    super.initState();

    // Establecer el tab inicial
    currentTabIndex = widget.initialTab;

    home = const Home();
    profile = const Profile();
    wallet = const Wallet();
    order = const Order();

    pages = [home, order, wallet, profile];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scaffoldBackgroundColor,
      body: pages[currentTabIndex],

      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        backgroundColor: _scaffoldBackgroundColor,
        color: const Color(0xFF415696),
        animationDuration: const Duration(milliseconds: 400),
        index: currentTabIndex,

        onTap: (index) {
          setState(() {
            currentTabIndex = index;
          });
        },

        items: [
          currentTabIndex == 0
              ? const Icon(Icons.home, color: Colors.white, size: 30)
              : const Icon(Icons.home_outlined, color: Colors.white),

          currentTabIndex == 1
              ? const Icon(Icons.shopping_bag, color: Colors.white, size: 30)
              : const Icon(Icons.shopping_bag_outlined, color: Colors.white),

          currentTabIndex == 2
              ? const Icon(Icons.account_balance_wallet, color: Colors.white, size: 30)
              : const Icon(Icons.account_balance_wallet_outlined, color: Colors.white),

          currentTabIndex == 3
              ? const Icon(Icons.person, color: Colors.white, size: 30)
              : const Icon(Icons.person_outline, color: Colors.white),
        ],
      ),
    );
  }
}
