import 'dart:io'; // Corrected import statement
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/model/todoitem.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  final String tableName = "todoTbl";
  final String columnId = "id";
  final String columnItemName = "itemName";
  final String columnDateCreated = "dateCreated";

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "todo_db.db");
    var ourDb = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, $columnItemName TEXT, $columnDateCreated TEXT)",
    );
    print("Table is created");
  }

  Future<int> saveItem(TodoItem item) async {
    var dbClient = await db;
    int res = await dbClient.insert(tableName, item.toMap());
    print(res.toString());
    return res;
  }

  Future<List<Map<String, dynamic>>> getItems() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
      "SELECT * FROM $tableName ORDER BY $columnItemName ASC",
    );
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
      await dbClient.rawQuery("SELECT COUNT(*) FROM $tableName"),
    ) ?? 0;
  }

  Future<TodoItem?> getItem(int id) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
      "SELECT * FROM $tableName WHERE $columnId = ?",
      [id],
    );
    if (result.isEmpty) return null;
    return TodoItem.fromMap(result.first);
  }

  Future<int> deleteItem(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      tableName,
      where: "$columnId = ?",
      whereArgs: [id],
    );
  }

  Future<int> updateItem(TodoItem item) async {
    var dbClient = await db;
    return await dbClient.update(
      tableName,
      item.toMap(),
      where: "$columnId = ?",
      whereArgs: [item.id],
    );
  }

  Future<void> close() async {
    var dbClient = await db;
    await dbClient.close();
  }
}
