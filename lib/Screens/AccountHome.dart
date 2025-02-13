import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:proven_wealth/Common/MyStyles.dart';
import 'package:proven_wealth/Screens/AccountInfo.dart';
import 'package:proven_wealth/Screens/Events.dart';
import '../Common/CommonText.dart';
import '../Common/MyColors.dart';
import '../Models/ChartData.dart';
import '../Services/page_manager.dart';
import '../Services/service_locator.dart';
import 'Loan.dart';
import 'OrdersAndRequest.dart';
import 'PieChart.dart';
import 'Templates/AccountCard.dart';
import 'Templates/AppBar.dart';

class AccountHome extends StatefulWidget {
  static const String id = "AccountHome";
  const AccountHome({super.key});

  @override
  Page createState() => Page();
}

class AccountMenu{
  final String menu;
  final IconData icon;
  final Widget action;

  AccountMenu(
    {
      required this.menu,
      required this.icon,
      required this.action
    }
  );
}

class Page extends State<AccountHome>{
  final pageManager = getIt<PageManager>();
  final List<List<ChartData>> _chartData =
  [
    [
      ChartData(index: 0, title: 'Cash', color: Colors.green, chartTitle: '25%', chartValue:25 ),
      ChartData(index: 1, title: 'Unit Trust', color: Colors.blue, chartTitle: '15%', chartValue:15 ),
      ChartData(index: 2, title: 'Margin Loans', color: Colors.pink, chartTitle: '10%', chartValue:25 ),
      ChartData(index: 3, title: 'Proven Rock', color: Colors.orange, chartTitle: '30%', chartValue:35 ),
    ],
    [
      ChartData(index: 0, title: 'Cash', color: Colors.green, chartTitle: '65%', chartValue:50 ),
      ChartData(index: 1, title: 'Equity', color: Colors.blue, chartTitle: '65%', chartValue:50 )
    ],
    [
      ChartData(index: 0, title: 'Bond', color: Colors.green, chartTitle: '8%', chartValue:8 ),
      ChartData(index: 1, title: 'Cash', color: Colors.red, chartTitle: '20%', chartValue:20 ),
      ChartData(index: 2, title: 'Equity', color: Colors.green.shade900, chartTitle: '12%', chartValue:12 ),
      ChartData(index: 3, title: 'ForEx', color: Colors.blue.shade900, chartTitle: '5%', chartValue:5 ),
      ChartData(index: 4, title: 'Unit Trust', color: Colors.purpleAccent, chartTitle: '10%', chartValue:10 ),
      ChartData(index: 5, title: 'Proven Rock', color: Colors.orange, chartTitle: '30%', chartValue:30 ),
      ChartData(index: 6, title: 'Margin Loans', color: Colors.teal, chartTitle: '15%', chartValue:15 ),
    ]
  ];

  @override
  void initState() {
    super.initState();

    pageManager.chartDataNotifier.value = _chartData[0];
  }

  final List<AccountMenu> _accountMenuList = [
    AccountMenu(menu: 'Portfolio', icon: Icons.abc, action: const AccountInfo() ),
    AccountMenu(menu: 'Loans', icon: Icons.abc, action: const Loan() ),
    AccountMenu(menu: 'Orders\n&\nRequest', icon: Icons.abc, action: const OrdersAndRequest() ),
    AccountMenu(menu: 'Income\nCalendar', icon: Icons.abc, action: const Events() )
  ];

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
                    SizedBox(
                      //height: screenHeight,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child:Stack(
                          children: [
                            Column(
                              children: [
                                CarouselSlider(
                                  carouselController: carouselController,
                                  options: CarouselOptions(
                                    autoPlay: false,
                                    enlargeCenterPage: true,
                                    viewportFraction: 0.8,
                                    height: 200,
                                    onPageChanged:(index, reason){
                                      pageManager.chartDataNotifier.value = _chartData[index];
                                    }
                                  ),
                                  items: [0,1,2].map((i) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return AccountCard(pageNumber:i);
                                      },
                                    );
                                  }).toList(),
                                ),
                                SizedBox(height: 15),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: MyColors.appAccentColor,
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: Column(
                                      children: [
                                        Wrap(
                                            alignment: WrapAlignment.center,
                                            children: _accountMenuList.map((ele) =>
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                  child: SizedBox(
                                                    height:85,
                                                    width:85,
                                                    child: MaterialButton(
                                                      elevation: 0,
                                                      color: MyColors.white,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(15.0),
                                                          side: BorderSide(color: MyColors.black, width: 1)
                                                      ),
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text(ele.menu, textAlign: TextAlign.center, style:TextStyle(color: MyColors.black, fontWeight: FontWeight.bold, fontSize: 11)),
                                                          ],
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(context,
                                                          MaterialPageRoute(builder: (context) => ele.action),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                )
                                            ).toList()
                                        ),
                                        SizedBox(height: 20),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          child: Container(
                                            width: screenWidth,
                                            decoration: BoxDecoration(
                                              color: MyColors.white,
                                              borderRadius: BorderRadius.all(Radius.circular(CommonText.borderRadius))
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(height: 20),
                                                Text('Capital Summary', style: MyStyles.headerStyle1.copyWith(color: Colors.black)),
                                                ValueListenableBuilder<List<ChartData>>(
                                                  valueListenable: pageManager.chartDataNotifier,
                                                  builder: (_, value, __) {
                                                    return MyPieChartData(pieChartData: value);
                                                  }
                                                ),
                                                SizedBox(height:30)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            // Positioned(
                            //   top: 330,
                            //   bottom: 0,
                            //   child: Container(
                            //     width: screenWidth,
                            //     decoration: BoxDecoration(
                            //       color: MyColors.appAccentColor,
                            //       borderRadius: BorderRadius.only(
                            //         topRight: Radius.circular(CommonText.borderRadius),
                            //         topLeft: Radius.circular(CommonText.borderRadius)
                            //       )
                            //     )
                            //   ),
                            // ),
                            // Positioned(
                            //   top: 355,
                            //   left: 15,
                            //   right: 15,
                            //   child: Container(
                            //     width: screenWidth,
                            //     decoration: BoxDecoration(
                            //       color: MyColors.white,
                            //       borderRadius: BorderRadius.all(Radius.circular(CommonText.borderRadius))
                            //     ),
                            //     child: Column(
                            //       children: [
                            //         SizedBox(height: 20),
                            //         Text('Capital Summary', style: MyStyles.headerStyle1.copyWith(color: Colors.black)),
                            //         ValueListenableBuilder<List<ChartData>>(
                            //           valueListenable: pageManager.chartDataNotifier,
                            //           builder: (_, value, __) {
                            //             return MyPieChartData(pieChartData: value);
                            //           }
                            //         ),
                            //         SizedBox(height:520)
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ),
            )
        )
    );
  }

}