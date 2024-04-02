import 'package:expense_tracker/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/expense_list.dart';
class Expenses extends StatefulWidget{
  const Expenses({super.key});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ExpensesState();
  }
}



class _ExpensesState extends State<Expenses>{
  final List<Expense> _registeredexpenses = [
  ];
  void _openAddExpenseOverlay(){
    showModalBottomSheet(isScrollControlled: true,context:  context, builder: (ctx) => NewExpense(onAddExpense: _addExpense),);
  }
  void _addExpense(Expense expense){
    setState(() {
      _registeredexpenses.add(expense);
    });
  }
  void _removeExpense(Expense expense){
    final expenseIndex = _registeredexpenses.indexOf(expense);
    setState(() {
      _registeredexpenses.remove(expense);
    }); 
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Expense removed'),
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: 'UNDO',
        onPressed: (){
          setState(() {
            _registeredexpenses.insert(expenseIndex, expense);
          });
        },
      ),
    ));
  }
  @override
  Widget build(BuildContext context) {
    Widget mainContent =  const Center(
      child: Text('No expenses added yet'),
      );
      if (_registeredexpenses.isNotEmpty){
        mainContent = ExpensesList(expenses: _registeredexpenses, onRemoveExpense: _removeExpense);
      }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        backgroundColor: Color.fromARGB(255, 159, 235, 204),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: (){
              _openAddExpenseOverlay();
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
         const Text('The chart'),
         Expanded(
          child : mainContent, 
          ), 
        ],
      ),
    );

  }
}