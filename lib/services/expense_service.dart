

// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/expense.dart';

// class ExpenseService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Add or update expense for a user on a specific date
//   Future<void> addOrUpdateExpense(String userId, Expense expense) async {
//     // Convert date to YYYY-MM-DD format for doc ID
//     final docId = expense.date.toIso8601String().split('T')[0];

//     // Reference to the document in expenses subcollection
//     final docRef = _firestore
//         .collection('users')
//         .doc(userId)
//         .collection('expenses')
//         .doc(docId);

//     // Set or update the expense data
//     await docRef.set(expense.toMap(), SetOptions(merge: true));
//   }

//   // Fetch all expenses for a user
//   Stream<List<Expense>> getExpenses(String userId) {
//     return _firestore
//         .collection('users')
//         .doc(userId)
//         .collection('expenses')
//         .orderBy('date')
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//             .map((doc) => Expense.fromMap(doc.id, doc.data()))
//             .toList());
//   }
// }









// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/expense.dart';

// class ExpenseService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Add or update expense for a user on a specific date
//   Future<void> addOrUpdateExpense(String userId, Expense expense) async {
//     final docId = expense.date.toIso8601String().split('T')[0]; // YYYY-MM-DD
//     final docRef = _firestore
//         .collection('users')
//         .doc(userId)
//         .collection('expenses')
//         .doc(docId);

//     await docRef.set(expense.toMap(), SetOptions(merge: true));
//   }

//   // Get a single expense by date
//   Future<Expense?> getExpenseByDate(String userId, String docId) async {
//     final doc = await _firestore
//         .collection('users')
//         .doc(userId)
//         .collection('expenses')
//         .doc(docId)
//         .get();

//     if (doc.exists) {
//       return Expense.fromMap(doc.id, doc.data()!);
//     }
//     return null;
//   }

//   // Get all expenses of a user
//   Stream<List<Expense>> getExpenses(String userId) {
//     return _firestore
//         .collection('users')
//         .doc(userId)
//         .collection('expenses')
//         .orderBy('date')
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//             .map((doc) => Expense.fromMap(doc.id, doc.data()))
//             .toList());
//   }

//   // Calculate totals for all categories
//   Future<Map<String, double>> calculateTotals(String userId) async {
//     final snapshot = await _firestore
//         .collection('users')
//         .doc(userId)
//         .collection('expenses')
//         .get();

//     double foodTotal = 0,
//         beveragesTotal = 0,
//         bmtcTotal = 0,
//         metroTotal = 0,
//         petrolTotal = 0,
//         othersTotal = 0;

//     for (var doc in snapshot.docs) {
//       final expense = Expense.fromMap(doc.id, doc.data());
//       foodTotal += expense.food;
//       beveragesTotal += expense.beverages;
//       bmtcTotal += expense.bmtc;
//       metroTotal += expense.metro;
//       petrolTotal += expense.petrol;
//       othersTotal += expense.others;
//     }

//     return {
//       'food': foodTotal,
//       'beverages': beveragesTotal,
//       'bmtc': bmtcTotal,
//       'metro': metroTotal,
//       'petrol': petrolTotal,
//       'others': othersTotal,
//     };
//   }
// }



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
