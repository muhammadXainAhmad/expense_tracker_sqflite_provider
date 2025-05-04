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
    void onItemTapped(int index) {
      if (index == 1) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder:
              (context) => SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: const AddExpenseScreen(),
              ),
        );
      } else {
        navProvider.updateIndex(index == 2 ? 1 : 0);
      }
    }

    return Scaffold(
      body: pages[navProvider.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:
            navProvider.selectedIndex == 1 ? 2 : navProvider.selectedIndex,
        onTap: onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 36),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.circle, size: 60, color: Colors.black),
                Icon(Icons.add, size: 36, color: Colors.white),
              ],
            ),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined, size: 32),
            label: "Settings",
          ),
        ],
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
