import 'package:expense_app/models/expense.dart';
import 'package:flutter/material.dart';

import 'Expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {Key? key, required this.expenses, required this.removeExpense})
      : super(key: key);
  final List<Expense> expenses;
  final void Function(Expense expense) removeExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) {
          return Dismissible(
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(.35),
            ),
            key: ValueKey(expenses[index]),
            onDismissed: (direction) {
              removeExpense(expenses[index]);
            },
            child: ExpenseItem(
              expenseItem: expenses[index],
            ),
          );
        });
  }
}
