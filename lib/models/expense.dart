import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final format = DateFormat.yMMMMd();

enum Category { travel, personal, food, shopping }

const categoryIcons = {
  Category.travel: Icons.airplanemode_active,
  Category.personal: Icons.person,
  Category.food: Icons.lunch_dining,
  Category.shopping: Icons.shopping_bag
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return format.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket(this.category, this.expenses);

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0.0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
