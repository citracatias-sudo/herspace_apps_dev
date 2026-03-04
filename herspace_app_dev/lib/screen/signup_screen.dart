import 'package:flutter/material.dart';
import 'package:herspace_app_dev/screen/login_screen.dart';
import 'package:herspace_app_dev/view/homepage.dart';
import '../database/db_helper.dart';
import '../decoration/cost_color.dart';

class SignUpScreenHerSpace extends StatefulWidget {
  SignUpScreenHerSpace({super.key});

  static const String routeName = '/signup';

  @override
  State<SignUpScreenHerSpace> createState() => _SignUpScreenHerSpaceState();
}

class _SignUpScreenHerSpaceState extends State<SignUpScreenHerSpace> {
  final _formKey = GlobalKey<FormState>();

  final nicknameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  String selectedRole = 'user';

  @override
  void dispose() {
    nicknameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final nickname = nicknameController.text.trim();

    final result = await DatabaseHelper.instance.insertUser({
      "nickname": nickname,
      "email": email,
      "password": password,
      "role": selectedRole,
    });

    if (!mounted) return;

    if (result > 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Account created successfully')));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => homePageHerspace()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Email already registered')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 28),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60),

                Text(
                  'Create account',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textDark,
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  'Sign up to get started',
                  style: TextStyle(fontSize: 14, color: AppColor.textLight),
                ),

                SizedBox(height: 40),

                /// NICKNAME
                TextFormField(
                  controller: nicknameController,
                  decoration: InputDecoration(
                    hintText: 'Nickname',
                    filled: true,
                    fillColor: AppColor.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nickname is required";
                    }

                    if (value.length < 3) {
                      return "Nickname must be at least 3 characters";
                    }

                    return null;
                  },
                ),

                SizedBox(height: 20),

                /// EMAIL
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    filled: true,
                    fillColor: AppColor.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Email is required";
                    }

                    final emailRegex = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$',
                    );

                    if (!emailRegex.hasMatch(value.trim())) {
                      return "Enter a valid email address";
                    }

                    return null;
                  },
                ),

                SizedBox(height: 20),

                /// PASSWORD
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: AppColor.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }

                    if (value.length < 8) {
                      return "Password must be at least 8 characters";
                    }

                    if (!RegExp(r'[A-Z]').hasMatch(value)) {
                      return "Include at least one uppercase letter";
                    }

                    if (!RegExp(r'[0-9]').hasMatch(value)) {
                      return "Include at least one number";
                    }

                    return null;
                  },
                ),

                SizedBox(height: 20),

                /// CONFIRM PASSWORD
                TextFormField(
                  controller: confirmController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Confirm password',
                    filled: true,
                    fillColor: AppColor.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Confirm your password";
                    }

                    if (value != passwordController.text) {
                      return "Passwords do not match";
                    }

                    return null;
                  },
                ),

                SizedBox(height: 20),

                /// ROLE SELECTOR
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => setState(() => selectedRole = 'user'),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: selectedRole == 'user'
                              ? AppColor.primary
                              : AppColor.white,
                          foregroundColor: selectedRole == 'user'
                              ? AppColor.background
                              : AppColor.textDark,
                          side: BorderSide(color: AppColor.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text('User', style: TextStyle(fontSize: 16)),
                      ),
                    ),

                    SizedBox(width: 12),

                    Expanded(
                      child: OutlinedButton(
                        onPressed: () =>
                            setState(() => selectedRole = 'listener'),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: selectedRole == 'listener'
                              ? AppColor.primary
                              : AppColor.white,
                          foregroundColor: selectedRole == 'listener'
                              ? AppColor.background
                              : AppColor.textDark,
                          side: BorderSide(color: AppColor.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text('Listener', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30),

                /// SIGNUP BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    onPressed: _submit,
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColor.background,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16),

                /// LOGIN REDIRECT
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: AppColor.textLight),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreenHerSpace(),
                          ),
                        );
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: AppColor.primary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
