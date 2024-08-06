class ToDoItem {
  int? id;
  String itemName;
  final String dateCreated;

  ToDoItem(this.itemName, this.dateCreated, {this.id});

  // Add a setter for itemName
  setItemName(String newName) {
    itemName = newName;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'itemName': itemName,
      'dateCreated': dateCreated,
    };
  }

  factory ToDoItem.fromMap(Map<String, dynamic> map) {
    return ToDoItem(
      map['itemName'] as String,
      map['dateCreated'] as String,
      id: map['id'] as int?,
    );
  }
}
