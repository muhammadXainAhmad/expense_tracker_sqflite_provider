import 'package:expense_tracker_sqflite_provider/Views/add_expense_screen.dart';
import 'package:expense_tracker_sqflite_provider/Views/category_screen.dart';
import 'package:expense_tracker_sqflite_provider/Views/expense_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [CategoryScreen(), ExpenseScreen()];

  void _onItemTapped(int index) {
    if (index == 1) {
      showModalBottomSheet(
        context: context,
        builder: (context) => const AddExpenseScreen(),
      );
    } else {
      setState(() {
        _selectedIndex = index == 2 ? 1 : 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex == 1 ? 2 : _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.deepPurple.shade100,
        selectedItemColor: Colors.red,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
