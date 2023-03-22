import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  final int bTableId;
  final List<int> dish;
  OrderPage({required this.bTableId, required this.dish});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
