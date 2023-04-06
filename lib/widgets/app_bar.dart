import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class MyAppbar extends StatelessWidget {
  String? appbarTitle;
  List<Widget>? actions;
  Widget? leading;
  PreferredSizeWidget? bottom;
  MyAppbar(
      {super.key, this.appbarTitle, this.actions, this.bottom, this.leading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      elevation: 0.5,
      centerTitle: false,
      title: Text(
        '$appbarTitle',
        style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 47, 47, 47)),
      ),
      actions: actions,
      bottom: bottom,
    );
  }
}
