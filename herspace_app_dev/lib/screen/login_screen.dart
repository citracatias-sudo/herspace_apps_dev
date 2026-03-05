import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:herspace_app_dev/screen/signup_screen.dart';
import '../database/db_helper.dart';
import '../decoration/cost_color.dart';
import 'package:herspace_app_dev/view/home_screen_user.dart';

class LoginScreenHerSpace extends StatefulWidget {
  const LoginScreenHerSpace({super.key});

  static const String routeName = '/login';
  static const String homePageHP = '/home';

  @override
  State<LoginScreenHerSpace> createState() => _LoginScreenHerSpaceState();
}

class _LoginScreenHerSpaceState extends State<LoginScreenHerSpace> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscurePassword = true;
  bool rememberMe = false;
  String selectedRole = "user";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        /// GRADIENT BACKGROUND
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.primary, AppColor.secondary],
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

                /// LOGIN CARD
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),

                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// ICON
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColor.accent.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.favorite_outline,
                          size: 40,
                          color: AppColor.primary,
                        ),
                      ),

                      SizedBox(height: 20),

                      Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppColor.textDark,
                        ),
                      ),

                      SizedBox(height: 6),

                      Text(
                        "Login to continue",
                        style: TextStyle(color: AppColor.textLight),
                      ),

                      SizedBox(height: 30),

                      /// EMAIL
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email_outlined),
                          filled: true,
                          fillColor: AppColor.secondary,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email required";
                          }
                          if (!value.contains("@")) {
                            return "Invalid email";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 20),

                      /// PASSWORD
                      TextFormField(
                        controller: passwordController,
                        obscureText: obscurePassword,
                        decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: AppColor.secondary,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password required";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 10),

                      /// FORGOT PASSWORD
                      Row(
                        children: [
                          Checkbox(
                            value: rememberMe,
                            activeColor: AppColor.primary,
                            onChanged: (value) {
                              setState(() {
                                rememberMe = value!;
                              });
                            },
                          ),

                          Text(
                            "Remember me",
                            style: TextStyle(
                              color: AppColor.textDark,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forgot password?",
                                style: TextStyle(color: AppColor.primary),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10),

                      /// LOGIN BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final result = await DatabaseHelper.instance
                                  .loginUser(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                    selectedRole,
                                  );
                              print("LOGIN RESULT: $result"); //check data
                              if (result.isNotEmpty) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreenUser(),
                                  ),
                                );
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
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      /// SIGN UP
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SignUpScreenHerSpace(),
                                ),
                              );
                            },
                            child: Text(
                              "Sign up",
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
