import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});
  static const name = "category_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(children: [Text(r"$32,500.00"), Text("Total Balance")]),
        actions: [Icon(Icons.notifications_none_rounded, size: 36)],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
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
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              dropdownColor: Colors.purple,
                              items: const [
                                DropdownMenuItem(
                                  value: 'Cash',
                                  child: Text('Cash'),
                                ),
                                DropdownMenuItem(
                                  value: 'Card',
                                  child: Text('Card'),
                                ),
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
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              items: const [
                                DropdownMenuItem(
                                  value: 'Transportation',
                                  child: Text('Transportation'),
                                ),
                                DropdownMenuItem(
                                  value: 'Sports',
                                  child: Text('Sports'),
                                ),
                                DropdownMenuItem(
                                  value: 'Food',
                                  child: Text('Food'),
                                ),
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
            },
          );
        },
        child: Icon(Icons.add),
      ),
      drawer: Container(),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.deepPurple.shade100,
        selectedItemColor: Colors.red,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 100,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(child: Text("Day")),
                ),
                Container(
                  width: 100,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(child: Text("Week")),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 100,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(child: Text("Month")),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 18,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      "Travel",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Cash | Card"),
                    leading: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(Icons.circle, color: Colors.purple, size: 40),
                        Icon(
                          Icons.airplanemode_active_rounded,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          r"$498.50",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text("32%", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
