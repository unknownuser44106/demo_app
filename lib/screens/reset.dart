import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();
  bool isLoading = false;

  void resetPassword() async {
    setState(() => isLoading = true);
    String? res = await _firebaseService.resetPassword(emailController.text.trim());
    setState(() => isLoading = false);

    if (res != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password reset email sent")));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : resetPassword,
              child: isLoading ? CircularProgressIndicator(color: Colors.white) : Text("Send Reset Link"),
            ),
          ],
        ),
      ),
    );
  }
}
