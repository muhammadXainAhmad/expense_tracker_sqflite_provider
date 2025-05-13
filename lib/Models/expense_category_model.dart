import 'package:expense_tracker_sqflite_provider/Constants/icons.dart';
import 'package:flutter/widgets.dart';

class ExpenseCategory {
  final String title;
  double totalAmount = 0.0;
  int entries = 0;
  final IconData icon;

  ExpenseCategory({
    required this.title,
    required this.totalAmount,
    required this.entries,
    required this.icon,
  });

  Map<String, dynamic> toMap() => {
    "title": title,
    "totalAmount": totalAmount,
    "entries": entries,
  };

  static ExpenseCategory fromMap(Map<String, dynamic> map) {
    return ExpenseCategory(
      title: map["title"],
      totalAmount: map["totalAmount"],
      entries: map["entries"] ?? 0,
      icon: icons[map["title"]]!,
    );
  }
}
