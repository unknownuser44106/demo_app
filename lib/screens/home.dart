// import 'package:flutter/material.dart';
// import '../screens/profile.dart';
// import '../services/auth_service.dart';
// import 'login.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatelessWidget {
//   final FirebaseService _firebaseService = FirebaseService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Home")),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               decoration: BoxDecoration(color: Colors.blue),
//               child: Column(
//                 children: [
//                   CircleAvatar(radius: 30, child: Icon(Icons.person)),
//                   SizedBox(height: 10),
//                   Text(_firebaseService.currentUser?.email ?? ""),
//                 ],
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.account_circle),
//               title: Text('Profile'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => ProfileScreen()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.logout),
//               title: Text('Logout'),
//               onTap: () async {
//                 await _firebaseService.signOut();
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (_) => LoginScreen()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Center(child: Text("Welcome, ${_firebaseService.currentUser?.email ?? ""}")),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../screens/profile.dart';
import '../screens/expense_form_screen.dart';
import '../screens/expense_tracker_screen.dart';
import '../services/auth_service.dart';
import 'login.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    final userId = _firebaseService.currentUser?.uid ?? '';

    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                children: [
                  CircleAvatar(radius: 30, child: Icon(Icons.person)),
                  SizedBox(height: 10),
                  Text(_firebaseService.currentUser?.email ?? ""),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text('Expense Form'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ExpenseFormScreen(userId: userId)),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.bar_chart),
              title: Text('Expense Tracker'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ExpenseTrackerScreen(userId: userId)),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () async {
                await _firebaseService.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
          child: Text(
              "Welcome, ${_firebaseService.currentUser?.email ?? ""}")),
    );
  }
}
