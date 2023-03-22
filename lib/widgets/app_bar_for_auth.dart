import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyAppbarForAuthPage extends StatelessWidget {
  const MyAppbarForAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: const Text(
        "OrderSupreme | Customer",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
