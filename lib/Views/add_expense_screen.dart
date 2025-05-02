import 'package:expense_tracker_sqflite_provider/Providers/add_expense_provider.dart';
import 'package:expense_tracker_sqflite_provider/Providers/category_provider.dart';
import 'package:expense_tracker_sqflite_provider/Models/drop_down_provider';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController amountContoller = TextEditingController();
    final TextEditingController titleController = TextEditingController();

    return Column(
      children: [
        Divider(
          color: Colors.black,
          thickness: 6,
          indent: 190,
          endIndent: 190,
          height: 40,
        ),
        Text("Add Expenses", style: TextStyle(fontSize: 18)),
        SizedBox(
          width: 250,
          child: Consumer<AddExpenseProvider>(
            builder: (context, provider, child) {
              return TextField(
                controller: amountContoller,
                style: TextStyle(fontSize: 36),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  prefixText: provider.showPrefix ? r"$" : null,
                  hintText: r"$0",
                  hintStyle: TextStyle(fontSize: 36),
                  filled: true,
                  fillColor: Colors.blue.shade100,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onChanged: (value) {
                  provider.updatePrefixText(value);
                },
              );
            },
          ),
        ),
        SizedBox(
          width: 300,
          child: TextField(
            controller: titleController,
            style: TextStyle(color: Colors.black, fontSize: 18),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              fillColor: Colors.blue.shade100,
              filled: true,
              hintText: "Add title...",
              hintStyle: TextStyle(fontSize: 18, color: Colors.black),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        Container(
          width: 300,
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: Consumer<DropdownProvider>(
              builder: (context, dropdownprovider, child) {
                return DropdownButton(
                  value: dropdownprovider.selectedValue1,
                  iconEnabledColor: Colors.black,
                  iconSize: 32,
                  items: const [
                    DropdownMenuItem<String>(
                      value: 'Cash',
                      child: Text('Cash'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Card',
                      child: Text('Card'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      dropdownprovider.updateSelectedValue1(value);
                    }
                  },
                );
              },
            ),
          ),
        ),
        Container(
          width: 300,
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: Consumer2<CategoryProvider, DropdownProvider>(
              builder: (context, categoryprovider, dropprovider, child) {
                return DropdownButton(
                  value: dropprovider.selectedValue2,
                  iconEnabledColor: Colors.black,
                  iconSize: 32,
                  items:
                      categoryprovider.categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category.title,
                          child: Text(category.title),
                        );
                      }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      dropprovider.updateSelectedValue2(value);
                    }
                  },
                );
              },
            ),
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: SizedBox(
            width: 300,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: Text("SAVE"),
            ),
          ),
        ),
      ],
    );
  }
}
