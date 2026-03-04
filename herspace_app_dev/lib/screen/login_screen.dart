import 'package:flutter/material.dart';
import 'package:herspace_app_dev/screen/signup_screen.dart';
import '../database/db_helper.dart';
import '../decoration/cost_color.dart';

class LoginScreenHerSpace extends StatefulWidget {
  const LoginScreenHerSpace({super.key});

  /// route name for this screen
  static const String routeName = '/login';

  /// home page route constant (consumer can change the value as needed)
  static const String homePageHP = '/home';

  @override
  State<LoginScreenHerSpace> createState() => _LoginScreenHerSpaceState();
}

class _LoginScreenHerSpaceState extends State<LoginScreenHerSpace> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String selectedRole = "user";

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
                  "Welcome back",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textDark,
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  "Login to continue",
                  style: TextStyle(fontSize: 14, color: AppColor.textLight),
                ),

                SizedBox(height: 40),

                // EMAIL
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    filled: true,
                    fillColor: AppColor.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email required";
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),

                // PASSWORD
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    filled: true,
                    fillColor: AppColor.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password required";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),

                // ROLE SELECTOR (two buttons filling width)
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
                        child: Text(
                          'User',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
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
                        child: Text(
                          'Listener',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30),

                // LOGIN BUTTON
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final result = await DatabaseHelper.instance.loginUser(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );

                        if (result.isNotEmpty) {
                          if (result.first["role"]?.toString() ==
                              selectedRole) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Login Success")),
                            );
                            // navigate to home page named route
                            Navigator.of(context).pushReplacementNamed(
                              LoginScreenHerSpace.homePageHP,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Role mismatch")),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Invalid login")),
                          );
                        }
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColor.background,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        // TODO: navigate to forgot password screen
                      },
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(color: AppColor.textDark),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreenHerSpace(),
                          ),
                          (Route) => false,
                        );
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(color: AppColor.textDark),
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
