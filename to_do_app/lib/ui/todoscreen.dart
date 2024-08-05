import 'package:flutter/material.dart';
import '../model/todoitem.dart';
import '../util/data_base_c.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final DatabaseHelper db = DatabaseHelper();
  final List<ToDoItem> _itemList = <ToDoItem>[];
  ToDoItem? _selectedItem;

  @override
  void initState() {
    super.initState();
    _readNoDoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('TO DO ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              reverse: false,
              itemCount: _itemList.length,
              itemBuilder: (_, int index) {
                return Card(
                  color: Colors.white,
                  child: ListTile(
                    title: Text(_itemList[index].itemName),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            _selectedItem = _itemList[index];
                            _showEditDialog();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () async {
                            await _deleteItem(_itemList[index].id!);
                          },
                        ),
                      ],
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
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {
          _selectedItem = null;
          _showFormDialog();
        },
      ),
    );
  }

  void _showFormDialog() {
    var alert = AlertDialog(
      title: const Text("Add Item"),
      content: TextField(
        controller: _textEditingController,
        autofocus: true,
        decoration: const InputDecoration(
          labelText: "Item",
          hintText: "e.g. Don't buy stuff",
          icon: Icon(Icons.note_add),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            if (_selectedItem == null) {
              _handleSubmitted(_textEditingController.text);
            } else {
              _handleUpdate(_textEditingController.text);
            }
            _textEditingController.clear();
            Navigator.pop(context);
          },
          child: Text(_selectedItem == null ? 'Save' : 'Update'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
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

  void _showEditDialog() {
    if (_selectedItem == null) return;

    _textEditingController.text = _selectedItem!.itemName;

    var alert = AlertDialog(
      title: const Text("Edit Item"),
      content: TextField(
        controller: _textEditingController,
        autofocus: true,
        decoration: const InputDecoration(
          labelText: "Item",
          hintText: "e.g. Don't buy stuff",
          icon: Icon(Icons.note_add),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            if (_selectedItem != null) {
              _handleUpdate(_textEditingController.text);
            }
            _textEditingController.clear();
            Navigator.pop(context);
          },
          child: const Text('Update'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
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

    ToDoItem? addedItem = await db.getItem(savedItemId);

    if (addedItem != null) {
      setState(() {
        _itemList.insert(0, addedItem);
      });
    }

    print("Item saved id: $savedItemId");
  }

  void _handleUpdate(String text) async {
    if (_selectedItem == null) return;

    ToDoItem updatedItem = ToDoItem(text, _selectedItem!.dateCreated, id: _selectedItem!.id);
    await db.updateItem(updatedItem);

    setState(() {
      int index = _itemList.indexWhere((item) => item.id == _selectedItem!.id);
      if (index != -1) {
        _itemList[index] = updatedItem;
      }
      _selectedItem = null;
    });

    print("Item updated id: ${updatedItem.id}");
  }

  Future<void> _readNoDoList() async {
    List<Map<String, dynamic>> items = await db.getItems();
    setState(() {
      _itemList.clear();
      items.forEach((item) {
        _itemList.add(ToDoItem.fromMap(item));
      });
    });
  }

  Future<void> _deleteItem(int id) async {
    await db.deleteItem(id);
    setState(() {
      _itemList.removeWhere((item) => item.id == id);
    });
  }
}
