import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../Common/MyColors.dart';
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
                  SliverAppBar(
                    iconTheme: const IconThemeData(color: Colors.white),
                    expandedHeight: screenHeight*.25,
                    //floating: false,
                    //snap:  false,
                    pinned: true,
                    stretch: true,
                    backgroundColor: MyColors.black,
                    flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                          color: MyColors.white,
                          child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(70.0), // Adjust the radius as needed
                              ),
                              child: Image.asset('lib/assets/images/img3.jpg',
                                  alignment: Alignment.bottomCenter,
                                  fit: BoxFit.fitWidth
                              )
                          ),
                        ),
                        title: Image.asset('lib/assets/images/logo.png', width: 120),
                        centerTitle: false,
                        titlePadding: EdgeInsets.fromLTRB(15, 0, 0, 5)
                    ),
                  ),
                  SliverList(
                      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                        return Text('Events');
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