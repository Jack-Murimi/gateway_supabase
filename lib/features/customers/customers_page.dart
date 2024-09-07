import 'package:flutter/material.dart';
import 'package:gateway_supabase/features/customers/controller/customer_controller.dart';
import 'package:get/get.dart';
import 'package:gateway_supabase/features/customers/add_customers.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomersController controller = Get.put(CustomersController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.hasError.value) {
          return const Center(child: Text('An error occurred.'));
        } else {
          return ListView.builder(
            itemCount: controller.customers.length,
            itemBuilder: (context, index) {
              final customer = controller.customers[index];
              final phoneNumbers =
                  (customer['customer_phones'] as List<dynamic>?)
                          ?.map((phone) => phone['phone_number'])
                          .join(', ') ??
                      'No phone numbers';

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      customer['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(customer['description']),
                    trailing: Text(
                      phoneNumbers,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddCustomers()),
        heroTag: 'add_customers',
        child: const Icon(Icons.add),
      ),
    );
  }
}
