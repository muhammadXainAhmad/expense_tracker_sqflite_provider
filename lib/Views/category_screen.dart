import 'package:expense_tracker_sqflite_provider/Constants/icons.dart';
import 'package:expense_tracker_sqflite_provider/Providers/category_provider.dart';
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
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(children: [Text(r"$32,500.00"), Text("Total Balance")]),
        actions: [Icon(Icons.notifications_none_rounded, size: 30)],
      ),

      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
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
            ),
            Consumer<CategoryProvider>(
              builder: (context, categoryProvider, child) {
                if (categoryProvider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return Expanded(
                  child: ListView.builder(
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
                                    categoryColors[category.title] ??
                                    Colors.grey,
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
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
