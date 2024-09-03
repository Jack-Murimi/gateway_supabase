import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        children: const <Widget>[
          HomeButton(title: 'Record Sales', icon: Icons.shopping_cart, route: '/sales'),
          HomeButton(title: 'Record Purchases', icon: Icons.receipt, route: '/purchases'),
          HomeButton(title: 'Manage Customers', icon: Icons.people, route: '/customers'),
          HomeButton(title: 'Manage Products', icon: Icons.inventory, route: '/products'),
        ],
      ),
    );
  }
}

class HomeButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;

  const HomeButton({super.key, required this.title, required this.icon, required this.route});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(route);
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50.0),
            const SizedBox(height: 10.0),
            Text(title, style: const TextStyle(fontSize: 18.0)),
          ],
        ),
      ),
    );
  }
}
