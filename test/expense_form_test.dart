import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:demo_app/models/expense.dart';
import 'package:demo_app/providers/expense_provider.dart';

// Fake provider for testing
class FakeExpenseProvider extends ChangeNotifier implements ExpenseProvider {
  final Map<String, Expense> _store = {};

  @override
  Future<Expense?> getExpenseByDate(String userId, String docId) async {
    return _store[docId];
  }

  @override
  Future<void> addOrUpdateExpense(String userId, Expense expense) async {
    _store[expense.date.toIso8601String().split('T')[0]] = expense;
    notifyListeners();
  }

  @override
  List<Expense> get expenses => _store.values.toList();

  @override
  Future<void> fetchExpenses(String userId) async {
    // Not needed for this test
  }

  @override
  double totalFood = 0;
  @override
  double totalBeverages = 0;
  @override
  double totalBMTC = 0;
  @override
  double totalMetro = 0;
  @override
  double totalPetrol = 0;
  @override
  double totalOthers = 0;
}

void main() {
  group('Expense Provider Tests', () {
    late FakeExpenseProvider provider;

    setUp(() {
      provider = FakeExpenseProvider();
    });

    test('Add and retrieve an expense', () async {
      final expense = Expense(
        date: DateTime(2024, 9, 5),
        food: 50,
        beverages: 20,
        bmtc: 15,
        metro: 0,
        petrol: 100,
        others: 10,
      );

      await provider.addOrUpdateExpense("user1", expense);

      final stored = await provider.getExpenseByDate(
          "user1", expense.date.toIso8601String().split('T')[0]);

      expect(stored, isNotNull);
      expect(stored!.food, 50);
      expect(stored.petrol, 100);
    });

    test('Expenses list contains added expense', () async {
      final expense = Expense(
        date: DateTime(2024, 9, 6),
        food: 80,
        beverages: 30,
        bmtc: 20,
        metro: 10,
        petrol: 0,
        others: 5,
      );

      await provider.addOrUpdateExpense("user1", expense);

      expect(provider.expenses.length, 1);
      expect(provider.expenses.first.food, 80);
    });
  });
}
