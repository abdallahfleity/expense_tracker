
import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title,style: Theme.of(context).textTheme.labelLarge,),//it inherit here settings and colors from the main.dart theme
            const SizedBox(height: 4),
            Row(
              children: [
                // Toolbar with the add button =>Row()
                Text('\$${expense.amounts.toStringAsFixed(2)}'),
                const Spacer(),
                //spacer take all the space between the Text and the row push one to the left and one to the right
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 8),
                    Text(expense.formattedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
