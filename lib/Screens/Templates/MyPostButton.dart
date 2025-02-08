import 'package:flutter/material.dart';
import '../../Common/MyColors.dart';


class MyPostButton extends StatelessWidget
{
  final String text;
  final VoidCallback onPressed;
  final bool disabled;
  final int colorStyle;
  final double bottomPadding;
  final bool icon;

  const MyPostButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.disabled=false,
    this.colorStyle=0,
    this.bottomPadding=15,
    this.icon=false
  });

  @override
  Widget build(BuildContext context)
  {
    Color? textColor;
    Color borderColor = Colors.black;
    Color? buttonBgColor;
    Color? buttonColorDisabled;

    if(colorStyle==0){
      textColor = MyColors.white;
      buttonBgColor = MyColors.appAccentColor;;
      borderColor = MyColors.appAccentColor;;
      buttonColorDisabled = Colors.grey;
    }else if(colorStyle==1){
      textColor = Colors.white;
      buttonBgColor = Colors.black;
      borderColor = Colors.white;
      buttonColorDisabled = const Color(0xFFe7ebf3);
    }else if(colorStyle==2){
      textColor = Colors.black;
      buttonBgColor = const Color(0xFFFFFFFF);
      borderColor = Colors.black;
      buttonColorDisabled = const Color(0xFFFFFFFF);
    }else if(colorStyle==3){
      textColor = const Color(0xFFF5F5F5);
      buttonBgColor = const Color(0xFFBF2F2F);
      borderColor = const Color(0xFFBF2F2F);
      buttonColorDisabled = const Color(0xFFBF2F2F);
    }else if(colorStyle==4){
      textColor = Colors.white;
      buttonBgColor = const Color(0xFF22292F);
      borderColor = Colors.white;
      buttonColorDisabled = MyColors.red;
    }else if(colorStyle==5){
      textColor = const Color(0xFFD0D0D0);
      buttonBgColor = const Color(0xFF22292F);
      borderColor = const Color(0xFFD0D0D0);
      buttonColorDisabled = MyColors.red;
    }

    return
    SizedBox(
      height:48,
      width:double.infinity,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), // Adjust radius as needed
        ),
        color: buttonBgColor,
        onPressed: () {
          disabled ? null : onPressed.call();
        },
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text, style:TextStyle(color: MyColors.white, fontSize: 17)),
            ],
          ),
        )
      ),
    );
  }
}

