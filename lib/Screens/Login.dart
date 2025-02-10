import 'dart:async';
import 'package:flutter/material.dart';
import 'package:proven_wealth/Screens/AccountHome.dart';
import 'package:proven_wealth/Screens/Register.dart';
import '../Api/doLogin.dart';
import '../Common/Common.dart';
import '../Common/MyColors.dart';
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
  late final AnimationController _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: getIt<SplashScreen>().action=='logout' ?  0 : 250));
  late final Animation<double> _logoAnimation = Tween(begin:0.0, end:125.0).animate(_animationController)..addListener(() { });
  late final Animation<double> _transAnimation = Tween(begin:1.0, end:0.0).animate(_animationController)..addListener(() { });
  late final Animation<double> _transReversAnimation = Tween(begin:0.0, end:1.0).animate(_animationController)..addListener(() { });

  late StreamController<String> emailStreamController;
  TextEditingController emailController = TextEditingController();
  late StreamController<String> recoverEmailStreamController;
  TextEditingController recoverEmailController = TextEditingController();

  bool _checkValue = false;
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
        slivers: <Widget>[
          MyAppBar().getSliverAppBar(screenHeight),
          SliverList(
            delegate: SliverChildBuilderDelegate((BuildContext context, int index)
            {
              return Padding(
                padding: const EdgeInsets.fromLTRB(30, 60, 30, 0),
                child: Column(
                  children: [
                    MyFormIconTextBox(hintText: 'Enter your email address', prefixIcon:Icons.email,  textInputType: TextInputType.emailAddress, onChanged:(){}),
                    MyFormPasswordBox(hintText: 'Enter your password', hidePassword: hidePassword, onChanged:(){}, iconTap: () {
                      setState(() { hidePassword = !hidePassword; });
                    }),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _checkValue=!_checkValue;
                        });
                      },
                      child: Row(
                        children: [
                          Checkbox(
                            value: _checkValue,
                            onChanged: (bool? newCheckValue) {
                              setState(() {
                                _checkValue=!_checkValue;
                              });
                            },
                          ),
                          Text(
                            'Remember me!',
                            style: TextStyle(fontSize:14, color: _checkValue ? Colors.blue : Colors.grey, fontWeight:FontWeight.bold)
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height:20),
                    MyPostButton(text: 'Login', colorStyle:0, onPressed: () {
                      Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const AccountHome()),);
                      }
                    ),
                    SizedBox(height:50),
                    Column(
                      children: [
                        InkWell(
                          child: Text('Open Account', style: TextStyle(fontSize:14, color: Colors.grey, fontWeight:FontWeight.bold)),
                          onTap: (){
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const Register()),
                            );
                          },
                        ),
                        SizedBox(height:10),
                        Text('Forget Password?', style: TextStyle(fontSize:14, color: Colors.grey, fontWeight:FontWeight.bold)),
                      ],
                    ),
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
  }
}