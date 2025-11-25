import 'package:flutter/material.dart';
import 'package:pharmacy_app/services/database.dart'; 
import 'package:firebase_auth/firebase_auth.dart'; // Importación necesaria para el UID

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  // Inicializamos a 0. Se cargará desde Firestore.
  int walletBalance = 0; 
  int selectedAmount = 0;
  double totalOrdersPrice = 0.0; 

  // Referencia al usuario actual para obtener el UID
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    // 1. Cargamos el saldo del usuario
    _loadWalletBalance(); 
    // 2. Cargamos el total de órdenes
    _calculateTotalOrderPrice(); 
  }

  // MÉTODO PARA CARGAR EL SALDO DE FIRESTORE
  Future<void> _loadWalletBalance() async {
    if (currentUser == null) {
      // Manejar si el usuario no está autenticado
      return;
    }
    
    try {
      final userDoc = await DatabaseMethods().getUserInfo(currentUser!.uid);
      
      if (userDoc.exists) {
        // Asegúrate de que el campo en Firestore se llama 'walletBalance'
        final balance = userDoc.data()?['walletBalance']; 
        
        if (balance is num) {
          setState(() {
            walletBalance = balance.toInt();
          });
        }
      }
    } catch (e) {
      print("Error loading wallet balance: $e");
    }
  }


  // Método para simular transacciones de CRÉDITO o DÉBITO
  void processTransaction({required double amount, required String type}) async {
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error: User not authenticated.")),
      );
      return;
    }
    
    // Transacción de CRÉDITO: Agregar dinero
    if (type == "CREDIT") {
      setState(() {
        walletBalance += amount.toInt(); 
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Success: Received \$${amount.toInt()} (Credit)")),
      );
    } 
    // Transacción de DÉBITO: PAGAR ÓRDENES
    else if (type == "DEBIT_ORDERS") {
      if (walletBalance >= amount) {
        double change = walletBalance - amount;
        
        // 1. Deducir el monto total del balance de la billetera
        setState(() {
          // Asignamos el cambio (restante) al walletBalance
          walletBalance = change.toInt(); 
        });

        // 2. Limpiar la lista de órdenes en Firestore
        await DatabaseMethods().clearAllOrders();
        
        // 3. Resetear el Orders Total a cero
        setState(() {
          totalOrdersPrice = 0.0;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Order Paid! Change: \$${change.toStringAsFixed(2)}"
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error: Insufficient balance to pay orders")),
        );
      }
    }
    
    // Guardar el nuevo saldo en Firestore después de cualquier transacción
    await DatabaseMethods().updateWalletBalance(currentUser!.uid, walletBalance);
  }

  // Método para calcular el precio total de todas las órdenes
  Future<void> _calculateTotalOrderPrice() async {
    double tempTotal = 0.0;
    
    final snapshot = await DatabaseMethods().getOrders().first; 

    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final price = data["totalPrice"];

      if (price != null) {
        if (price is num) {
          tempTotal += price.toDouble();
        } else if (price is String) {
          tempTotal += double.tryParse(price) ?? 0.0;
        }
      }
    }

    setState(() {
      totalOrdersPrice = tempTotal;
    });
  }

  // Método para agregar dinero (usa processTransaction)
  Future<void> addMoney() async {
    if (selectedAmount == 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please select an amount")));
      return;
    }
    
    processTransaction(amount: selectedAmount.toDouble(), type: "CREDIT");
    
    // Reseteamos el monto seleccionado después de añadirlo
    setState(() {
      selectedAmount = 0;
    });
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
          color: isSelected ? const Color(0xFF415696) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF415696)),
          boxShadow: const [
             BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          "\$$amount",
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF415696),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Tarjeta de transacción (solo se usará para DEBIT_ORDERS)
  Widget transactionTile({
    required String icon,
    required String label,
    required String type,
  }) {
    // Si la transacción es para pagar órdenes, usamos el total dinámico
    double amount = (type == "DEBIT_ORDERS") ? totalOrdersPrice : 0.0;
    
    return GestureDetector(
      onTap: () {
        // Lógica para pagar el total de órdenes
        if (type == "DEBIT_ORDERS" && amount > 0) {
          processTransaction(amount: amount, type: type);
        } else if (type == "DEBIT_ORDERS" && amount == 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No orders to pay.")),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
             BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              "images/debit.png", // Usamos el icono de débito por defecto
              width: 40,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.payment, size: 40),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Amount: \$${amount.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 16, 
                      color: Colors.red.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.red.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "PAY",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tarjeta individual de pedido (reutilizada de Order Page)
  Widget buildOrderCard({
    required String id,
    required String name,
    required String quantity,
    required String company,
    required String totalPrice,
    required String image,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// IMAGEN
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              image,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.image_not_supported, size: 70),
            ),
          ),

          const SizedBox(width: 15),

          /// INFO DE LA ORDEN
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF415696),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Quantity : $quantity",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                Text(
                  company,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Total Price : \$$totalPrice",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF415696),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          /// BOTÓN ELIMINAR DESDE FIRESTORE
          IconButton(
            onPressed: () {
              DatabaseMethods().deleteOrder(id);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 28,
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
        automaticallyImplyLeading: false, 
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
              // Wallet card (Muestra el saldo y el total de órdenes)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                     BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 6),
                    ),
                  ],
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
                      "Your Wallet Balance",
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
                    const SizedBox(height: 15),
                    Text(
                      "Orders Total: \$${totalOrdersPrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Selección de montos (para recargar)
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
              
              const Text(
                "Pay Your Orders",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),

              // Transacción para pagar el total de órdenes
              transactionTile(
                icon: "images/debit.png",
                label: "Pay Orders Total", 
                type: "DEBIT_ORDERS",
              ),
              
              const SizedBox(height: 25),

              // SECCIÓN: Órdenes de Firestore (Agrupadas)
              const Text(
                "Your Current Orders",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF415696),
                ),
              ),

              const SizedBox(height: 10),

              StreamBuilder(
                stream: DatabaseMethods().getOrders(),
                builder: (context, snapshot) {
                  // Si hay datos en el stream pero el total está en 0.0 (debido a un pago), 
                  // forzamos el recálculo del total si hay nuevas órdenes.
                  if (totalOrdersPrice == 0.0 && snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                     WidgetsBinding.instance.addPostFrameCallback((_) {
                        _calculateTotalOrderPrice();
                    });
                  }
                  
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final orders = snapshot.data!.docs;

                  if (orders.isEmpty) {
                    return const Center(
                      child: Text(
                        "No orders yet",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }
                  
                  // Agrupación de pedidos por nombre para contar duplicados
                  final Map<String, int> orderCounts = {};
                  final Map<String, dynamic> uniqueOrders = {};

                  for (var order in orders) {
                    final data = order.data() as Map<String, dynamic>;
                    final name = data["name"];
                    
                    if (orderCounts.containsKey(name)) {
                        orderCounts[name] = orderCounts[name]! + 1;
                    } else {
                        orderCounts[name] = 1;
                        uniqueOrders[name] = {
                            "id": order.id,
                            "data": data,
                        };
                    }
                  }

                  // Construye la lista de tarjetas con la lógica de agrupación
                  return Column(
                    children: uniqueOrders.keys.map((name) {
                      final orderInfo = uniqueOrders[name];
                      final data = orderInfo["data"];
                      final id = orderInfo["id"];
                      final count = orderCounts[name]!;

                      final String displayQuantity = count.toString();
                      final double singlePrice = double.tryParse(data["totalPrice"].toString()) ?? 0.0;
                      final double newTotalPrice = singlePrice * count;


                      return buildOrderCard(
                        id: id,
                        name: name,
                        quantity: displayQuantity,
                        company: data["company"],
                        totalPrice: newTotalPrice.toStringAsFixed(2),
                        image: data["image"],
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}