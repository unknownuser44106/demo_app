import 'package:flutter/material.dart';
import '../services/auth_service.dart';
// lib/screens/signup_screen.dart
import 'login.dart';
import 'home.dart';

// ignore: use_key_in_widget_constructors
class SignUpScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();
  bool isLoading = false;

  void signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        // ignore: prefer_const_constructors
        SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    setState(() => isLoading = true);
    String? res = await _firebaseService.signUp(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    setState(() => isLoading = false);

    if (res != null) {
      if (res.contains("email-already-in-use")) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User already signed up. Please login.")),
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LoginScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Signup successful")),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(labelText: "Confirm Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : signUp,
              child: isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Sign Up"),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => LoginScreen()));
              },
              child: Text("Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}
