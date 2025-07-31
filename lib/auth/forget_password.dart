import 'package:flutter/material.dart';
import 'package:task_two/auth/loginpage.dart';
import 'package:task_two/auth/verify_otp.dart';
import 'text_field.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _forgetController = TextEditingController();

  void _handlePassword() {
    if (_formKey.currentState!.validate()) {
      String forget = _forgetController.text.trim();

      print("OTP: $forget");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(
          content: Text('OTP sent, check your Email',
              style: TextStyle(color: Colors.green))));

      _forgetController.clear();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const VerifyOtp()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset('assets/rocket.gif', height: 80),
                  const SizedBox(height: 20),
                  const Text(
                    "Forget Password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Need help resetting your password? Let's get started!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const SizedBox(height: 48),
                  CustomTextField(
                    controller: _forgetController,
                    labelText: 'abc@gmail.example',
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _handlePassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow[700],
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Forget Password',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "have an account?",
                        style: TextStyle(color: Colors.white70),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
