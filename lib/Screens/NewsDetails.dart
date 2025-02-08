
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:proven_wealth/Common/CommonText.dart';
import 'package:proven_wealth/Common/MyStyles.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../Api/doGetSupport.dart';
import '../Common/MyColors.dart';
import '../Models/SupportData.dart';

class NewsDetails extends StatefulWidget {
  static const String id = "NewsDetails";
  const NewsDetails({super.key});

  @override
  Page createState() => Page();
}

class Page extends State<NewsDetails> with TickerProviderStateMixin{
  late final AnimationController _animationController = AnimationController(duration: const Duration(milliseconds:250), vsync: this);
  late final Animation<double> _moveAnimation = Tween(begin:-75.0,end: 15.0).animate(_animationController);
  final ScrollController _scrollController = ScrollController();
  late final RefreshController _refreshController;

  double _scrollPosition = 0.0;
  bool _isFloatingButtonVisible = false;
  List<SupportData> supportDataList = [];

  @override
  initState() {
    super.initState();
    _fetchData();
    _scrollController.addListener(_handleScroll);
    _refreshController = RefreshController(initialRefresh: false);
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

  Future<void> _fetchData() async {
    supportDataList = await DoGetSupport().call();
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.black,
          foregroundColor: MyColors.white,
          title: const Text('News'),
          centerTitle: false,
        ),
        backgroundColor: MyColors.appBackGroundColor,
        body: LoadingOverlay(
          isLoading: false,
          progressIndicator: const CircularProgressIndicator(),
          child: SafeArea(
            child: Stack(
                children: [
                  Image.asset('lib/assets/images/news2.jpg', width: screenWidth),
                  SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 245, 0, 0),
                          child: Container(
                            width: screenWidth,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(CommonText.borderRadius),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(50), // Shadow color
                                  spreadRadius: 1, // How much the shadow should spread
                                  blurRadius: 5, // How blurry the shadow should be
                                  offset: const Offset(1, -7), // Offset of the shadow from the container
                                ),
                              ],
                              color: MyColors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: MyColors.appAccentColor,
                                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                          child: Text('Jun 12, 2025', style: MyStyles.headerStyle3),
                                        )
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.favorite, size: 29, color: MyColors.red),
                                          Icon(Icons.share, size: 29)
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Text('Big ship sailing on the ocean', style: MyStyles.newsHeaderStyle1,),
                                  SizedBox(height: 8),
                                  Text('Random text | more text | same text again'),
                                  SizedBox(height: 8),
                                  HtmlWidget(supportDataList[1].content ?? ''),
                                  SizedBox(height: 8),
                                  Image.asset('lib/assets/images/logo-for-white.png', width: screenWidth*.38),
                                ],
                              ),
                            )
                          ),
                        ),
                      ],
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
                          child: Icon(Icons.share)
                        ),
                      );
                    }
                  )
                ],
              ),
          ),
        )
    );
  }

}