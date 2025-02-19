import 'package:flutter/material.dart';
import 'package:product_firestore_app/widgets/product_list.dart';
import 'package:product_firestore_app/widgets/product_popup.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 182, 72),
        title: const Text(
          'Product List',
          style: TextStyle(fontSize: 28),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => ProductPopup());
            },
            icon: const Icon(Icons.add_box_sharp),
            iconSize: 32,
            color: const Color.fromARGB(255, 255, 255, 255),
          )
        ],
      ),
      body: const ProductList(),
      backgroundColor: const Color.fromARGB(255, 252, 252, 252),
    );
  }
}
