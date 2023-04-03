import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class MyAppbar extends StatelessWidget {
  String? appbarTitle;
  List<Widget>? actions;
  PreferredSizeWidget? bottom;
  MyAppbar({super.key, this.appbarTitle, this.actions, this.bottom});

  @override
  Widget build(BuildContext context) {
    return NewGradientAppBar(
      gradient: LinearGradient(
          colors: [Color.fromARGB(255, 1, 101, 183), Colors.lightBlue]),
      automaticallyImplyLeading: false,
      elevation: 0,
      centerTitle: false,
      title: Text(
        '$appbarTitle',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      actions: actions,
      bottom: bottom,
    );
  }
}
