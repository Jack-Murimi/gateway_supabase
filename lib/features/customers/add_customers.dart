import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddCustomers extends StatelessWidget {
  const AddCustomers({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController phoneNumberController = TextEditingController();

    Future<void> addCustomer() async {
      if (formKey.currentState?.validate() ?? false) {
        final name = nameController.text;
        final description = descriptionController.text;
        final phoneNumber = phoneNumberController.text;

        final response =
            await Supabase.instance.client.from('customers').insert({
          'name': name,
          'description': description,
          'customer_phones': [
            {'phone_number': phoneNumber}
          ]
        });

        if (response.error != null) {
          Get.snackbar('Error', response.error!.message,
              backgroundColor: Colors.red, colorText: Colors.white);
        } else {
          Get.snackbar('Success', 'Customer added successfully',
              backgroundColor: Colors.green, colorText: Colors.white);
          Get.back();
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Customer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: phoneNumberController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: addCustomer,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Add Customer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
