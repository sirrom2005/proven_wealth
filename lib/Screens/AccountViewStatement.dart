import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:proven_wealth/Common/MyStyles.dart';
import '../Common/CommonText.dart';
import '../Common/MyColors.dart';
import '../Models/ChartData.dart';
import '../Services/page_manager.dart';
import '../Services/service_locator.dart';
import 'PieChart.dart';
import 'Templates/AccountCard.dart';
import 'Templates/AppBar.dart';

class AccountViewStatement extends StatefulWidget {
  static const String id = "ViewStatement";
  const AccountViewStatement({super.key});

  @override
  Page createState() => Page();
}

class AccountMenu{
  final String menu;
  final IconData icon;

  AccountMenu(
    {
      required this.menu,
      required this.icon
    }
  );
}

class Page extends State<AccountViewStatement>{
  final pageManager = getIt<PageManager>();

  @override
  void initState() {
    super.initState();

    //pageManager.chartDataNotifier.value = _chartData[0];
  }

  Future<String> fetchUserData() async {
    await Future.delayed(Duration(seconds: 2));
    return 'Hello';
    //throw Exception('Failed to fetch user data'); // Throw an exception (error)
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    CarouselSliderController carouselController = CarouselSliderController();

    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    double screenHeight = size.height;
    double safePaddingTop = MediaQuery.of(context).padding.top;

    return Scaffold(
        key: scaffoldKey,
        backgroundColor: MyColors.appBackGroundColor,
        appBar: MyAppBar().getAppBar('', context, scaffoldKey, admin:true),
        endDrawer: MyAppBar().getDrawer(),
        body: LoadingOverlay(
            isLoading: false,
            progressIndicator: const CircularProgressIndicator(),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('View Statement Coming Soon', style: MyStyles.headerStyle1.copyWith(color: MyColors.red))
                  ],
                )
              ),
            )
        )
    );
  }

}