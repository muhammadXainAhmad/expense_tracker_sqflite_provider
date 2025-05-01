import 'package:flutter/material.dart';

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
                  child: DropdownButton(
                    dropdownColor: Colors.purple,
                    items: const [
                      DropdownMenuItem(value: 'Cash', child: Text('Cash')),
                      DropdownMenuItem(value: 'Card', child: Text('Card')),
                    ],
                    onChanged: (value) {},
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
                  child: DropdownButton(
                    items: const [
                      DropdownMenuItem(
                        value: 'Transportation',
                        child: Text('Transportation'),
                      ),
                      DropdownMenuItem(value: 'Sports', child: Text('Sports')),
                      DropdownMenuItem(value: 'Food', child: Text('Food')),
                      DropdownMenuItem(
                        value: 'Entertainment',
                        child: Text('Entertainment'),
                      ),
                      DropdownMenuItem(
                        value: 'Education',
                        child: Text('Education'),
                      ),
                    ],
                    onChanged: (value) {},
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
