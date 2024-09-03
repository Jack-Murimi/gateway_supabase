import 'package:flutter/material.dart';
import 'package:gateway_supabase/features/products/add_products.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productsStreams =
        Supabase.instance.client.from('customers').stream(primaryKey: ['ID']);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
      ),
      body: StreamBuilder(
        stream: productsStreams,
        builder: (context, snapshot) {
          // IF THERE IS AN ERROR
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          // If the snapshot has data, display the products
          else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(
                        product['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(product['description']),
                      trailing: const Text(
                        "Phone number",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
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
        child: const Icon(Icons.add),
      ),
    );
  }
}
