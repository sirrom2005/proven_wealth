import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:proven_wealth/Common/CommonText.dart';
import 'package:proven_wealth/Common/MyStyles.dart';
import 'package:proven_wealth/Screens/Templates/AppBar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../Common/MyColors.dart';
import 'Templates/NewListing.dart';
import 'Templates/NewsHeader.dart';

class News extends StatefulWidget {
  static const String id = "News";
  const News({super.key});

  @override
  Page createState() => Page();
}

class Page extends State<News> with TickerProviderStateMixin{
  final ScrollController _scrollController = ScrollController();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  late final AnimationController _animationController = AnimationController(duration: const Duration(milliseconds:250), vsync: this);
  late final Animation<double> _moveAnimation = Tween(begin:-75.0,end: 15.0).animate(_animationController);
  double _scrollPosition = 0.0;
  bool _isFloatingButtonVisible = false;

  @override
  initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onRefresh() async{
    // final loginSession = getIt<LoginSession>();
    // await PreLoadData().load(loginSession.authToken, loginSession.audioQuality, loginSession.maxSession);
    // await loadData();
    _refreshController.refreshCompleted();
    //setState(() {});
  }

  void _handleScroll() {
    if (!mounted) return;
    _scrollPosition = _scrollController.position.pixels;
    print('Scroll $_scrollPosition');
    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      if(!_isFloatingButtonVisible) {
        if (_scrollPosition >= 325) {
          _animationController.forward();
          _isFloatingButtonVisible = true;
        }
      }
    } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
      if(_isFloatingButtonVisible) {
        if (_scrollPosition < 325) {
          _animationController.reverse();
          _isFloatingButtonVisible = false;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    double screenHeight = size.height;
    double safePaddingTop = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: MyAppBar().getAppBar('', context, null),
      endDrawer: MyAppBar().getDrawer(),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh:_onRefresh,
        enablePullDown: true,
        enablePullUp: true,
        //header: WaterDropHeader(),
        child: LoadingOverlay(
          isLoading: false,
          progressIndicator: const CircularProgressIndicator(),
          child: SafeArea(
            child: Stack(
              children: [
                SizedBox(
                  height: screenHeight-160,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        Container(
                            width: screenWidth,
                            color: MyColors.black,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(CommonText.appMargin, 5, CommonText.appMargin, CommonText.appMargin),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Row(
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  //   children: [
                                  //     Image.asset('lib/assets/images/logo.png', width: screenWidth*.38),
                                  //     Expanded(child: Text('MONDAY\nJANUARY 35', textAlign: TextAlign.end, style: MyStyles.headerStyle1)),
                                  //   ],
                                  // ),
                                  //SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('TOP STORIES', style: MyStyles.headerStyle1),
                                      Icon(Icons.search, color: MyColors.white,)
                                    ],
                                  )
                                ],
                              ),
                            )
                        ),
                        //Icon(Icons.search, color: MyColors.black),
                        CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            viewportFraction: 1,
                            aspectRatio: 1.0,
                            height: 270,
                          ),
                          items: [1,2,3].map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return NewsHeader(pageNumber:i);
                              },
                            );
                          }).toList(),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(0, 10, 15, 0),
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         color: MyColors.appAccentColor,
                        //         borderRadius: BorderRadius.circular(10.0)
                        //     ),
                        //     child: Padding(
                        //       padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                        //       child: Text('Tag 1'),
                        //     ),
                        //   ),
                        // ),
                        NewListing(),
                        NewListing(),
                        NewListing(),
                        NewListing(),
                        NewListing(),
                        NewListing(),
                        NewListing(),
                        NewListing(),
                        NewListing(),
                        SizedBox(height:30)
                      ]
                    ),
                  ),
                ),
                AnimatedBuilder(
                    animation: _animationController,
                    builder: (BuildContext context, Widget? child) {
                      return Positioned(
                        bottom: 20,
                        right: _moveAnimation.value,
                        child: FloatingActionButton(
                            backgroundColor: MyColors.appAccentColor,
                            shape: const CircleBorder(),
                            onPressed:(){},
                            child: Icon(Icons.search)
                        ),
                      );
                    }
                )
              ],
            ),
          )
        ),
      )
    );
  }

}