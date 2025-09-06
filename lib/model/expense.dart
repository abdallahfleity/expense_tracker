import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
  Category.travel: Icons.flight_takeoff,
};

class Expense {
  final String id;
  final String title;
  final double amounts;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }

  Expense({
    required this.category,
    required this.title,
    required this.amounts,
    required this.date,
  }) : id = uuid.v4();
}

class ExpenseBucket {

  final Category category;
  final List<Expense> expenses;


  const ExpenseBucket({required this.category, required this.expenses});

  // this how you add additional constructor
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
    : expenses = allExpenses
          .where((expense) => expense.category == category)
          .toList();



  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amounts;
    }

    return sum;
  }
}
