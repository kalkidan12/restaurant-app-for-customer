import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:restaurantappforcustomer/model/table_model.dart';
import 'package:restaurantappforcustomer/screens/table/book_table.dart';
import 'package:restaurantappforcustomer/widgets/darwer_widget.dart';

import '../../api/config.dart';
import '../../widgets/app_bar.dart';

class TablesList extends StatefulWidget {
  final int restaurantId;
  TablesList({required this.restaurantId});

  @override
  State<TablesList> createState() => _TablesListState();
}

class _TablesListState extends State<TablesList> {
  bool _isLoading = false;
  late int restaurantId;

  @override
  void initState() {
    super.initState();
    setState(() {
      restaurantId = widget.restaurantId;
    });
    print('Restaurant ID: ${restaurantId}');
  }

  Future<List<TableModel>> readJSon() async {
    try {
      String access_token = LocalStorage('tokens').getItem('access');
      var url = Uri.parse(
          '${ApiConstants.BASE_URL}${ApiConstants.TABLES}?restaurant=${widget.restaurantId}&isBooked=false');
      var response = await http
          .get(url, headers: {"Authorization": "Bearer " + access_token});
      if (response.statusCode == 200) {
        List mapedData = json.decode(response.body) as List<dynamic>;
        List<TableModel> tables =
            mapedData.map((table) => TableModel.fromJson(table)).toList();
        // print(tables);
        return tables;
      } else {
        // There is already a profile with this account
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // drawer: const DrawerWidget(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0), // here the desired height
        child: MyAppbar(
          appbarTitle: 'Tables',
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(
            8 * screenWidth / 100, 20, 7 * screenWidth / 100, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: const [
          //     Text(
          //       "Available Tables",
          //       style: TextStyle(
          //           fontSize: 28.0,
          //           color: Color(0xFF000000),
          //           fontWeight: FontWeight.w300,
          //           fontFamily: "Merriweather"),
          //     ),
          //   ],
          // ),
          // const Divider(
          //   color: Colors.black87,
          // ),
          const SizedBox(height: 10),
          RefreshIndicator(
            onRefresh: () async {
              if (!_isLoading) {
                // check if an API request is not already in progress
                setState(() {
                  _isLoading =
                      true; // set the flag to true before starting the API request
                });
                await readJSon();
                setState(() {
                  _isLoading =
                      false; // set the flag to false after the API request is completed
                });
              }
            },
            child: Container(
                height: MediaQuery.of(context).size.height - 200,
                child: FutureBuilder<List<TableModel>>(
                  future: readJSon(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<TableModel> tables = snapshot.data!;
                      return ListView.builder(
                          itemCount: tables.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 241, 241, 241),
                                boxShadow: List.filled(
                                  3,
                                  const BoxShadow(
                                    blurRadius: 4,
                                    blurStyle: BlurStyle.outer,
                                    color: Color.fromARGB(31, 185, 185, 185),
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    color: Color.fromARGB(255, 234, 234, 234),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50)),
                                      child: Image.asset(
                                        "assets/images/table.jpg",
                                        fit: BoxFit.fill,
                                        width: 100.0,
                                        height: 100.0,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 120,
                                      padding: const EdgeInsets.only(left: 10),
                                      decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 243, 243, 243),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "Table #${index + 1}",
                                                      style: const TextStyle(
                                                          fontSize: 20.0,
                                                          color:
                                                              Color(0xFF000000),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              "Merriweather"),
                                                    ),
                                                    // SizedBox(height: 10,),
                                                    SizedBox(
                                                      width: 110,
                                                      child: Row(
                                                        children: [
                                                          const Expanded(
                                                            child: Text(
                                                              "Number of sits: ",
                                                              softWrap: true,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                  color: Color(
                                                                      0xFF000000),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      "Merriweather"),
                                                            ),
                                                          ),
                                                          Text(
                                                            "${tables[index].noOfSeats}",
                                                            softWrap: true,
                                                            style: const TextStyle(
                                                                fontSize: 20.0,
                                                                color: Color(
                                                                    0xFF000000),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontFamily:
                                                                    "Merriweather"),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: IconButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            BookTable(
                                                          table: tables[index],
                                                          restaurantId:
                                                              restaurantId,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  icon: const Icon(
                                                    Icons.book_rounded,
                                                    color: Colors.lightBlue,
                                                    size: 30.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "\$${tables[index].price}",
                                                  style: const TextStyle(
                                                      fontSize: 20.0,
                                                      color: Color(0xFF000000),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily:
                                                          "Merriweather"),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "VIP",
                                                style: TextStyle(
                                                    decoration: tables[index]
                                                            .isVip
                                                        ? TextDecoration.none
                                                        : TextDecoration
                                                            .lineThrough,
                                                    fontSize: 16.0,
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "Merriweather"),
                                              ),
                                              const SizedBox(
                                                width: 7,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  !tables[index].isBooked
                                                      ? "Available"
                                                      : "Unavailable",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color:
                                                          tables[index].isBooked
                                                              ? Colors.red
                                                              : Colors.green,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily:
                                                          "Merriweather"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
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
    );
  }
}
