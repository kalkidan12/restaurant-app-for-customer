import 'package:flutter/material.dart';
import 'package:restaurantappforcustomer/screens/home/home_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.lightBlue,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CartPage()));
          },
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
          label: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                '4',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 10),
              Text(
                'Place Order',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              Text(
                '\$555',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          title: const Text('My Cart',
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 47, 47, 47))),
          leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color.fromARGB(255, 37, 37, 37),
              )),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
            child: Column(
              children: [
                Container(
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    scrollDirection: Axis.vertical,
                    itemCount: 4,
                    separatorBuilder: (_, __) => Container(
                      height: 12,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color.fromARGB(255, 250, 250, 250),
                          boxShadow: [
                            BoxShadow(
                                // color: Color.fromARGB(255, 240, 240, 240),
                                color: Color.fromARGB(255, 222, 222, 222),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(1, 1)),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Burger & Chips',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color:
                                              Color.fromARGB(255, 37, 37, 37)),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '\$556',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color:
                                              Color.fromARGB(255, 37, 37, 37)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color:
                                          Color.fromARGB(255, 207, 240, 255)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            print('decrement');
                                            setState(() {
                                              // priceController += 1;
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.remove_circle,
                                            color: Colors.lightBlue,
                                          )),
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(
                                          '1',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            print('increment');
                                          },
                                          icon: const Icon(
                                            Icons.add_box,
                                            color: Colors.lightBlue,
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                  )),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color.fromARGB(255, 237, 237, 237),
                    boxShadow: [
                      BoxShadow(
                          // color: Color.fromARGB(255, 240, 240, 240),
                          color: Color.fromARGB(255, 222, 222, 222),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(1, 1)),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Table Number',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 47, 47, 47))),
                      Text('Table #2',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 47, 47, 47)))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ));
  }
}
