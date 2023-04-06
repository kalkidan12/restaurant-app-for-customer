import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:restaurantappforcustomer/model/restaurant_list_model.dart';
import 'package:restaurantappforcustomer/screens/table/tables_page.dart';

import '../../api/config.dart';
import '../../widgets/app_bar.dart';
// import '../../widgets/darwer_widget.dart';
// import '../scanner/scanner_page.dart';

class RestaurantList extends StatefulWidget {
  const RestaurantList({super.key});

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  bool _isLoading = false;
  String _searchQuery = '';
  final searchController = TextEditingController();
  Future<List<Result>> readJSon(value) async {
    // if(value.toString().isEmpty)
    try {
      String access_token = LocalStorage('tokens').getItem('access');
      var url = Uri.parse(
          '${ApiConstants.BASE_URL}${ApiConstants.RESTAURANTS}?search=${value.toString()}');

      var response = await http
          .get(url, headers: {"Authorization": "Bearer $access_token"});

      if (response.statusCode == 200) {
        RestaurantModel mapedData =
            RestaurantModel.fromJson(jsonDecode(response.body));
        List<Result> restaurants = mapedData.results.toList();
        // print(restaurants);
        setState(() {
          _isLoading = true;
        });
        return restaurants;
      } else {
        // print(response.body);
        // There is already a profile with this account
        return [];
      }
    } catch (e) {
      print('CATCH> $e');
      return [];
    }
  }

  String _scanBarcode = '';

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      // print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  void initState() {
    super.initState();
    readJSon(_searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // floatingActionButton: Container(
      //   margin: EdgeInsets.only(bottom: 50),
      //   child: FloatingActionButton(
      //     backgroundColor: Color.fromARGB(255, 1, 101, 183),
      //     onPressed: () {},
      //     child: Icon(Icons.qr_code),
      //   ),
      // ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0.5,
        actions: [
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              child: TextFormField(
                // controller: nameController,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 240, 240, 240),
                  suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.clear,
                        color: Color.fromARGB(255, 1, 101, 183),
                      )),
                  prefixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 1, 101, 183),
                      )),
                  contentPadding: EdgeInsets.all(5),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(22)),
                  hintText: 'search restaurant',
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          RefreshIndicator(
            onRefresh: () async {
              if (!_isLoading) {
                // check if an API request is not already in progress
                setState(() {
                  _isLoading =
                      true; // set the flag to true before starting the API request
                });
                await readJSon(_searchQuery);
                setState(() {
                  _isLoading =
                      false; // set the flag to false after the API request is completed
                });
              }
            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder<List<Result>>(
                  future: readJSon(_searchQuery),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Result> restaurants = snapshot.data!;
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 20, bottom: 20),
                          itemCount: restaurants.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => TablesList(
                                        restaurantId:
                                            restaurants[index].restaurantId)),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 241, 241, 241),
                                  boxShadow: List.filled(
                                    3,
                                    const BoxShadow(
                                      blurRadius: 4,
                                      blurStyle: BlurStyle.outer,
                                      color: Color.fromARGB(31, 209, 209, 209),
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 110,
                                      color: const Color.fromARGB(
                                          255, 234, 234, 234),
                                      padding: const EdgeInsets.all(3),
                                      child: Image.asset(
                                        'assets/images/restaurant.jpeg',
                                        fit: BoxFit.cover,
                                        width: 100.0,
                                        height: 100.0,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 120,
                                        // width: MediaQuery.of(context).size.width - 174,
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 243, 243, 243),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              children: [
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                Text(
                                                  restaurants[index].name,
                                                  style: const TextStyle(
                                                      fontSize: 19.0,
                                                      color: Color(0xFF000000),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily:
                                                          "Merriweather"),
                                                ),
                                              ],
                                            ),
                                            // SizedBox(height: 10,),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.location_on,
                                                  color: Colors.lightBlue,
                                                  size: 20,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  restaurants[index].location,
                                                  softWrap: true,
                                                  style: const TextStyle(
                                                      fontSize: 15.0,
                                                      color: Color(0xFF000000),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily:
                                                          "Merriweather"),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.phone,
                                                  color: Colors.lightBlue,
                                                  size: 20,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  restaurants[index]
                                                      .phoneNumber,
                                                  style: const TextStyle(
                                                      fontSize: 16.0,
                                                      color: Color(0xFF000000),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily:
                                                          "Merriweather"),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Container(
                                    //     padding: const EdgeInsets.only(left: 2),
                                    //     child: IconButton(
                                    //       onPressed: () {
                                    //         Navigator.push(
                                    //           context,
                                    //           MaterialPageRoute(
                                    //             builder: ((context) =>
                                    //                 TablesList(
                                    //                     restaurantId:
                                    //                         restaurants[index]
                                    //                             .restaurantId)),
                                    //           ),
                                    //         );
                                    //       },
                                    //       icon: Icon(
                                    //         Icons.arrow_circle_right,
                                    //         color: Colors.lightblue,
                                    //         size: 30,
                                    //       ),
                                    //     ))
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      return Center(
                          child: Container(
                              width: 40,
                              height: 40,
                              child: const CircularProgressIndicator()));
                    }
                  },
                )),
          ),
          // Text('$_scanBarcode\n', style: TextStyle(fontSize: 20)),
          const SizedBox(
            height: 30,
          )
        ]),
      ),
    );
  }
}
