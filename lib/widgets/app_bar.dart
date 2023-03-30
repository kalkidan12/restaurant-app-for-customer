import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyAppbar extends StatelessWidget {
  String? appbarTitle;
  List<Widget>? actions;
  MyAppbar({super.key, this.appbarTitle, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.blue,
      elevation: 0,
      centerTitle: false,
      title: Text(
        '$appbarTitle',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      actions: actions,
    );
  }
}
