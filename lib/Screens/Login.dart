import 'dart:async';
import 'package:flutter/material.dart';
import 'package:proven_wealth/Screens/AccountHome.dart';
import 'package:proven_wealth/Screens/Register.dart';
import '../Api/doLogin.dart';
import '../Common/Common.dart';
import '../Common/CommonText.dart';
import '../Common/MyColors.dart';
import '../Common/MyStyles.dart';
import '../Models/SplashScreen.dart';
import '../Services/service_locator.dart';
import 'Templates/AppBar.dart';
import 'Templates/MyFormIconTextBox.dart';
import 'Templates/MyFormPasswordBox.dart';
import 'Templates/MyPostButton.dart';

class Login extends StatefulWidget {
  static const String id = "Login";
  const Login({super.key});

  @override
  _Page createState() => _Page();
}

class _Page extends State<Login> with TickerProviderStateMixin
{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final AnimationController _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: getIt<SplashScreen>().action=='logout' ?  0 : 250));
  late final Animation<double> _logoAnimation = Tween(begin:0.0, end:125.0).animate(_animationController)..addListener(() { });
  late final Animation<double> _transAnimation = Tween(begin:1.0, end:0.0).animate(_animationController)..addListener(() { });
  late final Animation<double> _transReversAnimation = Tween(begin:0.0, end:1.0).animate(_animationController)..addListener(() { });

  late StreamController<String> emailStreamController;
  TextEditingController emailController = TextEditingController();
  late StreamController<String> recoverEmailStreamController;
  TextEditingController recoverEmailController = TextEditingController();

  bool hidePassword = true;
  bool enablePostBtn = false;
  bool _showLogin = true;
  String _email = '';
  String _recoverEmail = '';
  String _password = '';
  String splashScreenPath = '';

  @override
  void initState() {
    super.initState();
    emailStreamController = StreamController<String>.broadcast();
    recoverEmailStreamController = StreamController<String>.broadcast();

    emailController.addListener(() {
      emailStreamController.sink.add(emailController.text.trim());
    });

    recoverEmailController.addListener(() {
      recoverEmailStreamController.sink.add(recoverEmailController.text.trim());
    });

    Future.delayed(Duration(milliseconds: getIt<SplashScreen>().action=='logout' ?  0 : 2000), () {
        setState(() {
          _animationController.forward();
        });
      }
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    emailController.dispose();
    emailStreamController.close();
  }

  sendResetLink() async {
    //setState(() { _isLoading = true; });
    FocusScope.of(context).unfocus();
    try {
      final rs = await DoLogin().sendResetEmail(_recoverEmail.trim());
      if (!mounted) return;
      if(rs.success){
        Common().displayPopUp(context, rs.message);
        //Navigator.of(context).push(RouteSlider(page: ResetPassword(email: _recoverEmail.trim()), dir: Direction().ZERO ));
      }else{
        Common().displayPopUp(context, rs.message, true);
      }
    }catch(e){
      Common().displayPopUp(context, '$e', true);
    }finally{
      //setState(() { _isLoading = false; });
    }
  }




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;
    double safePaddingTop = MediaQuery.of(context).padding.top;
    double screenTopHeight = screenHeight/4.0;
    return Scaffold(
      endDrawer: MyAppBar().getDrawer(),
      body: CustomScrollView(
          //physics: const BouncingScrollPhysics(),
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
              // actions: <Widget>[
              //   IconButton(
              //     icon: const Icon(Icons.menu, color: MyColors.white),
              //     tooltip: 'Open side menu',
              //     onPressed: () {
              //       debugPrint('Clicked');
              //       _scaffoldKey.currentState?.openDrawer();
              //     },
              //   ),
              // ]
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((BuildContext context, int index)
              {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(30, 60, 30, 0),
                  child: Column(
                    children: [
                      // ClipRRect(
                      //   borderRadius: const BorderRadius.only(
                      //     bottomRight: Radius.circular(70.0), // Adjust the radius as needed
                      //   ),
                      //   child: Image.asset('lib/assets/images/img3.jpg', fit: BoxFit.cover,)
                      // ),
                      MyFormIconTextBox(hintText: 'Enter your email address', prefixIcon:Icons.email,  textInputType: TextInputType.emailAddress, onChanged:(){}),
                      MyFormPasswordBox(hintText: 'Enter your password', hidePassword: true, onChanged:(){}, iconTap: () {  }),
                      SizedBox(height:50),
                      MyPostButton(text: 'Login', colorStyle:0, onPressed: () {
                        Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => const AccountHome()),);
                        }
                      ),
                      SizedBox(height:50),
                      Column(
                        children: [
                          InkWell(
                            child: Text('Open Account', style: TextStyle(fontSize:14, color: Colors.black, fontWeight:FontWeight.bold)),
                            onTap: (){
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const Register()),
                              );
                            },
                          ),
                          SizedBox(height:10),
                          Text('Forget Password?', style: TextStyle(fontSize:14, color: Colors.black, fontWeight:FontWeight.bold)),
                          //Checkbox(value: true, onChanged:(newValue){}),
                          //Text('Remember Me?', style: TextStyle(fontSize:14, color: Colors.black, fontWeight:FontWeight.bold)),
                        ],
                      ),
                      // MyPostButton(text: 'Open an Account', colorStyle:3, onPressed: () {
                      //   Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => const Register()),
                      //   );
                      // })
                    ],
                  ),
                );
              },
              childCount: 1,
              ),
            )
          ]
      ),
    );
    // return Scaffold(
    //   backgroundColor: MyColors.appBackGroundColor,
    //   appBar: MyAppBar().getAppBar('', context, null),
    //   endDrawer: MyAppBar().getDrawer(),
    //   body: SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         Container(
    //           color: MyColors.appAccentColor,
    //           width: screenWidth,
    //           height: screenTopHeight + 20,
    //           child: Padding(
    //             padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
    //             child: Image.asset(
    //               'lib/assets/images/img3.jpg',
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //         ),
    //         Padding(
    //           padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
    //           child: Container(
    //             width: screenWidth,
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.only(
    //                 topRight: Radius.circular(CommonText.borderRadius),
    //               ),
    //               boxShadow: [
    //                 BoxShadow(
    //                   color: Colors.black.withAlpha(50), // Shadow color
    //                   spreadRadius: 1, // How much the shadow should spread
    //                   blurRadius: 5, // How blurry the shadow should be
    //                   offset: const Offset(1, -7), // Offset of the shadow from the container
    //                 ),
    //               ],
    //               color: MyColors.white,
    //             ),
    //             child: Padding(
    //               padding: const EdgeInsets.fromLTRB(30, 25, 30, 0),
    //               child: Column(
    //                 children: [
    //                   Text('Login', style: MyStyles.newsHeaderStyle1),
    //                   SizedBox(height:35,),
    //                   MyFormIconTextBox(hintText: 'Enter your email address', prefixIcon:Icons.email,  textInputType: TextInputType.emailAddress, onChanged:(){}),
    //                   MyFormPasswordBox(hintText: 'Enter your password', hidePassword: true, onChanged:(){}, iconTap: () {  }),
    //                   SizedBox(height:20),
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.end,
    //                     children: [
    //                       Text('Forget Password?', style: TextStyle(fontSize:14, color: Colors.black, fontWeight:FontWeight.bold)),
    //                       //Checkbox(value: true, onChanged:(newValue){}),
    //                       //Text('Remember Me?', style: TextStyle(fontSize:14, color: Colors.black, fontWeight:FontWeight.bold)),
    //                     ],
    //                   ),
    //                   SizedBox(height:30),
    //                   MyPostButton(text: 'Login', colorStyle:0, onPressed: () {
    //                     Navigator.pushReplacement(context,
    //
    //                       MaterialPageRoute(builder: (context) => const AccountHome()),);
    //                     }
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                       children: [
    //                         Container(
    //                           height: 1,
    //                           width: (screenWidth-60)/2.5,// Line thickness
    //                           color: Colors.grey, // Line color
    //                         ),
    //                         Padding(
    //                           padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
    //                           child: Text('or', style: TextStyle(fontSize:14, color: Colors.black, fontWeight:FontWeight.w400)),
    //                         ),
    //                         Container(
    //                           height: 1,
    //                           width: (screenWidth-60)/2.5,// Line thickness
    //                           color: Colors.grey, // Line color
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   MyPostButton(text: 'Open an Account', colorStyle:3, onPressed: () {
    //                     Navigator.push(context,
    //                       MaterialPageRoute(builder: (context) => const Register()),
    //                     );
    //                   }),
    //                   //SizedBox(height: 350,),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   )
    // );
  }
}