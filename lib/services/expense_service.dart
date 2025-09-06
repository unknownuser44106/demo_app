import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/expense.dart';

class ExpenseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add or update expense for a user on a specific date
  Future<void> addOrUpdateExpense(String userId, Expense expense) async {
    final docId = expense.date.toIso8601String().split('T')[0]; // YYYY-MM-DD
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('expenses')
        .doc(docId)
        .set(expense.toMap(), SetOptions(merge: true)); // merge allows updates
  }

  // Fetch all expenses for a user
  Future<List<Expense>> getAllExpenses(String userId) async {
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('expenses')
        .orderBy('date')
        .get();

    return snapshot.docs
        .map((doc) => Expense.fromMap(doc.id, doc.data()))
        .toList();
  }

  // Fetch expense for a specific date
  Future<Expense?> getExpenseByDate(String userId, String docId) async {
    final doc = await _firestore
        .collection('users')
        .doc(userId)
        .collection('expenses')
        .doc(docId)
        .get();

    if (doc.exists) {
      return Expense.fromMap(doc.id, doc.data()!);
    }
    return null;
  }
}
