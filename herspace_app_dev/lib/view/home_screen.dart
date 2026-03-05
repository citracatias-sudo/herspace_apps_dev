import 'package:flutter/material.dart';
import 'package:herspace_app_dev/decoration/cost_color.dart';

class homePageHerspace extends StatefulWidget {
  const homePageHerspace({super.key});

  /// Named route used for navigation
  static const String routeName = '/home';

  @override
  State<homePageHerspace> createState() => _homePageHerspaceState();
}

class _homePageHerspaceState extends State<homePageHerspace> {
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
            child: SingleChildScrollView(padding: EdgeInsets.all(24)),
          ),
        ),
      ),
    );
  }
}
