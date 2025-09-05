// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/expense_provider.dart';

// class ExpenseTrackerScreen extends StatelessWidget {
//   const ExpenseTrackerScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ExpenseProvider>(context);

//     return Scaffold(
//       appBar: AppBar(title: Text('Expense Tracker')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text('Total Entries: ${provider.expenses.length}'),
//             SizedBox(height: 10),
//             _buildCategory('Food', provider.totalFood(), provider.averageFood()),
//             _buildCategory('Beverages', provider.totalBeverages(), provider.averageBeverages()),
//             _buildCategory('BMTC', provider.totalBMTC(), provider.expenses.isEmpty ? 0 : provider.totalBMTC()/provider.expenses.length),
//             _buildCategory('Metro', provider.totalMetro(), provider.expenses.isEmpty ? 0 : provider.totalMetro()/provider.expenses.length),
//             _buildCategory('Petrol', provider.totalPetrol(), provider.expenses.isEmpty ? 0 : provider.totalPetrol()/provider.expenses.length),
//             _buildCategory('Others', provider.totalOthers(), provider.expenses.isEmpty ? 0 : provider.totalOthers()/provider.expenses.length),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCategory(String name, double total, double avg) {
//     return Card(
//       child: ListTile(
//         title: Text(name),
//         subtitle: Text('Total: ₹$total, Average: ₹${avg.toStringAsFixed(2)}'),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';

class ExpenseTrackerScreen extends StatelessWidget {
  final String userId;
  ExpenseTrackerScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExpenseProvider>(context);

    // Fetch expenses initially
    provider.fetchExpenses(userId);

    return Scaffold(
      appBar: AppBar(title: Text("Expense Tracker")),
      body: provider.expenses.isEmpty
          ? Center(child: Text("No expenses added yet."))
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Expense Totals (all time):",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  _buildTotalRow("Food", provider.totalFood),
                  _buildTotalRow("Beverages", provider.totalBeverages),
                  _buildTotalRow("BMTC", provider.totalBMTC),
                  _buildTotalRow("Metro", provider.totalMetro),
                  _buildTotalRow("Petrol", provider.totalPetrol),
                  _buildTotalRow("Others", provider.totalOthers),
                  SizedBox(height: 30),
                  Text(
                    "All Entries:",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: provider.expenses.length,
                    itemBuilder: (context, index) {
                      final e = provider.expenses[index];
                      return Card(
                        child: ListTile(
                          title: Text(
                              "${e.date.toLocal().toString().split(' ')[0]}"),
                          subtitle: Text(
                              "Food: ${e.food}, Beverages: ${e.beverages}, BMTC: ${e.bmtc}, Metro: ${e.metro}, Petrol: ${e.petrol}, Others: ${e.others}"),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
    );
  }

  Widget _buildTotalRow(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16)),
          Text("₹ $value", style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
