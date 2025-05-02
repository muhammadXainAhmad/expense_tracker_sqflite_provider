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
          child: TextField(
            controller: amountContoller,
            style: TextStyle(fontSize: 36),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              prefixText: amountContoller.text.isNotEmpty ? r"$" : null,
              hintText: r"$0",
              hintStyle: TextStyle(fontSize: 36),
              filled: true,
              fillColor: Colors.blue.shade100,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),

        Container(
          width: 150,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: DropdownButtonHideUnderline(
            child: Consumer<DropdownProvider>(
              builder: (context, dropdownprovider, child) {
                return DropdownButton(
                  value: dropdownprovider.selectedValue1,
                  iconEnabledColor: Colors.white,
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
          width: 150,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: DropdownButtonHideUnderline(
            child: Consumer2<CategoryProvider, DropdownProvider>(
              builder: (context, categoryprovider, dropprovider, child) {
                return DropdownButton(
                  value: dropprovider.selectedValue2,
                  iconEnabledColor: Colors.white,
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
      ],
    );
  }
}
