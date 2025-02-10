import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Common/MyColors.dart';
import '../../Common/MyStyles.dart';

class MySearchTextBox extends StatelessWidget
{
  final Function onTap;
  final bool isFloatBtn;
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? textInputFormatter;
  final IconData? prefixIcon;
  final double verticalHeight;
  final Color borderColor;
  final Function? onSubmitted;

  const MySearchTextBox({
      super.key,
      required this.onTap,
      this.isFloatBtn = false,
      this.textEditingController,
      this.focusNode,
      this.textInputAction,
      this.textInputFormatter,
      this.prefixIcon,
      this.verticalHeight=20.0,
      this.borderColor = const Color(0xFF1A1A1A),
      this.onSubmitted
    }
  );

  @override
  Widget build(BuildContext context){
    return
      TextField(
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        style: MyStyles.mediumTextStyle2,
        decoration: InputDecoration(
          filled: true, // Required to set fillColor
          fillColor: Colors.grey[200], // Background color
          contentPadding: EdgeInsets.symmetric(vertical:12, horizontal:15.0),
          border: isFloatBtn ?
          OutlineInputBorder(
            borderSide: BorderSide(width:1.0, color: MyColors.appAccentColor, style: BorderStyle.none),
            borderRadius: BorderRadius.circular(30.0), // Adjust radius as needed
          ) : InputBorder.none,
          hintText: 'Find news',
          hintStyle: MyStyles.mediumTextStyle1.copyWith(fontSize: 14),
          prefixIconConstraints:const BoxConstraints(minWidth: 0),
          prefixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
            child: Icon(Icons.search, size:16, color:MyColors.textBlk1),
          ),
          suffixIcon: isFloatBtn ? null :
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
            child: InkWell(
              child: Icon(Icons.close, size:16, color:MyColors.textBlk1),
              onTap:(){ onTap.call(); },
            )
          )
        ),
        onChanged: (String e){},
        onSubmitted:(String e){},
      );
  }
}

