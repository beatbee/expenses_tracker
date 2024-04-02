import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
class ExpenseItem extends StatelessWidget{
  const ExpenseItem(this.expense, {super.key}); 
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 8,
      ),
      child:Card(
      
      child: Padding(
        padding:const EdgeInsets.fromLTRB(
          16,
          8,
          16,
          8,
        ),
        child: Column(
          children: [
            Text(expense.title, style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            ),
            const SizedBox(height: 20),
            Row
            (children: [
              Text('\$${expense.amount.toStringAsFixed(2)}'),
              const Spacer(),
              Row(
                children: [
                  Icon(categoryIcons[expense.category]),
                  const SizedBox(width: 5),
                  Text(expense.formattedDate),
                ],
              ),
            ],
            )
          ]
        ),
        ),
        
    ),
    );
  }
}