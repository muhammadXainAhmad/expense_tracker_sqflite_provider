import 'package:expense_tracker_sqflite_provider/Constants/icons.dart';
import 'package:flutter/widgets.dart';

class ExpenseCategory {
  final String title;
  int entries = 0;
  double totalAmount = 0.0;
  final IconData icon;

  ExpenseCategory({
    required this.title,
    required this.entries,
    required this.totalAmount,
    required this.icon,
  });

  Map<String, dynamic> toMap() => {
    "title": title,
    "entries": entries,
    "totalAmount": totalAmount
  };

  static ExpenseCategory fromMap(Map<String, dynamic> map) {
    return ExpenseCategory(
      title: map["title"],
      entries: map["entries"],
      totalAmount: map["totalAmount"],
      icon: icons[map["title"]]!,
    );
  }
}
