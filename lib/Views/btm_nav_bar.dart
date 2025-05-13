import 'package:expense_tracker_sqflite_provider/Views/add_expense_screen.dart';
import 'package:expense_tracker_sqflite_provider/Views/category_screen.dart';
import 'package:expense_tracker_sqflite_provider/Views/expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [CategoryScreen(), ExpenseScreen()];
    final navProvider = Provider.of<BottomNavProvider>(context);

    return Scaffold(
      body: pages[navProvider.selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder:
                (context) => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: const AddExpenseScreen(),
                ),
          );
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: Colors.blue.shade900,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 150,
              height: 120,
              child: IconButton(
                icon: Icon(
                  Icons.home,
                  size: 36,
                  color:
                      navProvider.selectedIndex == 0
                          ? Colors.white
                          : Colors.white30,
                ),
                onPressed: () => navProvider.updateIndex(0),
              ),
            ),
            SizedBox(width: 30),
            SizedBox(
              width: 150,
              height: 120,
              child: IconButton(
                icon: Icon(
                  Icons.bar_chart,
                  size: 36,
                  color:
                      navProvider.selectedIndex == 1
                          ? Colors.white
                          : Colors.white30,
                ),
                onPressed: () => navProvider.updateIndex(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavProvider with ChangeNotifier {
  int selectedIndex = 0;

  void updateIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
