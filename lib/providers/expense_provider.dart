import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../services/expense_service.dart';

class ExpenseProvider extends ChangeNotifier {
  final ExpenseService _service = ExpenseService();

  List<Expense> _expenses = [];
  List<Expense> get expenses => _expenses;

  // Totals per category
  double totalFood = 0;
  double totalBeverages = 0;
  double totalBMTC = 0;
  double totalMetro = 0;
  double totalPetrol = 0;
  double totalOthers = 0;

  // Add or update an expense
  Future<void> addOrUpdateExpense(String userId, Expense expense) async {
    await _service.addOrUpdateExpense(userId, expense);
    await fetchExpenses(userId);
    _calculateTotals(); // update totals
  }

  // Fetch all expenses
  Future<void> fetchExpenses(String userId) async {
    _expenses = await _service.getAllExpenses(userId);
    _calculateTotals();
    notifyListeners();
  }

  // Get expense by date
  Future<Expense?> getExpenseByDate(String userId, String docId) async {
    return await _service.getExpenseByDate(userId, docId);
  }

  // Calculate totals per category
  void _calculateTotals() {
    totalFood = _expenses.fold(0, (sum, e) => sum + e.food);
    totalBeverages = _expenses.fold(0, (sum, e) => sum + e.beverages);
    totalBMTC = _expenses.fold(0, (sum, e) => sum + e.bmtc);
    totalMetro = _expenses.fold(0, (sum, e) => sum + e.metro);
    totalPetrol = _expenses.fold(0, (sum, e) => sum + e.petrol);
    totalOthers = _expenses.fold(0, (sum, e) => sum + e.others);
  }
}
