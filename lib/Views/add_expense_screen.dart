import 'package:expense_tracker_sqflite_provider/Models/category_provider.dart';
import 'package:expense_tracker_sqflite_provider/Models/drop_down_provider';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
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
            ),
          ],
        ),
      ],
    );
  }
}
