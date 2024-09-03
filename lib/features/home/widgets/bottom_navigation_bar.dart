import 'package:flutter/material.dart';
import 'package:gateway_supabase/features/home/widgets/home_controller.dart';
import 'package:get/get.dart';

class JNavigationBar extends StatelessWidget {
  JNavigationBar({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => NavigationBar(
        indicatorColor: Colors.amber,
        selectedIndex: homeController.currentPageIndex.value,
        onDestinationSelected: (int index) {
          homeController.changePage(index);
        },
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.store),
            icon: Icon(Icons.store_outlined),
            label: 'Products',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.people),
            icon: Icon(Icons.people_outline),
            label: 'Customers',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.attach_money),
            icon: Icon(Icons.money_outlined),
            label: 'Sales',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.shopping_cart),
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Purchases',
          ),
        ],
      ),
    );
  }
}
