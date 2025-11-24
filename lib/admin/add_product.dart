import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String selectedCategory = "Medicine";
  bool loading = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addProduct() async {
    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        companyController.text.isEmpty ||
        descriptionController.text.isEmpty) {
      _showMessage("All fields are required");
      return;
    }

    // Convertir precio a número
    double? price = double.tryParse(priceController.text);
    if (price == null) {
      _showMessage("Invalid price format");
      return;
    }

    setState(() => loading = true);

    try {
      await _firestore.collection("products").add({
        "name": nameController.text.trim(),
        "price": price,                            // <--- ahora double
        "category": selectedCategory,
        "company": companyController.text.trim(),
        "description": descriptionController.text.trim(),
        "created_at": Timestamp.now(),             // <--- correcto para Firestore
      });

      _showMessage("Product Added!", success: true);

      // limpiar inputs
      nameController.clear();
      priceController.clear();
      companyController.clear();
      descriptionController.clear();

    } catch (e) {
      _showMessage("Error: $e");
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
    const primary = Color(0xFF415696);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(26),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              "Add Product",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: primary,
              ),
            ),
            const SizedBox(height: 25),

            _input("Product Name", nameController),

            const SizedBox(height: 20),

            _input("Product Price", priceController,
                keyboard: TextInputType.number),

            const SizedBox(height: 20),

            _categoryDropdown(),

            const SizedBox(height: 20),

            _input("Company Name", companyController),

            const SizedBox(height: 20),

            _largeInput("Product Description", descriptionController),

            const SizedBox(height: 40),

            loading
                ? const CircularProgressIndicator(color: primary)
                : _addButton(),
          ],
        ),
      ),
    );
  }

  Widget _input(String label, TextEditingController controller,
      {TextInputType keyboard = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboard,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Widget _largeInput(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      maxLines: 4,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Widget _categoryDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: DropdownButton<String>(
        value: selectedCategory,
        isExpanded: true,
        underline: const SizedBox(),
        items: const [
          DropdownMenuItem(value: "Herbal", child: Text("Herbal")),
          DropdownMenuItem(value: "Vitamins", child: Text("Vitamins")),
          DropdownMenuItem(value: "Supplement", child: Text("Supplement")),
          DropdownMenuItem(value: "Medicine", child: Text("Medicine")),
        ],
        onChanged: (value) {
          setState(() => selectedCategory = value!);
        },
      ),
    );
  }

  Widget _addButton() {
    return GestureDetector(
      onTap: addProduct,
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF415696),
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Center(
          child: Text(
            "Add Product",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
