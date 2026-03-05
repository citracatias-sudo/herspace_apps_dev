import 'package:flutter/material.dart';
import 'package:herspace_app_dev/decoration/cost_color.dart';

class PopupAgreementHerspace extends StatelessWidget {
  const PopupAgreementHerspace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AlertDialog(
            actionsPadding: EdgeInsets.all(60),
            actions: [
              Title(color: AppColor.textDark, child: 
              Text("Terms & Conditions", style: TextStyle(fontSize: 25),)),
              // TODO Text("nanti diisi")
            ],
          ),
        ],
      ),
    );
  }
}
