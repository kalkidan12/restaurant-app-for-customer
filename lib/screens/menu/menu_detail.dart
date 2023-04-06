import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:restaurantappforcustomer/screens/cart/cart_page.dart';
import 'package:restaurantappforcustomer/screens/menu/menu_list.dart';

class MenuDetail extends StatefulWidget {
  const MenuDetail({super.key});

  @override
  State<MenuDetail> createState() => _MenuDetailState();
}

class _MenuDetailState extends State<MenuDetail> {
  TextEditingController priceController =
      TextEditingController(text: 1.toString());
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
              '1',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(width: 10),
            Text(
              'View Cart',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
            Text(
              '\$555',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MenuList()));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color.fromARGB(255, 37, 37, 37),
            )),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 65, 65, 65),
                    borderRadius: BorderRadius.circular(10)),
                width: MediaQuery.of(context).size.width - 50,
                height: 220,
                child: Image.asset(
                  'assets/images/menu5.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Burger & Chips',
                    style: TextStyle(
                        fontSize: 24, color: Color.fromARGB(255, 76, 76, 76)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                        onPressed: () {
                          print('added to fovorite');
                        },
                        icon: const Icon(
                          Icons.favorite,
                          color: Color.fromARGB(255, 171, 171, 171),
                          size: 35,
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Description here Description Description here Description here Description here here Description here Description here Description here Description here',
                style: TextStyle(
                    color: Color.fromARGB(255, 97, 97, 97), fontSize: 18),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 207, 240, 255)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          width: 40,
                          height: 40,
                          child: TextFormField(
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: false,
                              signed: false,
                            ),
                            textAlign: TextAlign.center,
                            controller: priceController,
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 243, 243, 243),
                                border: InputBorder.none),
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
                  Row(
                    children: [
                      const Text(
                        '\$234',
                        style: TextStyle(
                            fontSize: 22,
                            color: Color.fromARGB(255, 56, 56, 56)),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 45,
                        child: ElevatedButton(
                            onPressed: () {}, child: Text('Add To Cart')),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
