import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'reset.dart';

import 'home.dart';
import 'signup.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();
  bool isLoading = false;

  void login() async {
    setState(() => isLoading = true);
    String? res = await _firebaseService.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    setState(() => isLoading = false);

    if (res != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : login,
              child: isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Login"),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => SignUpScreen()));
              },
              child: Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
