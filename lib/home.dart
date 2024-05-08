import 'package:flutter/material.dart';
import 'signupscreen.dart';

class ExpenseCalculatorScreen extends StatefulWidget {
  @override
  _ExpenseCalculatorScreenState createState() => _ExpenseCalculatorScreenState();
}

class _ExpenseCalculatorScreenState extends State<ExpenseCalculatorScreen> {
  double remainingBalance = 50000;
  double income = 0;
  double expense = 0;
  List<ExpenseItem> expenses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.yellowAccent.withOpacity(0.04), Colors.white],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 40,
              right: 120,
              child: Column(
                children: [
                  Text(
                    'Account Balance',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '₹${remainingBalance.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 140,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  _showAddIncomeDialog(context);
                },
                child: Container(
                  width: 170,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.attach_money, color: Colors.white),
                          SizedBox(width: 5),
                          Text(
                            'Income: \n₹${income.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Expense Container
            Positioned(
              top: 140,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  _showAddExpenseDialog(context);
                },
                child: Container(
                  width: 190,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.money_off, color: Colors.white),
                          SizedBox(width: 5),
                          Text(
                            'Expenses: \n₹${expense.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 200,
              left: 20,
              right: 20,
              bottom: 200,
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(expenses[index].name),
                    subtitle: Text('₹${expenses[index].amount.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          // Remove the expense from the list
                          expense -= expenses[index].amount;
                          remainingBalance += expenses[index].amount;
                          expenses.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
             
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  _showAddExpenseDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(16),
                  primary: Color(0xFF7F3DFF),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 24.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddIncomeDialog(BuildContext context) {
    TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Income'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: 'Amount'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  double amount = double.parse(amountController.text);
                  income += amount;
                  remainingBalance += amount;
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showAddExpenseDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Expense'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Expense Name'),
                ),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: 'Amount'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  String name = nameController.text;
                  double amount = double.parse(amountController.text);
                  expense += amount;
                  remainingBalance -= amount;
                  expenses.add(ExpenseItem(name: name, amount: amount));
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class ExpenseItem {
  final String name;
  final double amount;

  ExpenseItem({required this.name, required this.amount});
}
