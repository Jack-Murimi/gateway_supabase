import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductSnapshotPage extends StatelessWidget {
  const ProductSnapshotPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime startOfMonth = DateTime(now.year, now.month, 1);

    final snapshotStream = Supabase.instance.client
        .from('monthly_stock_snapshot')
        .select('id, product_id, starting_stock, products(name, description)')
        .gte('created_at', startOfMonth.toIso8601String())
        .lte('created_at', now.toIso8601String())
        .asStream();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Product Snapshot'),
      ),
      body: StreamBuilder(
        stream: snapshotStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data as List<Map<String, dynamic>>;
            if (data.isEmpty) {
              return const Center(
                child: Text('No product snapshots for this month.'),
              );
            }
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                final product = item['products'];

                return ListTile(
                  title: Text(product['name']),
                  subtitle: Text(product['description']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Starting Stock: ${item['starting_stock']}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showEditStockDialog(
                            context, item['id'], item['starting_stock']),
                      ),
                    ],
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
    );
  }

  void _showEditStockDialog(
      BuildContext context, String snapshotId, int currentStock) {
    final TextEditingController stockController =
        TextEditingController(text: currentStock.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Opening Stock'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: stockController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Opening Stock',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final stock = int.tryParse(stockController.text);
                if (stock != null) {
                  await _updateStock(snapshotId, stock);
                }
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateStock(String snapshotId, int stock) async {
    final response =
        await Supabase.instance.client.from('monthly_stock_snapshot').upsert({
      'id': snapshotId,
      'starting_stock': stock,
    });

    if (response.error != null) {
      print('Error updating stock: ${response.error!.message}');
    }
  }
}
