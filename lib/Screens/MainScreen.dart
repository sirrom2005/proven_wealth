import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:proven_wealth/Screens/Login.dart';
import 'package:proven_wealth/Screens/Profile.dart';

import '../Common/CommonText.dart';
import '../Common/MyColors.dart';
import 'Accounts.dart';
import 'Events.dart';
import 'Ipo.dart';
import 'News.dart';

class MainScreen extends StatefulWidget {
  static const String id = "MainScreen";
  const MainScreen({super.key});

  @override
  Page createState() => Page();
}

class Page extends State<MainScreen> with TickerProviderStateMixin, WidgetsBindingObserver{
  late TabController tabController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this, initialIndex: 0);
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;

    double safePaddingBot = MediaQuery.of(context).padding.bottom;
    safePaddingBot = safePaddingBot>10 ? 10 : safePaddingBot;

    return DefaultTabController(
        initialIndex: 0,
        length: 4,
        child: Scaffold(
          bottomNavigationBar: menu(safePaddingBot, screenWidth),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: children(),
          ),
        )
    );
  }

  List<Widget> children(){
    return
      [
        News(),
        Accounts(),
        Ipo(),
        Events(),
        //Profile()
      ];
  }

  Widget menu(double botPadding, screenWidth) {
    double iconSize = 22;
    double iconBotMargin = 5;

    return Container(
      height:CommonText.appTabHeight + botPadding,
      color: MyColors.appBackGroundColor,
      child:  Stack(
        children: [
          TabBar(
            indicatorColor: Colors.transparent,
            controller: tabController,
            labelColor: MyColors.black,
            unselectedLabelColor: MyColors.textBlk1,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: const TextStyle(fontSize:10, color: MyColors.textBlk1),
            labelPadding: const EdgeInsets.symmetric (horizontal: 15),
            indicatorPadding: const EdgeInsets.symmetric (horizontal: 15),
            indicator: CircleTabIndicator(screenWidth),
            tabs: [
              Tab(
                  text: "Daily News",
                  iconMargin: EdgeInsets.fromLTRB(0, 0, 0, iconBotMargin),
                  icon: const Icon(Icons.newspaper)
              ),
              Tab(
                text: "Account",
                iconMargin: EdgeInsets.fromLTRB(0, 0, 0, iconBotMargin),
                icon: Icon(Icons.exit_to_app),
              ),
              Tab(
                text: "IPOPro",
                iconMargin: EdgeInsets.fromLTRB(0, 0, 0, iconBotMargin),
                icon: Icon(Icons.fingerprint),
              ),
              Tab(
                text: "Events",
                iconMargin: EdgeInsets.fromLTRB(0, 0, 0, iconBotMargin),
                icon: Icon(Icons.event_note),
              ),
              // Tab(
              //     text: "Settings",
              //     iconMargin: EdgeInsets.fromLTRB(0, 0, 0, iconBotMargin),
              //   icon: Icon(Icons.person_2_sharp),
              // )
            ],
          )
        ],
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;
  final double screenWidth;

  CircleTabIndicator(this.screenWidth) : _painter = _CirclePainter(MyColors.green, screenWidth);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _painter;
  }
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double screenWidth;

  _CirclePainter(Color color, this.screenWidth)
      : _paint = Paint()
    ..color = MyColors.black
    ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    canvas.drawRRect(
        RRect.fromLTRBAndCorners(offset.dx, 3.0, (cfg.size?.width??0)+offset.distance, 0.0,
            topLeft: const Radius.circular(3), topRight: const Radius.circular(3),
            bottomLeft: const Radius.circular(3), bottomRight: const Radius.circular(3)),
        _paint
    );
  }
}