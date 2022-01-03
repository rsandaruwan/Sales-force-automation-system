import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sfasystem/ui/theme.dart';

class MyButton extends StatelessWidget {
  final String lable;
  final Function()? onTap;
  const MyButton({Key? key, required this.lable, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primaryClr,

        ),
        child: Text(
          lable,
          style: TextStyle(
            color:Colors.white,
          ),
        ),
      ),
    );
  }
}
