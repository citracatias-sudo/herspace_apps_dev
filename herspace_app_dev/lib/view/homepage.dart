import 'package:flutter/material.dart';
import 'package:herspace_app_dev/decoration/cost_color.dart';

class homePageHerspace extends StatefulWidget {
  const homePageHerspace({super.key});

  @override
  State<homePageHerspace> createState() => _homePageHerspaceState();
}

class _homePageHerspaceState extends State<homePageHerspace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Herspace", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Color(0xFFF8428F),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 100, color: Color(0xFFF8428F)),
            SizedBox(height: 20),
            Text(
              "Coming Soon",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF8428F),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "This feature is under construction 🚧",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
