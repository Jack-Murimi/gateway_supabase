import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomersController extends GetxController {
  var customers = <dynamic>[].obs;
  var isLoading = true.obs;
  var hasError = false.obs;

  @override
  void onInit() {
    fetchCustomers();
    super.onInit();
  }

  Future<void> fetchCustomers() async {
    try {
      isLoading(true);
      final response = await Supabase.instance.client
          .from('customers')
          .select('id, name, description, customer_phones(phone_number)');

      customers(response as List<dynamic>);
    } catch (e) {
      hasError(true);
    } finally {
      isLoading(false);
    }
  }
}