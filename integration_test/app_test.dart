// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:demo_app/main.dart' as app;

// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//   testWidgets('Fill expense form and save', (tester) async {
//     app.main();
//     await tester.pumpAndSettle();

//     // Tap on add expense
//     await tester.tap(find.text('Add Expense'));
//     await tester.pumpAndSettle();

//     // Enter values
//     await tester.enterText(find.byType(TextField).first, '200');
//     await tester.enterText(find.byType(TextField).last, 'Travel');

//     // Save
//     await tester.tap(find.text('Save'));
//     await tester.pumpAndSettle();

//     expect(find.text('Travel'), findsOneWidget);
//   });
// }
