import 'package:flutter/material.dart';
import 'package:herspace_app_dev/screen/login_screen.dart';
import '../database/db_helper.dart';
import '../decoration/cost_color.dart';

class SignUpScreenHerSpace extends StatefulWidget {
  const SignUpScreenHerSpace({super.key});

  static String routeName = '/signup';

  @override
  State<SignUpScreenHerSpace> createState() => _SignUpScreenHerSpaceState();
}

class _SignUpScreenHerSpaceState extends State<SignUpScreenHerSpace> {
  final _formKey = GlobalKey<FormState>();

  final nicknameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

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

      Navigator.of(context).pushReplacementNamed(LoginScreenHerSpace.routeName);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Email already registered')));
    }
  }

  void _showForgotPasswordDialog() {
    final recoveryEmailController = TextEditingController();
    final dialogFormKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Forgot Password"),
          content: Form(
            key: dialogFormKey,
            child: TextFormField(
              controller: recoveryEmailController,
              decoration: InputDecoration(
                labelText: "Enter your email",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email required";
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (!dialogFormKey.currentState!.validate()) return;

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Recovery email sent to ${recoveryEmailController.text}",
                    ),
                  ),
                );
              },
              child: Text("Send"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        /// GRADIENT BACKGROUND
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.surface, AppColor.secondary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Container(
                padding: EdgeInsets.all(28),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),

                      Text(
                        "Join the Community",
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        "Create your account",
                        style: TextStyle(fontSize: 13),
                      ),
                      SizedBox(height: 20),

                      Text(
                        'Sign up to get started',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColor.textLight,
                        ),
                      ),

                      SizedBox(height: 40),

                      /// NICKNAME
                      TextFormField(
                        controller: nicknameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.favorite_outline_rounded),
                          hintText: 'Nickname',

                          filled: true,
                          fillColor: AppColor.surface,
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
                          prefixIcon: Icon(Icons.mail),
                          hintText: 'Email',
                          filled: true,
                          fillColor: AppColor.surface,
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
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          filled: true,
                          fillColor: AppColor.surface,
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
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
                        obscureText: _obscureConfirm,
                        decoration: InputDecoration(
                          hintText: 'Confirm password',
                          filled: true,
                          fillColor: AppColor.surface,
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirm
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirm = !_obscureConfirm;
                              });
                            },
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

                      SizedBox(height: 12),

                      /// FORGOT PASSWORD
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: _showForgotPasswordDialog,
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: AppColor.surface),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      /// ROLE SELECTOR
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () =>
                                  setState(() => selectedRole = 'user'),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: selectedRole == 'user'
                                    ? AppColor.primary
                                    : AppColor.surface,
                                foregroundColor: selectedRole == 'user'
                                    ? AppColor.background
                                    : AppColor.textDark,
                                side: BorderSide(color: AppColor.surface),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: Text(
                                'User',
                                style: TextStyle(fontSize: 16),
                              ),
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
                                    : AppColor.surface,
                                foregroundColor: selectedRole == 'listener'
                                    ? AppColor.background
                                    : AppColor.textDark,
                                side: BorderSide(color: AppColor.primary),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: Text(
                                'Listener',
                                style: TextStyle(fontSize: 16),
                              ),
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
          ),
        ),
      ),
    );
  }
}
