import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:proven_wealth/Common/CommonText.dart';
import '../Api/doGetSupport.dart';
import '../Common/MyColors.dart';
import '../Common/MyStyles.dart';
import '../Models/SupportData.dart';

class Profile extends StatefulWidget {
  static const String id = "Profile";
  const Profile({super.key});

  @override
  Page createState() => Page();
}

class Page extends State<Profile> with TickerProviderStateMixin{
  double posX = 0;
  double posY = 0;
  late SupportData _supportData = SupportData(name: "", action: "");

  List<SupportData> supportDataList = [];

  List<SupportData> profileOptionList = [
    SupportData(name: "Manage Profile", action: "a"),
    SupportData(name: "Change Password", action: "b"),
    SupportData(name: "Switch Account", action: "c"),
    SupportData(name: "Manage News Topics", action: "n"),
    SupportData(name: "Logout", action: "d")
  ];

  late final AnimationController _animationController = AnimationController(duration: const Duration(milliseconds:250), vsync: this);
  late final Animation<double> _sizeAnimation = Tween(begin:0.0,end: 1.0).animate(_animationController);
  late final Animation<double> _locAnimation = Tween(begin:1.0,end: 0.0).animate(_animationController);
  late Animation<Color?> _colorAnimation = _colorAnimation = ColorTween(begin: MyColors.appAccentColor,end: MyColors.white).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

  @override
  initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    supportDataList = await DoGetSupport().call();
    setState(() { });
  }

  _onTapUp(TapUpDetails details, action) {
    _supportData = supportDataList.where((data) => data.action.contains(action)).first;
    posX = details.globalPosition.dx;
    posY = details.globalPosition.dy;
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;
    double safePaddingTop = MediaQuery.of(context).padding.top;

    return Scaffold(
        backgroundColor: MyColors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                color: MyColors.appAccentColor,
                width: screenWidth,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0,safePaddingTop+10,0,20),
                      child: Text('Profile', style: MyStyles.headerStyle1),
                    ),
                    CachedNetworkImage(
                        imageUrl: '',
                        progressIndicatorBuilder: (context, url, progress) => Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            backgroundColor: Colors.white,
                            value: progress.progress,
                            strokeWidth:2.0,
                          ),
                        ),
                        width:100,
                        height:100,
                        fit:BoxFit.cover,
                        alignment: Alignment.topCenter,
                        errorWidget: (context, url, error) => Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                            ),
                            child: Center(child: Text('SZ', style:TextStyle(fontWeight: FontWeight.bold, letterSpacing: 3, fontSize: 35) ))
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text('Sub Zero', style: MyStyles.headerStyle2),
                    ),
                    SizedBox(height:40)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 300, 0, 0),
                child: Column(
                  children: [
                    Container(
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
                        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Text("Manage", style:MyStyles.headerStyle3),
                            ),
                            for(var i=0; i<profileOptionList.length; i++)...[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 3),
                                child: MaterialButton(
                                  onPressed: () {  },
                                  color: (i==profileOptionList.length-1) ? MyColors.red : MyColors.blue,
                                  minWidth: screenWidth,
                                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0), // Adjust radius as needed
                                  ),
                                  child: Text(profileOptionList[i].name, style:TextStyle(color: MyColors.white)),
                                ),
                              )
                            ],
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Text("Support", style:MyStyles.headerStyle3),
                            ),
                            Container(
                                color: MyColors.white,
                                width: screenWidth,
                                child: Wrap(
                                  children: [
                                    for(var i=0; i<supportDataList.length; i++)...[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 0, 15, 15),
                                        child: GestureDetector(
                                          onTapUp: (TapUpDetails details) => _onTapUp(details, supportDataList[i].action),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: MyColors.appAccentColor,
                                              borderRadius: BorderRadius.circular(10.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withAlpha(120), // Shadow color
                                                    spreadRadius: 1, // Spread radius
                                                    blurRadius: 5, // Blur radius
                                                    offset: Offset(4, 4), // Offset (x, y)
                                                  ),
                                                ]
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                                              child: Text(supportDataList[i].name),
                                            ),
                                          ),
                                          // MaterialButton(
                                          //   onPressed:(){},
                                          //   color: MyColors.appAccentColor,
                                          //   elevation: 1,
                                          //   shape: RoundedRectangleBorder(
                                          //     borderRadius: BorderRadius.circular(10.0), // Adjust radius as needed
                                          //   ),
                                          //   child: Text(supportDataList[i].name),
                                          // ),
                                        ),
                                      )
                                    ]
                                  ],
                                )
                            ),
                            SizedBox(height: 20)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              AnimatedBuilder(
                animation: _animationController,
                builder: (BuildContext context, Widget? child) {
                  return
                    Positioned(
                      left:0,// posX * _locAnimation.value,
                      top:0,// (posY-50) * _locAnimation.value,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                        child: Container(
                          width: (screenWidth-18) * _sizeAnimation.value,
                          height: screenHeight * _sizeAnimation.value,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200 * _locAnimation.value),
                            color: _colorAnimation.value,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                SingleChildScrollView(
                                  child: HtmlWidget("<h2>${_supportData.title ?? 'error'}</h2>${_supportData.content ?? 'error'}<p>&nbsp;</p><p>&nbsp;</p>")
                                ),
                                Positioned(
                                  right:0,
                                  child: InkWell(
                                    onTap: (){
                                      _animationController.reverse();
                                    },
                                    child: Icon(Icons.close_fullscreen_sharp),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                }
              )
            ],
          ),
        )
    );
  }
}