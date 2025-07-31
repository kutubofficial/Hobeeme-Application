import 'package:flutter/material.dart';
import 'package:task_two/auth/forget_password.dart';
import 'package:task_two/auth/signup_page.dart';
import 'text_field.dart';
import 'social_button.dart';
import '../pages/search_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _rememberMe = false;

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text;

      print("Email: $email");
      print("Password: $password");
      print("Remember me: $_rememberMe");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(
          content:
              Text('Login Successful', style: TextStyle(color: Colors.green))));

      _emailController.clear();
      _passwordController.clear();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SearchScreen()),
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
                    "Welcome back to",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Sign in to account",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const SizedBox(height: 48),
                  CustomTextField(
                    controller: _emailController,
                    labelText: 'Email',
                    // validator: (value) {
                    //   if (value == null ||
                    //       value.isEmpty ||
                    //       !value.contains('@')) {
                    //     return 'Please enter a valid email';
                    //   }
                    //   return null;
                    // },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _passwordController,
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
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please enter your password';
                    //   }
                    //   return null;
                    // },
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
                          const Text(
                            'Remember me',
                            style: TextStyle(color: Colors.white70),
                          ),
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
                        child: Text(
                          'Forgot password',
                          style: TextStyle(color: Colors.yellow[700]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _handleLogin,
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
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchScreen()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: Colors.grey[700]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Log in as Guest',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Row(
                    children: [
                      Expanded(child: Divider(color: Colors.white24)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'or log in with',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.white24)),
                    ],
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
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.white70),
                      ),
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
