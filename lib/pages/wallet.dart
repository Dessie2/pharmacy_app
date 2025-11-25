import 'package:flutter/material.dart';


class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  int walletBalance = 200;
  int selectedAmount = 0;

  // Método para agregar dinero
  Future<void> addMoney() async {
    if (selectedAmount == 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please select an amount")));
      return;
    }

    try {
      // Aquí irá Stripe más adelante

      // Simulación
      setState(() {
        walletBalance += selectedAmount;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Added \$$selectedAmount to your wallet")),
      );
    } catch (e) {
      // Evita que la app se cierre si algo falla
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  // Botón de selección de monto
  Widget moneyButton(int amount) {
    bool isSelected = selectedAmount == amount;

    return GestureDetector(
      onTap: () {
        setState(() => selectedAmount = amount);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black),
        ),
        child: Text(
          "\$$amount",
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Tarjeta de transacción
  Widget transactionTile({
    required String icon,
    required String amount,
    required String type,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // 🔥 Previene crash por imagen faltante
          Image.asset(
            icon,
            width: 40,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.image_not_supported, size: 40),
          ),
          const SizedBox(width: 15),
          Text(
            "\$$amount",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: type == "CREDIT"
                  ? Colors.green.shade100
                  : Colors.red.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              type,
              style: TextStyle(
                color: type == "CREDIT" ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE6DEF8),
      appBar: AppBar(
        backgroundColor: const Color(0xffE6DEF8),
        elevation: 0,
        title: const Text(
          'Wallet Page',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Wallet card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/wallet.png",
                      width: 80,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.account_balance_wallet, size: 80),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Your Wallet",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "\$$walletBalance",
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Selección de montos
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  moneyButton(100),
                  moneyButton(200),
                  moneyButton(500),
                ],
              ),

              const SizedBox(height: 20),

              // Botón Add Money
              GestureDetector(
                onTap: addMoney,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 40,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.grey.shade300, Colors.grey.shade500],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "Add Money",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Transacciones
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Your Transactions",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    transactionTile(
                      icon: "images/credit.png",
                      amount: "200",
                      type: "CREDIT",
                    ),
                    transactionTile(
                      icon: "images/debit.png",
                      amount: "200",
                      type: "DEBIT",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
