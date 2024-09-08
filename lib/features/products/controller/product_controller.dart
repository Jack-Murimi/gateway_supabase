import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductsController extends GetxController {
  var name = ''.obs;
  var description = ''.obs;
  var price = 0.0.obs;
  var isLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  // Handle name input change
  void onNameChanged(String value) {
    name.value = value;
  }

  // Handle description input change
  void onDescriptionChanged(String value) {
    description.value = value;
  }

  // Handle price input change and validation
  void onPriceChanged(String value) {
    double? parsedPrice = double.tryParse(value);
    if (parsedPrice != null && parsedPrice >= 0) {
      price.value = parsedPrice;
    } else {
      Get.snackbar("Invalid Input",
          "Please enter a valid positive number for the price.");
    }
  }

  // Add a product to Supabase
  Future<void> addProduct() async {
    // Validate form fields before saving
    if (!formKey.currentState!.validate()) {
      Get.snackbar("Validation Error", "Please fill out all fields correctly.");
      return;
    }

    formKey.currentState!.save(); // Save form inputs

    isLoading.value = true; // Show loading state

    try {
      // Insert the product into the database
      final response = await Supabase.instance.client.from('products').insert({
        'name': name.value,
        'description': description.value,
        'price': price.value,
      }).select();

      if (response.isNotEmpty) {
        Get.snackbar("Success", "Product added successfully.");
        clearForm();
      } else {
        Get.snackbar("Error", "Failed to add product. Please try again.");
      }
    } catch (error) {
      // Catch and display any errors
      Get.snackbar("Database Error", "An error occurred: ${error.toString()}");
    } finally {
      isLoading.value = false; // Hide loading state
    }
  }

  // Clear the form and reset fields
  void clearForm() {
    name.value = '';
    description.value = '';
    price.value = 0.0;
    formKey.currentState?.reset();
  }

  // Helper method for form validation
  String? validateField(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  // product stream
  Stream<List<Map<String, dynamic>>> getProductsStream() {
    return Supabase.instance.client
        .from('products')
        .stream(primaryKey: ['id']).order('created_at');
  }
}
