import 'package:expense_tracker_sqflite_provider/Constants/icons.dart';
import 'package:expense_tracker_sqflite_provider/Providers/category_provider.dart';
import 'package:expense_tracker_sqflite_provider/Providers/expense_provider.dart';
import 'package:expense_tracker_sqflite_provider/Providers/theme_provider.dart';
import 'package:expense_tracker_sqflite_provider/Views/category_expense_screen.dart';
import 'package:expense_tracker_sqflite_provider/Views/settings_screen.dart';
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
        title: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            "Welcome, Xain!",
            style: TextStyle(color: context.read<ThemeProvider>().getTextColor(context), fontSize: 24),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SettingsScreen.name);
              },
              icon: Icon(
                Icons.settings,
               color: context.read<ThemeProvider>().getTextColor(context),
                size: 30,
              ),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          Card(
            margin: EdgeInsets.only(right: 32, left: 32, top: 20, bottom: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 2,
            color: Colors.blue.shade900,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Consumer<ExpenseProvider>(
                builder: (context, provider, child) {
                  return Column(
                    children: [
                      Text(
                        "Total Balance",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        "\$ ${provider.balance.toStringAsFixed(2)}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_circle_down_rounded,
                                  size: 40,
                                  color: Colors.greenAccent.shade400,
                                ),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Income",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      provider.totalIncome.toStringAsFixed(2),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_circle_up_rounded,
                                  size: 40,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Expense",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      provider.totalExpense.toStringAsFixed(2),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Consumer<ExpenseProvider>(
            builder: (context, dayProvider, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 100,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Day",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        Text(
                          "\$ ${dayProvider.getTotal(dayProvider.getTodayExpenses()).toStringAsFixed(2)}",

                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Week",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        Text(
                          "\$${dayProvider.getTotal(dayProvider.getWeekExpenses()).toStringAsFixed(2)}",

                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Month",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        Text(
                          "\$${dayProvider.getTotal(dayProvider.getMonthExpenses()).toStringAsFixed(2)}",

                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          Expanded(
            child: Consumer2<ExpenseProvider, CategoryProvider>(
              builder: (context, expenseProvider, categoryProvider, child) {
                if (categoryProvider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: categoryProvider.categories.length,
                  itemBuilder: (context, index) {
                    final category = categoryProvider.categories[index];
                    final expenseCount =
                        expenseProvider.expenseList
                            .where((e) => e.category == category.title)
                            .length;
                    final categoryTotal =
                        expenseProvider.categoryExpenseTotals[category.title] ??
                        0;
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
                            color: context.read<ThemeProvider>().getTextColor(
                              context,
                            ),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          "Transactions: $expenseCount",
                          style: TextStyle(
                            color: context.read<ThemeProvider>().getTextColor(
                              context,
                            ),
                            fontSize: 14,
                          ),
                        ),
                        trailing: Text(
                          "\$${categoryTotal.toStringAsFixed(2)}",
                          style: TextStyle(
                            color: context.read<ThemeProvider>().getTextColor(
                              context,
                            ),
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
