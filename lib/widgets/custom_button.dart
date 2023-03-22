import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  void Function()? onPressed;
  void Function(bool)? onHover;
  ButtonStyle? style;
  Widget? child;
  CustomButton({super.key, this.child, this.onPressed, this.onHover});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: widget.child,
      onPressed: widget.onPressed,
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Color.fromARGB(255, 216, 216, 216)),
          padding: MaterialStateProperty.all(EdgeInsets.all(10)),
          textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18))),
    );
  }
}
