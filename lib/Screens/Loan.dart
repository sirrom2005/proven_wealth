import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:proven_wealth/Common/CommonText.dart';
import 'package:proven_wealth/Common/MyStyles.dart';

import '../Common/MyColors.dart';
import 'Templates/AppBar.dart';

class Loan extends StatefulWidget {
  static const String id = "Loan";
  const Loan({super.key});

  @override
  Page createState() => Page();
}

class Page extends State<Loan>{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;
    double safePaddingTop = MediaQuery.of(context).padding.top;
    double screenTopHeight = screenHeight/4.0;

    return Scaffold(
      backgroundColor: MyColors.appBackGroundColor,
      endDrawer: MyAppBar().getDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          MyAppBar().getSliverAppBar(screenHeight),
          SliverList(
            delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                  child: Text(CommonText.noLoan, textAlign: TextAlign.center, style: MyStyles.headerStyle2,),
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