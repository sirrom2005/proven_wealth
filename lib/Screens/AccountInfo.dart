import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:proven_wealth/Common/MyStyles.dart';
import 'package:proven_wealth/Screens/AccountDetail.dart';
import 'package:proven_wealth/Screens/AccountRequestStatement.dart';
import 'package:proven_wealth/Screens/AccountViewStatement.dart';
import '../Common/CommonText.dart';
import '../Common/MyColors.dart';
import '../Models/ChartData.dart';
import '../Services/page_manager.dart';
import '../Services/service_locator.dart';
import 'PieChart.dart';
import 'Templates/AccountCard.dart';
import 'Templates/AppBar.dart';
import 'Templates/MyOutLineButton.dart';

class AccountInfo extends StatefulWidget {
  static const String id = "AccountInfo";
  const AccountInfo({super.key});

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

class Page extends State<AccountInfo> with TickerProviderStateMixin{
  late final AnimationController _animationController = AnimationController(duration: const Duration(milliseconds:250), vsync: this);
  late final Animation<double> _moveAnimation = Tween(begin:1.0,end:0.0).animate(_animationController);
  late final Animation<double> _rotateAnimation = Tween(begin:0.0,end:3.0).animate(_animationController);
  final pageManager = getIt<PageManager>();
  bool _isOpen = true;

  final List<ChartData> _chartData =
  [
    ChartData(index: 0, title: 'Bond', color: Colors.green, chartTitle: '8%', chartValue:8 ),
    ChartData(index: 1, title: 'Cash', color: Colors.red, chartTitle: '20%', chartValue:20 ),
    ChartData(index: 2, title: 'Equity', color: Colors.green.shade900, chartTitle: '12%', chartValue:12 ),
    ChartData(index: 3, title: 'ForEx', color: Colors.blue.shade900, chartTitle: '5%', chartValue:5 ),
    ChartData(index: 4, title: 'Unit Trust', color: Colors.purpleAccent, chartTitle: '10%', chartValue:10 ),
    ChartData(index: 5, title: 'Proven Rock', color: Colors.orange, chartTitle: '30%', chartValue:30 ),
    ChartData(index: 6, title: 'Margin Loans', color: Colors.teal, chartTitle: '15%', chartValue:15 ),
  ];

  @override
  void initState() {
    super.initState();
    //pageManager.chartDataNotifier.value = _chartData[0];
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
                    MyPieChartData(pieChartData: _chartData),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 20, 50, 10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: MyColors.lightGray
                            )
                          )
                        )
                      ),
                    ),
                    Center(child: Text('Account Number: ****1234',style: MyStyles.headerStyle1)),
                    Center(child: Text('JMD \$10,900.89',style: MyStyles.headerStyle1.copyWith(color: MyColors.appAccentColor))),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: MyOutLineButton(text:'Request Statement', onPressed:(){
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const AccountRequestStatement()),
                              );
                            })
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: MyOutLineButton(text: 'View Statement', onPressed:(){
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const AccountViewStatement()),
                              );
                            })
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: MyColors.lightGray)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Row(
                                  children: [
                                    Expanded(child: Text('My Investments', style: MyStyles.headerStyle3)),
                                    InkWell(
                                      child: AnimatedBuilder(
                                          animation: _animationController,
                                          builder: (BuildContext context, Widget? child) {
                                          return Transform.rotate(
                                            angle: _rotateAnimation.value,
                                            child: Icon(Icons.arrow_circle_down, size:25, color: MyColors.appAccentColor)
                                          );
                                        }
                                      ),
                                      onTap:(){
                                        if(_isOpen) {
                                          _animationController.forward();
                                        }else {
                                          _animationController.reverse();
                                        }
                                        _isOpen=!_isOpen;
                                      },
                                    )
                                  ],
                                ),
                              ),
                              AnimatedBuilder(
                                animation: _animationController,
                                builder: (BuildContext context, Widget? child) {
                                  return SizedBox(
                                    height:(7*85)*_moveAnimation.value,
                                    child: SingleChildScrollView(
                                      physics: const NeverScrollableScrollPhysics(),
                                      child: Column(
                                        children: [
                                          for(int i=0; i<_chartData.length;i++)
                                            InkWell(
                                              child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          top: BorderSide(
                                                              color: MyColors.lightGray
                                                          )
                                                      )
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 5),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(_chartData[i].title, style: MyStyles.headerStyle1.copyWith(color: MyColors.appAccentColor)),
                                                        Text('\$ 3,020.89', style: MyStyles.headerStyle1.copyWith(color: MyColors.black)),
                                                        Text('Currency: USD', style: MyStyles.headerStyle3),
                                                      ],
                                                    ),
                                                  )
                                              ),
                                              onTap: (){
                                                Navigator.push(context,
                                                  MaterialPageRoute(builder: (context) => const AccountDetail()),
                                                );
                                              },
                                            )
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height:60)
                  ],
                )
              ),
            )
        )
    );
  }

}