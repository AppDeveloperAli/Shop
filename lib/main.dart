// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:baboo_and_co/Components/designs.dart';
import 'package:baboo_and_co/Components/functions.dart';
import 'package:baboo_and_co/details.dart';
import 'package:baboo_and_co/purchase.dart';
import 'package:baboo_and_co/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Baboo and Co.',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text('You want to ?'),
                    // content: Text('Do you really want to delete?'),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            MyAppComponents.goToPage(
                                context: context,
                                navigateTo: PurchaseScreen(title: 'Selling'));
                          },
                          child: Text('Selling')),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          MyAppComponents.goToPage(
                              context: context,
                              navigateTo: PurchaseScreen(title: 'Purchasing'));
                        },
                        child: Text('Buying'),
                      )
                    ],
                  );
                });
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/shopcard.jpeg'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          MyAppComponents.goToPage(
                              context: context,
                              navigateTo: DetailsScreen(
                                title: 'Mills Details',
                                isShop: false,
                                isCustomer: true,
                              ));
                        },
                        child: Row(
                          children: [
                            Text(
                              '24',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 50,
                                  fontWeight: FontWeight.w900),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 5),
                              child: Text(
                                'Tons Mills',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 1,
                    height: 50,
                    color: Colors.amber,
                    child: SizedBox(child: Text('')),
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          MyAppComponents.goToPage(
                              context: context,
                              navigateTo: DetailsScreen(
                                title: 'Shop Details',
                                isShop: true,
                                isCustomer: false,
                              ));
                        },
                        child: Row(
                          children: [
                            Text(
                              '37',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 50,
                                  fontWeight: FontWeight.w900),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 5),
                              child: Text(
                                'Tons Shop',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              MyAppDesigns.title(),
              MyAppDesigns.order(
                  'Dyal Das Munshi', '12', '43', '21', '32', context),
              MyAppDesigns.order(
                  'Yameen Malik', '12', '43', '21', '42', context),
              MyAppDesigns.order(
                  'Muhammad Yaar', '12', '43', '21', '13', context),
              MyAppDesigns.order(
                  'Tufail Brothers', '12', '43', '21', '42', context),
              MyAppDesigns.order(
                  'Hashim Goods', '12', '43', '21', '12', context),
              MyAppDesigns.order(
                  'Sabtan Kamboh', '12', '43', '21', '56', context),
              MyAppDesigns.order(
                  'Adnan Malik', '12', '43', '21', '95', context),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              MyAppDesigns.total('Total', '321', '467', '321', '234')
            ],
          ),
        ),
      ),
    );
  }
}
