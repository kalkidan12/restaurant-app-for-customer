import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:restaurantappforcustomer/model/restaurant_list_model.dart';
import 'package:restaurantappforcustomer/screens/table/tables_page.dart';

import '../../api/config.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/darwer_widget.dart';
import '../scanner/scanner_page.dart';

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

      var response =
          await http.get(url, headers: {"Authorization": "JWT $access_token"});

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
        print(response.body);
        // There is already a profile with this account
        return [];
      }
    } catch (e) {
      print('CATCH> $e');
      return [];
    }
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QR_Scanner(),
            ),
          );
        },
        child: Icon(Icons.qr_code_scanner),
      ),
      drawer: const DrawerWidget(),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50.0), // here the desired height
        child: MyAppbar(),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(
              8 * screenWidth / 100, 20, 7 * screenWidth / 100, 0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                      hintText: 'Search Restaurants',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                      readJSon(_searchQuery);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
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
                  height: MediaQuery.of(context).size.height - 200,
                  child: FutureBuilder<List<Result>>(
                    future: readJSon(_searchQuery),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Result> restaurants = snapshot.data!;
                        return ListView.builder(
                            itemCount: restaurants.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 241, 241, 241),
                                  boxShadow: List.filled(
                                    3,
                                    const BoxShadow(
                                      blurRadius: 4,
                                      blurStyle: BlurStyle.outer,
                                      color: Colors.black12,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      color: const Color.fromARGB(
                                          255, 234, 234, 234),
                                      padding: const EdgeInsets.all(10),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(50),
                                        ),
                                        child: Image.asset(
                                          'assets/images/menu1.png',
                                          fit: BoxFit.contain,
                                          width: 80.0,
                                          height: 80.0,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 120,
                                      // width: MediaQuery.of(context).size.width - 174,
                                      padding: const EdgeInsets.only(left: 10),
                                      decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 243, 243, 243),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                restaurants[index].name,
                                                style: const TextStyle(
                                                    fontSize: 20.0,
                                                    color: Color(0xFF000000),
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Merriweather"),
                                              ),
                                              // SizedBox(height: 10,),
                                              SizedBox(
                                                width: 110,
                                                child: Text(
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
                                              ),
                                              Text(
                                                restaurants[index].phoneNumber,
                                                style: const TextStyle(
                                                    fontSize: 16.0,
                                                    color: Color(0xFF000000),
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Merriweather"),
                                              ),
                                            ],
                                          ),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: IconButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: ((context) =>
                                                          TablesList(
                                                              restaurantId:
                                                                  restaurants[
                                                                          index]
                                                                      .restaurantId)),
                                                    ),
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.arrow_circle_right,
                                                  color: Colors.blue[400],
                                                  size: 30,
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ],
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
          ]),
        ),
      ),
    );
  }
}
