import 'package:flutter/material.dart';
import 'package:gateway_supabase/features/products/controller/product_controller.dart';
import 'package:gateway_supabase/features/products/widgets/products_drawer.dart';
import 'package:get/get.dart';
import 'add_products.dart'; // Import the AddProductPage

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductsController productsController = Get.put(ProductsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        // Remove IconButton to keep only the default menu button in the AppBar
      ),
      body: StreamBuilder(
        stream: productsController.getProductsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return _buildProductItem(product);
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddProductPage()),
        heroTag: 'add_product',
        child: const Icon(Icons.add),
      ),
      drawer: const ProductsDrawer(),
    );
  }

  Widget _buildProductItem(Map<String, dynamic> product) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        elevation: 2,
        color: const Color.fromARGB(255, 53, 52, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          title: Text(
            product['name'],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(product['description']),
          trailing: Text(
            "Ksh. ${product['price']}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}
