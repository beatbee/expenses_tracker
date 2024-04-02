import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart';
final formatter = DateFormat.yMd();
class NewExpense extends StatefulWidget{
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense>{
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.Food;
  @override
  void dispose(){
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
  void _presentDatePicker() async{
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    
    final pickedDate = await showDatePicker(context: context,initialDate: now, firstDate: firstDate, lastDate: now);
    print(pickedDate);
    setState(() {
      _selectedDate = pickedDate;
    });
  }
  void _submitExpenseData(){
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate == null){
      showDialog(context: context, builder: (ctx) => AlertDialog(
        title: const Text('Invalid Input'),
        content: const Text('Please enter a valid title and amount'),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.of(ctx).pop();
            }, 
            child: const Text('Okay'),
          ),
        ],
      ),
      );
      return;
    }
    widget.onAddExpense(Expense(title: _titleController.text, amount: enteredAmount, date: _selectedDate!, category: _selectedCategory),);
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16,48,16,16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label : Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child:
                  TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  //maxLength: 50,
                  decoration: const InputDecoration(
                  prefixText: '\$',
                  label : Text('Amount'),
                  ),
                ),
              ),
              //const SizedBox(width: 5),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_selectedDate == null ? 'No Date Chosen' : '${formatter.format(_selectedDate!)}'),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon : const Icon(Icons.calendar_month),
                      ),
                ],)
              )
            ],
          ),
      
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values.map(
                (category) => DropdownMenuItem(
                  value: category,
                  child: Text(category.name.toUpperCase(),),),).toList(), 
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value as Category;
                    });
                  },
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                }, 
                child: const Text('Cancel'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text('Add Expense')),
            ],
            )
        ],
      ),
      );
  }
}