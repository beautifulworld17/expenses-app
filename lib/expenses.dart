import 'package:expense_app/widgets/chart/chart.dart';
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

  void addExpense(newExpense) {
    setState(() {
      _expenseList.add(newExpense);
    });
  }

  void removeExpense(expense) {
    int expenseIndex = _expenseList.indexOf(expense);
    setState(() {
      _expenseList.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text('Expense Item removed'),
      action: SnackBarAction(
          label: "undo",
          onPressed: () {
            setState(() {
              _expenseList.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  void _openModalSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx) {
          return NewExpenseForm(addExpense: addExpense);
        });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No expense to show...Try adding a new one"),
    );
    if (_expenseList.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _expenseList,
        removeExpense: removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: _openModalSheet, icon: const Icon(Icons.add))
        ],
        title: const Text("Flutter ExpenseTracker"),
      ),
      body: Column(
        children: [
          Chart(
            expenses: _expenseList,
          ),
          Expanded(
            child: mainContent,
          )
        ],
      ),
    );
  }
}
