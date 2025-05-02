class Expense {
  final int id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  Map<String, dynamic> toMap() => {
    "title": title,
    "amount": amount,
    "date": date.toString(),
    "category": category,
  };

  static Expense fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map["id"],
      title: map["title"],
      amount: map["amount"],
      date: DateTime.parse(map["date"]),
      category: map["category"],
    );
  }
}
