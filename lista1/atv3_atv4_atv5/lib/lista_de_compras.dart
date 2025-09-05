import 'package:flutter/material.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  final TextEditingController _controller = TextEditingController();
  final List<_ShoppingItem> _items = [];

  void _addItem() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _items.add(_ShoppingItem(name: text));
        _controller.clear();
      });
    }
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Compras')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: 'Adicionar item'),
                    onSubmitted: (_) => _addItem(),
                  ),
                ),
                IconButton(icon: Icon(Icons.add), onPressed: _addItem),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return ListTile(
                    leading: Checkbox(
                      value: item.bought,
                      onChanged: (val) {
                        setState(() {
                          item.bought = val ?? false;
                        });
                      },
                    ),
                    title: Text(
                      item.name,
                      style: TextStyle(
                        decoration: item.bought
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _removeItem(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShoppingItem {
  String name;
  bool bought = false;
  _ShoppingItem({required this.name});
}