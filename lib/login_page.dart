import 'package:flutter/material.dart';
import 'package:Hobeeme/pages/search_page.dart';
import '../utils/user_loader.dart';
import '../models/user_model.dart';
import 'auth/signup_page.dart';
import 'auth/social_button.dart';
import 'auth/text_field.dart';
import 'auth/forget_password.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;
  bool _rememberMe = false;
  List<UserModel> allUsers = [];

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  Future<void> loadUsers() async {
    allUsers = await UserLoader.loadUsers();
  }

  // void validateLogin() {
  //   if (_formKey.currentState!.validate()) {
  //     String inputEmail = emailController.text.trim();
  //     String inputPassword = passwordController.text.trim();

  //     final matchedUser = allUsers.firstWhere(
  //       (user) => user.email == inputEmail && user.password == inputPassword,
  //       orElse: () => UserModel(name: '', email: '', password: ''),
  //     );

  //     if (matchedUser.email.isNotEmpty) {
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => const SearchScreen()),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Invalid email or password')),
  //       );
  //     }
  //   }
  // }

  void validateLogin() async {
    if (_formKey.currentState!.validate()) {
      allUsers = await UserLoader.loadUsers();

      String inputEmail = emailController.text.trim();
      String inputPassword = passwordController.text.trim();

      final matchedUser = allUsers.firstWhere(
        (user) => user.email == inputEmail && user.password == inputPassword,
        orElse: () => UserModel(name: '', email: '', password: ''),
      );

      if (matchedUser.email.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SearchScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password')),
        );
      }
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
                    "Welcome back",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Sign in to your account",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const SizedBox(height: 48),
                  CustomTextField(
                    controller: emailController,
                    labelText: 'Email',
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: passwordController,
                    labelText: 'Password',
                    obscureText: _obscureText,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.grey[400],
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (bool? value) {
                              setState(() {
                                _rememberMe = value!;
                              });
                            },
                            checkColor: Colors.black,
                            activeColor: Colors.yellow[700],
                            side: const BorderSide(color: Colors.white54),
                          ),
                          const Text('Remember me',
                              style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgetPassword()),
                          );
                        },
                        child: Text('Forgot password',
                            style: TextStyle(color: Colors.yellow[700])),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: validateLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow[700],
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialLoginButton(assetPath: 'assets/google.png'),
                      SizedBox(width: 20),
                      SocialLoginButton(assetPath: 'assets/apple.png'),
                      SizedBox(width: 20),
                      SocialLoginButton(assetPath: 'assets/facebook.png'),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?",
                          style: TextStyle(color: Colors.white70)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupPage()),
                          );
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow[700]),
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
