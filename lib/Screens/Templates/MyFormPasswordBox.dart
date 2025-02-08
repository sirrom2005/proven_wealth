import 'package:flutter/material.dart';
import '../../Common/MyColors.dart';
import '../../Common/MyStyles.dart';

class MyFormPasswordBox extends StatelessWidget
{
  final String hintText;
  final Function onChanged;
  final bool hidePassword;
  final VoidCallback iconTap;
  final TextEditingController? textEditingController;
  final Color borderColor;
  final TextInputAction? textInputAction;

  const MyFormPasswordBox({Key? key,
    required this.hintText,
    required this.hidePassword,
    required this.onChanged,
    required this.iconTap,
    this.textEditingController,
    this.borderColor = const Color(0xFF1A1A1A),
    this.textInputAction
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
          builder: (context, snapshot) {
            return TextField(
              obscureText: hidePassword,
              controller: textEditingController,
              keyboardType:TextInputType.text,
              textInputAction: textInputAction,
              style: MyStyles.mediumTextStyle2,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical:20.0, horizontal:15.0),
                // enabledBorder: OutlineInputBorder(
                //   borderSide: BorderSide(color:borderColor, width:1.0)
                // ),
                hintText: hintText,
                hintStyle: MyStyles.mediumTextStyle1.copyWith(fontSize: 14),
                suffixIcon:IconButton(
                  icon: Icon(hidePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, size:18, color:MyColors.textBlk1),
                  onPressed: () => {
                    iconTap.call()
                  },
                ),
                prefixIcon: const Icon(Icons.lock_outlined, size:16, color:MyColors.textBlk1)
              ),
              onChanged: (String e){
                onChanged.call(e);
              }
            );
          }, stream: null,
        ),
        const SizedBox(height:10)
      ],
    );
  }
}

