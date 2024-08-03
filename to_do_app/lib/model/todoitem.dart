import 'package:flutter/material.dart';
import '../util/data_base_c.dart';
import '../models/todoitem.dart';  // Make sure this import is correct

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  var db = DatabaseHelper();
  final List<ToDoItem> _itemList = <ToDoItem>[];

  @override
  void initState() {
    super.initState();
    _readNoDoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              reverse: false,
              itemCount: _itemList.length,
              itemBuilder: (_, int index) {
                return Card(
                  color: Colors.white,
                  child: ListTile(
                    title: Text(_itemList[index].itemName),
                    trailing: GestureDetector(
                      key: Key(_itemList[index].itemName),
                      child: Icon(
                        Icons.remove_circle,
                        color: Colors.redAccent,
                      ),
                      onTap: () {
                        // Add functionality to remove item
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Item",
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: _showFromDialog,
      ),
    );
  }

  void _showFromDialog() {
    var alert = AlertDialog(
      content: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textEditingController,
              autofocus: true,
              decoration: InputDecoration(
                labelText: "Item",
                hintText: "e.g. Don't buy stuff",
                icon: Icon(Icons.note_add),
              ),
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            _handleSubmitted(_textEditingController.text);
            _textEditingController.clear();
            Navigator.pop(context);
          },
          child: Text('Save'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Close'),
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (_) {
        return alert;
      },
    );
  }

  void _handleSubmitted(String text) async {
    _textEditingController.clear();

    ToDoItem noDoItem = ToDoItem(text, DateTime.now().toIso8601String());
    int savedItemId = await db.saveItem(noDoItem);

    ToDoItem addedItem = await db.getItem(savedItemId);

    setState(() {
      _itemList.insert(0, addedItem);
    });

    print("Item saved id: $savedItemId");
  }

  _readNoDoList() async {
    List items = await db.getItem();  // Ensure this method returns a list
    items.forEach((item) {
      setState(() {
        _itemList.add(ToDoItem.fromMap(item));  // Ensure ToDoItem.fromMap exists
      });
    });
  }
}
