import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/expense.dart';
import '../providers/expense_provider.dart';

class ExpenseFormScreen extends StatefulWidget {
  final String userId;
  ExpenseFormScreen({required this.userId});

  @override
  _ExpenseFormScreenState createState() => _ExpenseFormScreenState();
}

class _ExpenseFormScreenState extends State<ExpenseFormScreen> {
  DateTime selectedDate = DateTime.now();

  final foodController = TextEditingController();
  final beveragesController = TextEditingController();
  final bmtcController = TextEditingController();
  final metroController = TextEditingController();
  final petrolController = TextEditingController();
  final othersController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadExpenseForDate(selectedDate);
  }

  // Load existing expense for selected date
  void _loadExpenseForDate(DateTime date) async {
    final docId = date.toIso8601String().split('T')[0];
    final provider = Provider.of<ExpenseProvider>(context, listen: false);
    final existingExpense =
        await provider.getExpenseByDate(widget.userId, docId);

    if (existingExpense != null) {
      foodController.text = existingExpense.food.toString();
      beveragesController.text = existingExpense.beverages.toString();
      bmtcController.text = existingExpense.bmtc.toString();
      metroController.text = existingExpense.metro.toString();
      petrolController.text = existingExpense.petrol.toString();
      othersController.text = existingExpense.others.toString();
    } else {
      foodController.clear();
      beveragesController.clear();
      bmtcController.clear();
      metroController.clear();
      petrolController.clear();
      othersController.clear();
    }
  }

  // Save or update expense
  void _saveExpense() async {
    final expense = Expense(
      date: selectedDate,
      food: double.tryParse(foodController.text) ?? 0,
      beverages: double.tryParse(beveragesController.text) ?? 0,
      bmtc: double.tryParse(bmtcController.text) ?? 0,
      metro: double.tryParse(metroController.text) ?? 0,
      petrol: double.tryParse(petrolController.text) ?? 0,
      others: double.tryParse(othersController.text) ?? 0,
    );

    final provider = Provider.of<ExpenseProvider>(context, listen: false);
    await provider.addOrUpdateExpense(widget.userId, expense);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Expense saved/updated for ${selectedDate.toLocal().toString().split(' ')[0]}")),
    );
  }

  @override
  void dispose() {
    foodController.dispose();
    beveragesController.dispose();
    bmtcController.dispose();
    metroController.dispose();
    petrolController.dispose();
    othersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Expense Form")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Date Picker
            Row(
              children: [
                Text("Date: ${selectedDate.toLocal().toString().split(' ')[0]}"),
                Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setState(() {
                        selectedDate = picked;
                      });
                      _loadExpenseForDate(selectedDate);
                    }
                  },
                  child: Text("Select Date"),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Expense fields
            _buildTextField("Food", foodController),
            _buildTextField("Beverages", beveragesController),
            _buildTextField("BMTC", bmtcController),
            _buildTextField("Metro", metroController),
            _buildTextField("Petrol", petrolController),
            _buildTextField("Others", othersController),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveExpense,
              child: Text("Save / Update Expense"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }
}
