import 'package:flutter/material.dart';
import 'package:gateway_supabase/features/customers/customers_page.dart';
import 'package:gateway_supabase/features/home/widgets/bottom_navigation_bar.dart';
import 'package:gateway_supabase/features/home/widgets/home_controller.dart';
import 'package:gateway_supabase/features/products/products.dart';
import 'package:gateway_supabase/features/sales/sales_page.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => IndexedStack(
            index: homeController.currentPageIndex.value,
            children: const [
              ProductsPage(),
              CustomersPage(),
              SalesPage(),
              Text('Purchases'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: JNavigationBar(),
    );
  }
}
