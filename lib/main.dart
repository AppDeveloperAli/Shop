// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

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
      body: SafeArea(
        child: Column(
          children: [
            Image.asset('assets/shopcard.jpeg'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Row(
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
                            'Tons',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
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
                    Row(
                      children: [
                        Text(
                          '24',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 50,
                              fontWeight: FontWeight.w900),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 5),
                          child: Text(
                            'Tons',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Divider(
                color: Colors.black,
              ),
            ),
            title(),
            order('Dyal Das Munshi', '12', '43', '21'),
            order('Yameen Malik', '12', '43', '21'),
            order('Muhammad Yaar', '12', '43', '21'),
            order('Tufail Brothers', '12', '43', '21'),
            order('Hashim Goods', '12', '43', '21'),
            order('Sabtan Kamboh', '12', '43', '21'),
            order('Adnan Malik', '12', '43', '21'),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Divider(
                color: Colors.black,
              ),
            ),
            total('Total', '321', '467', '321')
          ],
        ),
      ),
    );
  }

  Widget order(String dealer, bandhi, sakrand, khairpur) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: Column(
          children: [
            Divider(
              color: Colors.black12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        dealer,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        bandhi,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ' :     $khairpur     : ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        sakrand,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget total(String dealer, bandhi, sakrand, khairpur) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        dealer,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        bandhi,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      Text('data'),
                      Text(
                        ' :     $khairpur     : ',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      Text(
                        sakrand,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget title() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  'Dyal Das Munshi',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text('Bandhi'), Text(' : Khairpur : '), Text('Sakrand')],
          ),
        ],
      ),
    );
  }
}
