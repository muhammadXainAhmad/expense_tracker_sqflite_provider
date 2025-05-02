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
