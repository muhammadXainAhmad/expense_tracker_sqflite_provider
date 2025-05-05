import 'package:another_flushbar/flushbar.dart';
import 'package:expense_tracker_sqflite_provider/Providers/expense_provider.dart';
import 'package:expense_tracker_sqflite_provider/Providers/category_provider.dart';
import 'package:expense_tracker_sqflite_provider/Providers/drop_down_provider.dart';
import 'package:expense_tracker_sqflite_provider/Providers/transaction_provider.dart';
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
        Consumer<TransactionTypeProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: ToggleButtons(
                isSelected: [
                  provider.transactionType == 'Expense',
                  provider.transactionType == 'Income',
                ],
                onPressed: (index) {
                  provider.setTransactionType(
                    index == 0 ? 'Expense' : 'Income',
                  );
                },
                borderRadius: BorderRadius.circular(12),
                selectedColor: Colors.white,
                fillColor: Colors.blue.shade900,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text('Expense', style: TextStyle(fontSize: 18)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text('Income', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 160,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: Consumer<DropdownProvider>(
                    builder: (context, dropdownprovider, child) {
                      return ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                          value: dropdownprovider.selectedValue1,
                          iconEnabledColor: Colors.black,
                          iconSize: 32,
                          items: const [
                            DropdownMenuItem<String>(
                              value: 'Cash',
                              alignment: Alignment.center,
                              child: Text('Cash'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Card',
                              alignment: Alignment.center,
                              child: Text('Card'),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              dropdownprovider.updateSelectedValue1(value);
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                width: 160,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: Consumer2<CategoryProvider, DropdownProvider>(
                    builder: (context, categoryprovider, dropprovider, child) {
                      return ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                          value: dropprovider.selectedValue2,
                          iconEnabledColor: Colors.black,
                          iconSize: 32,
                          items:
                              categoryprovider.categories.map((category) {
                                return DropdownMenuItem<String>(
                                  value: category.title,
                                  alignment: Alignment.center,
                                  child: Text(category.title),
                                );
                              }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              dropprovider.updateSelectedValue2(value);
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
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
                    prefixStyle: TextStyle(color: Colors.black, fontSize: 32),
                    hintText: r"$0",
                    hintStyle: TextStyle(fontSize: 32),
                    filled: true,
                    fillColor: Colors.blue.shade100,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(
                        color: Colors.blue.shade900,
                        width: 1.5,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    provider.updatePrefixText(value);
                  },
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: 340,
            child: TextField(
              controller: titleController,
              style: TextStyle(color: Colors.black, fontSize: 18),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 26),
                  child: Icon(
                    Icons.notes_outlined,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                fillColor: Colors.blue.shade100,
                filled: true,
                hintText: "Add comment ...",
                hintStyle: TextStyle(fontSize: 18, color: Colors.grey.shade800),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.blue.shade900,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ),

        Consumer<AddExpenseProvider>(
          builder: (context, provider, child) {
            return SizedBox(
              width: 340,
              height: 55,
              child: ElevatedButton(
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    provider.updateSelectedDate(pickedDate);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade100,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.edit_calendar_outlined,
                      color: Colors.black,
                      size: 30,
                    ),
                    SizedBox(width: 60),
                    Text(
                      provider.selectedDate.toString().split(" ")[0],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: ElevatedButton(
            onPressed: () {
              if (amountContoller.text.isEmpty ||
                  titleController.text.isEmpty ||
                  context.read<DropdownProvider>().selectedValue1.isEmpty ||
                  context.read<DropdownProvider>().selectedValue2.isEmpty) {
                Navigator.pop(context);
                Flushbar(
                  messageText: Text(
                    "Please fill all the fields!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  icon: Icon(
                    Icons.error_outline,
                    color: Colors.white,
                    size: 32,
                  ),
                  duration: Duration(seconds: 2),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  borderRadius: BorderRadius.circular(12),
                  backgroundColor: Colors.red,
                  flushbarPosition: FlushbarPosition.TOP,
                ).show(context);
                return;
              }

              final title = titleController.text;
              final amount = double.tryParse(amountContoller.text) ?? 0;
              final category = context.read<DropdownProvider>().selectedValue2;
              final amountType =
                  context.read<DropdownProvider>().selectedValue1;
              final date = context.read<AddExpenseProvider>().selectedDate;

              context.read<AddExpenseProvider>().addExpenseItem(
                title: title,
                amount: amount,
                category: category,
                amountType: amountType,
                date: date,
              );
              context.read<AddExpenseProvider>().resetExpenseAddedFlag();
              Navigator.pop(context);
              Flushbar(
                messageText: Text(
                  "Expense added successfully!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                duration: Duration(seconds: 2),
                margin: EdgeInsets.all(16),
                borderRadius: BorderRadius.circular(12),
                backgroundColor: Colors.green,
                icon: Icon(Icons.check_circle, color: Colors.white),
                flushbarPosition: FlushbarPosition.TOP,
              ).show(context);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(340, 50),
              backgroundColor: Colors.blue.shade900,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            child: Text("SAVE EXPENSE"),
          ),
        ),
      ],
    );
  }
}
