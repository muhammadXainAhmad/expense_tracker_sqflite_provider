import 'dart:io';

import 'package:expense_tracker_sqflite_provider/Constants/icons.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final String cTable = "categoryTable";
  static final String eTable = "expenseTable";

  Database? _myDB;

  Future<Database> getDB() async {
    _myDB ??= await openDB();
    return _myDB!;
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, "expense_app.db");

    return await openDatabase(
      dbPath,
      onCreate: (db, version) async {
        await db.execute(
          "create table $cTable (title TEXT PRIMARY KEY, entries INTEGER, totalAmount REAL)",
        );
        await db.execute(
          "create table $eTable (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT, amount REAL, date TEXT, category TEXT)",
        );
        for (var title in icons.keys) {
          await db.insert(cTable, {
            "title": title,
            "entries": 0,
            "totalAmount": 0.0,
          });
        }
      },
      version: 1,
    );
  }

  Future<List<Map<String, dynamic>>> getCategory() async {
    var db = await getDB();
    List<Map<String, dynamic>> mData = await db.query(cTable);
    return mData;
  }

  /*Future<List<ExpenseCategory>> getCategory() async {
  var db = await getDB();
  List<Map<String, dynamic>> mData = await db.query(cTable);
  return mData.map((map) => ExpenseCategory.fromMap(map)).toList();
}*/
  Future<List<Map<String, dynamic>>> getExpense() async {
    var db = await getDB();
    List<Map<String, dynamic>> mData = await db.query(eTable);
    return mData;
  }
}
