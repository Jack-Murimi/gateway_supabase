import 'package:flutter/material.dart';

class AddSales extends StatelessWidget {
  const AddSales({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Sales'),
      ),
      body: const Center(
        child: Text('Add Sales'),
      ),
    );
  }
}
