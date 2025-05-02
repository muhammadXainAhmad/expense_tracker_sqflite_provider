import 'dart:io';

import 'package:expense_tracker_sqflite_provider/Constants/icons.dart';
import 'package:expense_tracker_sqflite_provider/Models/expense_category_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final String cTableName = "categoryTable";
  static final String eTableName = "expenseTable";
  // cTable column names
  static final String cTitle = "title";
  static final String cTotalAmount = "totalAmount";

  // eTable column names
  static final String eId = "id";
  static final String eTitle = "title";
  static final String eAmount = "amount";
  static final String eDate = "date";
  static final String eCategory = "category";

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
          "create table $cTableName ($cTitle TEXT PRIMARY KEY, $cTotalAmount REAL)",
        );
        await db.execute(
          "create table $eTableName ($eId INTEGER PRIMARY KEY AUTOINCREMENT,$eTitle TEXT, $eAmount REAL, $eDate TEXT, $eCategory TEXT)",
        );
        for (var title in icons.keys) {
          await db.insert(cTableName, {"title": title, "totalAmount": 0.0});
        }
      },
      version: 1,
    );
  }

  Future<List<ExpenseCategory>> getCategory() async {
    var db = await getDB();
    List<Map<String, dynamic>> mData = await db.query(cTableName);
    return mData.map((map) => ExpenseCategory.fromMap(map)).toList();
  }

  Future<List<Map<String, dynamic>>> getExpense() async {
    var db = await getDB();
    List<Map<String, dynamic>> mData = await db.query(eTableName);
    return mData;
  }
}
