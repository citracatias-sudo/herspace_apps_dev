import 'package:flutter/material.dart';
import '../decoration/cost_color.dart';

class HomeScreenUser extends StatelessWidget {
  const HomeScreenUser({super.key});

  static const String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,

      appBar: AppBar(
        title: const Text("HerSpace"),
        backgroundColor: AppColor.primary,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            Text(
              "Hello 🌷",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColor.textDark,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              "How are you feeling today?",
              style: TextStyle(fontSize: 14, color: AppColor.textLight),
            ),

            const SizedBox(height: 30),

            /// TALK TO LISTENER (main feature)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Talk to a Listener",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    "Share what you're feeling in a safe space.",
                    style: TextStyle(color: Colors.white70),
                  ),

                  const SizedBox(height: 15),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),

                    onPressed: () {
                      // navigate to chat later
                    },

                    child: const Text(
                      "Start Conversation",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Text(
              "Explore",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColor.textDark,
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,

                children: [
                  _featureCard(icon: Icons.groups, title: "Community"),

                  _featureCard(icon: Icons.menu_book, title: "Articles"),

                  _featureCard(icon: Icons.event, title: "Events"),

                  _featureCard(icon: Icons.favorite, title: "Self Care"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _featureCard({required IconData icon, required String title}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: AppColor.primary),

          const SizedBox(height: 10),

          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
