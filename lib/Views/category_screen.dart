import 'package:expense_tracker_sqflite_provider/Constants/icons.dart';
import 'package:expense_tracker_sqflite_provider/Providers/category_provider.dart';
import 'package:expense_tracker_sqflite_provider/Providers/expense_provider.dart';
import 'package:expense_tracker_sqflite_provider/Views/category_expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});
  static const name = "category_screen";

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
      Provider.of<ExpenseProvider>(context, listen: false).getExpense();
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(children: [Text(r"$32,500.00"), Text("Total Balance")]),
        actions: [Icon(Icons.notifications_none_rounded, size: 30)],
      ),

      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Card(
              margin: EdgeInsets.all(32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 2,
              color: Colors.blue.shade900,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    Text(
                      "Total Balance",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      r"$ 32,500",
                      style: TextStyle(color: Colors.white, fontSize: 38),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Income", style: TextStyle(color: Colors.white)),
                        Text("Expenses", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 100,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(child: Text("Day")),
              ),
              Container(
                width: 100,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(child: Text("Week")),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 100,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(child: Text("Month")),
                ),
              ),
            ],
          ),
          Expanded(
            child: Consumer<CategoryProvider>(
              builder: (context, categoryProvider, child) {
                if (categoryProvider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: categoryProvider.categories.length,
                  itemBuilder: (context, index) {
                    final category = categoryProvider.categories[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            CategoryExpenseScreen.name,
                            arguments: category.title,
                          );
                        },
                        leading: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.circle,
                              size: 50,
                              color:
                                  categoryColors[category.title] ?? Colors.grey,
                            ),
                            Icon(
                              icons[category.title] ?? Icons.category,
                              size: 26,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        title: Text(
                          category.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        trailing: Text(
                          '\$${category.totalAmount}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
