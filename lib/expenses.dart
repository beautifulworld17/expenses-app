import 'package:expense_app/widgets/expenses_list.dart';
import 'package:expense_app/models/expense.dart';
import 'package:expense_app/widgets/new_expense_form.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _expenseList = [
    Expense(
        title: "Book",
        amount: 150,
        date: DateTime.now(),
        category: Category.personal),
    Expense(
        title: "Ice-cream",
        amount: 70,
        date: DateTime.now(),
        category: Category.food)
  ];

  void _openModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return NewExpenseForm();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: _openModalSheet, icon: Icon(Icons.add))
        ],
        title: const Text("Flutter ExpenseTracker"),
      ),
      body: Column(
        children: [
          const Text("Expense graph"),
          Expanded(
            child: ExpensesList(
              expenses: _expenseList,
            ),
          )
        ],
      ),
    );
  }
}
