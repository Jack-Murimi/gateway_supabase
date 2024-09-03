import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductController extends GetxController {
  var name = ''.obs;
  var description = ''.obs;
  var price = 0.0.obs;

  final formKey = GlobalKey<FormState>();

  void onNameChanged(String value) {
    name.value = value;
  }

  void onDescriptionChanged(String value) {
    description.value = value;
  }

  void onPriceChanged(String value) {
    try {
      price.value = double.parse(value);
    } catch (e) {
      Get.snackbar("Error", "Please enter a valid price");
    }
  }

  Future<void> addProduct() async {
    if (formKey.currentState!.validate()) {
      try {
        final response =
            await Supabase.instance.client.from('products').insert({
          'name': name.value,
          'description': description.value,
          'price': price.value,
        });

        if (response.error == null) {
          Get.snackbar("Success", "Product added successfully");
          clearForm();
        } else {
          Get.snackbar("Error", response.error!.message);
        }
      } catch (e) {
        Get.snackbar("Error", "Something went wrong");
      }
    }
  }

  void clearForm() {
    name.value = '';
    description.value = '';
    price.value = 0.0;
    formKey.currentState!.reset();
  }
}
