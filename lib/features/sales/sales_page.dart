import 'package:flutter/material.dart';
import 'package:gateway_supabase/features/products/add_products.dart';
import 'package:get/get.dart';

class SalesPage extends StatelessWidget {
  const SalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales'),
      ),
      body: const Center(
        child: Text('Sales'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddProductPage()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
