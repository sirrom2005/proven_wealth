import 'package:flutter/material.dart';
import '../../Common/MyColors.dart';


class MyOutLineButton extends StatelessWidget
{
  final String text;
  final VoidCallback onPressed;

  const MyOutLineButton({
    super.key,
    required this.text,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context)
  {
    return
      OutlinedButton(
        child: SizedBox(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: MyColors.black,
            ),
          ),
        ),
        onPressed: () {
          onPressed.call();
        },
      );
  }
}

