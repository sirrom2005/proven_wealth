import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../Common/MyColors.dart';
import '../Common/MyStyles.dart';
import 'Templates/AppBar.dart';

class Events extends StatefulWidget {
  static const String id = "Events";
  const Events({super.key});

  @override
  Page createState() => Page();
}

class Page extends State<Events>{
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
        body: LoadingOverlay(
            isLoading: false,
            progressIndicator: const CircularProgressIndicator(),
            child: CustomScrollView(
                slivers: <Widget>[
                  MyAppBar().getSliverAppBar(screenHeight),
                  SliverList(
                      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                        return Text('Events Coming Soon',style: MyStyles.headerStyle1.copyWith(color: MyColors.red));
                      },
                        childCount: 1,
                      )
                  )
                ]
            )
        )
    );
  }

}