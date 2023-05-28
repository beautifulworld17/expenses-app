import 'package:flutter/material.dart';
import 'package:expense_app/models/expense.dart';

class NewExpenseForm extends StatefulWidget {
  const NewExpenseForm({Key? key, required this.addExpense}) : super(key: key);
  final void Function(Expense) addExpense;

  @override
  State<NewExpenseForm> createState() => _NewExpenseFormState();
}

class _NewExpenseFormState extends State<NewExpenseForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  Category selectedCategory = Category.food;

  DateTime? _selectedDate;
  List<String> values = Category.values.map((e) => e.name).toList();

  Future<void> _openDatePicker() async {
    final currentDate = DateTime.now();
    final firstDate =
        DateTime(currentDate.year - 1, currentDate.month, currentDate.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: firstDate,
        lastDate: currentDate);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void onSubmitExpenseData() {
    if (_titleController.text.trim().isEmpty ||
        double.tryParse(_amountController.text) == null ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("Please enter correct values"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Okay"))
              ],
            );
          });
      return;
    }
    widget.addExpense(Expense(
        title: _titleController.text,
        amount: double.parse(_amountController.text),
        date: DateTime.now(),
        category: selectedCategory));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 48, 8, 8),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              labelText: "Title",
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  decoration: const InputDecoration(
                      labelText: "Amount", prefix: Text("₹ ")),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? "No date selected"
                        : format.format(_selectedDate!)),
                    IconButton(
                        onPressed: _openDatePicker,
                        icon: const Icon(Icons.calendar_month))
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              DropdownButton(
                value: selectedCategory,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
                items: Category.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category.name),
                  );
                }).toList(),
              ),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              ElevatedButton(
                  onPressed: onSubmitExpenseData, child: const Text("Save"))
            ],
          )
        ],
      ),
    );
  }
}
