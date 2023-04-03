import 'dart:convert';

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:restaurantappforcustomer/model/table_model.dart';
import 'package:restaurantappforcustomer/screens/menu/menu_page.dart';
import 'package:restaurantappforcustomer/screens/restaurant/restaurant_list.dart';

import '../../api/config.dart';

class BookTable extends StatefulWidget {
  TableModel table;
  final int restaurantId;
  BookTable({required this.table, required this.restaurantId});

  @override
  State<BookTable> createState() => _BookTableState();
}

class _BookTableState extends State<BookTable> {
  final GlobalKey<FormState> _tableFormKey = GlobalKey<FormState>();

  late int tableId;
  late int restaurantId;
  int no_of_peoples = 1;
  late int no_of_sits;
  DateTime booking_time_x = DateTime.now();
  DateTime booking_time_y = DateTime.now();
  bool isCancelled = false;
  int customerId = LocalStorage('customer').getItem('customer_id');

  @override
  void initState() {
    super.initState();
    tableId = widget.table.tableId;
    no_of_sits = widget.table.noOfSeats;
    restaurantId = widget.restaurantId;
  }

  void _submitForm() {
    if (no_of_peoples > no_of_sits || no_of_peoples < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text('The selected table has only $no_of_sits sits.')),
      );

      return;
    }
    if (DateTime.now().compareTo(booking_time_x) > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Please enter a valid date and time.')),
      );

      return;
    }

    if (DateTime.now().compareTo(booking_time_y) > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Please enter a valid date.')),
      );

      return;
    }

    if (booking_time_x.compareTo(booking_time_y) > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Please enter a valid date.')),
      );

      return;
    }

    final data = {
      "no_of_peoples": no_of_peoples.toString(),
      "booking_time_x": booking_time_x.toString(),
      "booking_time_y": booking_time_y.toString(),
      "isCancelled": isCancelled.toString(),
      "table": tableId.toString(),
      "restaurant": restaurantId.toString(),
      "customer": customerId.toString()
    };

    createBookTable(data);
  }

  Future<void> createBookTable(data) async {
    try {
      String access_token = LocalStorage('tokens').getItem('access');
      var url = Uri.parse('${ApiConstants.BASE_URL}${ApiConstants.BOOKTABLE}');
      final response = await http.post(
        url,
        headers: {"Authorization": "Bearer ${access_token}"},
        body: data,
      );
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.lightBlue,
              content: Text(
                  'Table ${jsonDecode(response.body)['tableId']} booked successfully!')),
        );
        int bookedId = jsonDecode(response.body)['booked_id'];
        // print(bookedId);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MenuPage(restaurantId: restaurantId, bookedTableId: bookedId),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.lightBlue,
              content: Text('Failed to create this table. Please try again!')),
        );
      }
    } catch (error) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.lightBlue,
              content: Text('Failed to create this table. Please try again!')),
        );
      });
      // debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: const Text(
          "Schedule Time",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _tableFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  initialValue: no_of_peoples.toString(),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 237, 237, 237),
                      prefixIcon: Icon(Icons.numbers),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      labelText: 'Number of peoples'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the number of peoples';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    no_of_peoples = int.parse(value!);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                DateTimeFormField(
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 237, 237, 237),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.black45),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    // border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.event_note),
                    labelText: 'Booked From',
                  ),
                  autovalidateMode: AutovalidateMode.always,
                  onDateSelected: (DateTime value) {
                    booking_time_x = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                DateTimeFormField(
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 237, 237, 237),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.black45),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    // border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.event_note),
                    labelText: 'To',
                  ),
                  autovalidateMode: AutovalidateMode.always,
                  onDateSelected: (DateTime value) {
                    booking_time_y = value;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: 135,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text(
                      'Book',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Merriweather"),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
