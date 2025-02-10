import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:proven_wealth/Common/CommonText.dart';
import 'package:proven_wealth/Common/MyStyles.dart';
import 'package:proven_wealth/Screens/Templates/AppBar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../Common/MyColors.dart';
import 'Templates/MySearchTextBox.dart';
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
  late final AnimationController _searchSlideDownAnimationController = AnimationController(duration: const Duration(milliseconds:250), vsync: this);
  late final Animation<double> _searchSlideDownAnimation = Tween(begin:0.0,end:1.0).animate(_searchSlideDownAnimationController);
  late final AnimationController _searchSlideSideAnimationController = AnimationController(duration: const Duration(milliseconds:250), vsync: this);
  late final Animation<double> _searchSlideSideAnimation = Tween(begin:0.0,end:1.0).animate(_searchSlideSideAnimationController);
  double _scrollPosition = 0.0;
  bool _isTopSearchBarOpen = false;
  bool _isSideSearchBarOpen = false;
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
    _animationController.dispose();
    _searchSlideDownAnimationController.dispose();
    _searchSlideSideAnimationController.dispose();
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

    if(_isSideSearchBarOpen) {
      _searchSlideSideAnimationController.reverse();
      _isSideSearchBarOpen = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    double screenHeight = size.height;

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
                                    Text('TOP STORIES', style: MyStyles.headerStyle1.copyWith(color: MyColors.white)),
                                    InkWell(
                                      child: Icon(Icons.search, color: MyColors.white),
                                      onTap:(){
                                        if(_isTopSearchBarOpen) {
                                          _searchSlideDownAnimationController.reverse();
                                        }else{
                                          _searchSlideDownAnimationController.forward();
                                        }
                                        FocusScope.of(context).unfocus();
                                        _isTopSearchBarOpen=!_isTopSearchBarOpen;
                                      }
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ),
                        AnimatedBuilder(
                            animation: _searchSlideDownAnimationController,
                            builder: (BuildContext context, Widget? child) {
                            return SizedBox(
                              height:50*_searchSlideDownAnimation.value,
                              child: SingleChildScrollView(
                                physics:const NeverScrollableScrollPhysics(),
                                child: MySearchTextBox(onTap:(){
                                  _searchSlideDownAnimationController.reverse();
                                  FocusScope.of(context).unfocus();
                                  _isTopSearchBarOpen = false;
                                })
                              )
                            );
                          }
                        ),
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
                        bottom: 40,
                        right: _moveAnimation.value,
                        child: AnimatedBuilder(
                            animation: _searchSlideSideAnimationController,
                            builder: (BuildContext context, Widget? child) {
                            return Container(
                              height:60,
                              width:60+((screenWidth-100)*_searchSlideSideAnimation.value),
                              decoration: BoxDecoration(
                                color: MyColors.appAccentColor,
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(70), // Shadow color
                                    spreadRadius:1, // How much the shadow should spread
                                    blurRadius:5, // How blurry the shadow should be
                                    offset: const Offset(4, 4), // Offset of the shadow from the container
                                  ),
                                ]
                              ),
                              child:
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Visibility(
                                        visible: _isSideSearchBarOpen ? true : false,
                                        child: MySearchTextBox(onTap:(){}, isFloatBtn:true)
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(5, 2, 6, 0),
                                      child: InkWell(child: Icon(_isSideSearchBarOpen ? Icons.close : Icons.search, size: 30),
                                        onTap:(){
                                          if(_isSideSearchBarOpen) {
                                            _searchSlideSideAnimationController.reverse();
                                          }else{
                                            _searchSlideSideAnimationController.forward();
                                          }
                                          _isSideSearchBarOpen = !_isSideSearchBarOpen;
                                          FocusScope.of(context).unfocus();
                                        },
                                      )
                                    )
                                  ],
                                ),
                              )
                            );
                          }
                        )
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