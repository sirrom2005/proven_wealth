import 'dart:async';
import 'package:flutter/material.dart';
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

class Register extends StatefulWidget {
  static const String id = "Register";
  const Register({super.key});

  @override
  _Page createState() => _Page();
}

class _Page extends State<Register> with TickerProviderStateMixin
{
  bool hidePassword = true;
  bool enablePostBtn = false;
  bool _showLogin = true;
  String _email = '';
  String _recoverEmail = '';
  String _password = '';
  String splashScreenPath = '';

  late StreamController<String> emailStreamController;
  TextEditingController emailController = TextEditingController();
  late StreamController<String> recoverEmailStreamController;
  TextEditingController recoverEmailController = TextEditingController();

  late final AnimationController _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: getIt<SplashScreen>().action=='logout' ?  0 : 250));
  late final Animation<double> _logoAnimation = Tween(begin:0.0, end:125.0).animate(_animationController)..addListener(() { });
  late final Animation<double> _transAnimation = Tween(begin:1.0, end:0.0).animate(_animationController)..addListener(() { });
  late final Animation<double> _transReversAnimation = Tween(begin:0.0, end:1.0).animate(_animationController)..addListener(() { });

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
    double screenTopHeight = screenHeight/3.4;

    return Scaffold(
      appBar: MyAppBar().getAppBar('Register', context, null),
      backgroundColor: MyColors.white,
      body: Stack(
        children: [
          Container(
            color: MyColors.appAccentColor,
            width: screenWidth,
            height: screenTopHeight,
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Image.asset('lib/assets/images/logo.png', ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, screenTopHeight-25, 0, 0),
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
                  padding: const EdgeInsets.fromLTRB(30, 25, 30, 0),
                  child: Column(
                    children: [
                      Text('Create an Account', style: MyStyles.newsHeaderStyle1),
                      SizedBox(height:15),
                      MyFormIconTextBox(hintText: 'Enter your first name', prefixIcon:Icons.abc,  textInputType: TextInputType.text, onChanged:(){}),
                      MyFormIconTextBox(hintText: 'Enter your last name', prefixIcon:Icons.abc,  textInputType: TextInputType.text, onChanged:(){}),
                      MyFormIconTextBox(hintText: 'Enter your email address', prefixIcon:Icons.email,  textInputType: TextInputType.emailAddress, onChanged:(){}),
                      MyFormIconTextBox(hintText: 'Enter your mobile number', prefixIcon:Icons.phone,  textInputType: TextInputType.phone, onChanged:(){}),
                      MyFormIconTextBox(hintText: 'Enter your TRN number', prefixIcon:Icons.person,  textInputType: TextInputType.number, onChanged:(){}),
                      MyFormPasswordBox(hintText: 'Password', hidePassword: true, onChanged:(){}, iconTap: () {  },),
                      MyFormPasswordBox(hintText: 'Enter password again', hidePassword: true, onChanged:(){}, iconTap: () {  },),
                      SizedBox(height:35),
                      MyPostButton(text: 'Create Account', colorStyle:0, onPressed: () { print('fdgfd');  }),
                      SizedBox(height:40)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}