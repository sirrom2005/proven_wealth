import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Common/MyColors.dart';
import '../../Common/MyStyles.dart';

class MyFormIconTextBox extends StatelessWidget
{
  final String hintText;
  final TextInputType textInputType;
  final Function onChanged;
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? textInputFormatter;
  final IconData? prefixIcon;
  final double verticalHeight;
  final bool isValid;
  final Color borderColor;
  final Function? onSubmitted;

  const MyFormIconTextBox({
      super.key,
      required this.hintText,
      required this.textInputType,
      required this.onChanged,
      this.textEditingController,
      this.focusNode,
      this.textInputAction,
      this.textInputFormatter,
      this.prefixIcon,
      this.verticalHeight=20.0,
      this.isValid = true,
      this.borderColor = const Color(0xFF1A1A1A),
      this.onSubmitted
    }
  );

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        StreamBuilder(
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  obscureText: false,
                  focusNode: focusNode,
                  controller: textEditingController,
                  keyboardType: textInputType,
                  textInputAction: textInputAction,
                  inputFormatters: textInputFormatter,
                  style: MyStyles.mediumTextStyle2,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical:verticalHeight, horizontal:15.0),
                    // enabledBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(color: isValid ? borderColor : MyColors.formError, width:1.0),
                    // ),
                    // focusedBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(color: isValid ? borderColor : MyColors.formError, width:1.0),
                    //   //borderRadius: const BorderRadius.all(Radius.circular(10.0))
                    // ),
                    // border: const OutlineInputBorder(
                    //   borderRadius: BorderRadius.all(Radius.circular(10.0))
                    // ),
                    hintText: hintText,
                    hintStyle: MyStyles.mediumTextStyle1.copyWith(fontSize: 14),
                    prefixIconConstraints:const BoxConstraints(minWidth: 0),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                      child: Icon(prefixIcon, size:16, color:MyColors.textBlk1),
                    )
                  ),
                  onChanged: (String e){
                    onChanged.call(e);
                  },
                  onSubmitted:(String e){
                    onSubmitted?.call(e);
                  },
                )
              ],
            );
          }, stream: null,
        ),
        const SizedBox(height:10)
      ],
    );
  }
}

