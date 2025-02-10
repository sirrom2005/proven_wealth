import 'package:flutter/material.dart';
import 'package:proven_wealth/Common/CommonText.dart';
import 'package:proven_wealth/Common/MyStyles.dart';
import '../Common/MyColors.dart';
import 'Templates/AppBar.dart';
import 'Templates/MyFormIconTextBox.dart';

class Ipo extends StatefulWidget {
  static const String id = "Ipo";
  const Ipo({super.key});

  @override
  Page createState() => Page();
}

class Page extends State<Ipo>{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;

    return Scaffold(
      backgroundColor: MyColors.appBackGroundColor,
      endDrawer: MyAppBar().getDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          MyAppBar().getSliverAppBar(screenHeight),
          SliverList(
            delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    children: [
                      Text(CommonText.ipoProText, style: MyStyles.mediumTextStyle2),
                      MyFormIconTextBox(hintText: 'Enter code', prefixIcon:Icons.numbers,  textInputType: TextInputType.number, onChanged:(){}),
                    ],
                  ),
                );
              },
              childCount: 1,
            )
          )
        ]
      )
    );
  }
}