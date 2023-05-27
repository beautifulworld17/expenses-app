import 'package:flutter/material.dart';

import '../models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({Key? key, required this.expenseItem}) : super(key: key);

  final Expense expenseItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(expenseItem.title),
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text('₹ ${expenseItem.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Icon(categoryIcons[expenseItem.category]),
                Text(expenseItem.formattedDate)
              ],
            )
          ],
        ),
      ),
    );
  }
}
