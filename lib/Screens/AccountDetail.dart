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

class AccountDetail extends StatefulWidget {
  static const String id = "AccountDetail";
  const AccountDetail({super.key});

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

class Page extends State<AccountDetail>{
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Text('Equity',style: MyStyles.headerStyle1)),
                      Text('Some random info here', style: MyStyles.headerStyle2),
                      Text('\$ 3,000.23', style: MyStyles.headerStyle1),
                    ],
                  ),
                )
              ),
            )
        )
    );
  }

}