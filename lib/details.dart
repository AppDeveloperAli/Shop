// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:baboo_and_co/Components/designs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailsScreen extends StatefulWidget {
  String title;
  bool isShop, isCustomer;

  DetailsScreen(
      {super.key,
      required this.title,
      required this.isShop,
      required this.isCustomer});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.black,
            ),
            MyAppDesigns.detailsTitle(),
            Divider(
              height: 0,
              thickness: 1,
              color: Colors.black,
            ),
            MyAppDesigns.detailsOrder(
                '23/02', 'Zubair', '30', '12340', '1978000', false),
            MyAppDesigns.detailsOrder(
                '21/02', 'Anwar Munawar', '15', '12340', '1978720', true),
            MyAppDesigns.detailsOrder(
                '20/02', 'Tahir Bhiria', '25', '12340', '1978450', true),
            MyAppDesigns.detailsOrder(
                '19/02', 'Malik Rashid', '35', '12340', '1978170', false),
            MyAppDesigns.detailsOrder(
                '17/02', 'Ashrad Daur', '50', '12340', '1978000', true),
            MyAppDesigns.detailsOrder(
                '16/02', 'Anwar Munawar', '10', '12340', '1878040', false),
            MyAppDesigns.detailsOrder(
                '15/02', 'Yaar Muhammad', '45', '12340', '1878720', false),
            MyAppDesigns.detailsOrder(
                '14/02', 'Deewan Das', '12', '12340', '1671860', true),
            MyAppDesigns.detailsOrder(
                '12/02', 'Mool Chand', '15', '12340', '1978000', true),
            Divider(
              height: 0,
              thickness: 1,
              color: Colors.black,
            ),
            widget.isCustomer
                ? Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '-- Khairpur --',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      MyAppDesigns.detailsTitle(),
                      const Divider(
                        height: 0,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      MyAppDesigns.detailsOrder('20/02', 'Anwar Munawar', '25',
                          '12340', '1978450', true),
                      MyAppDesigns.detailsOrder(
                          '19/02', 'Zubair', '35', '12340', '1978170', false),
                      MyAppDesigns.detailsOrder('17/02', 'Malik Rashid', '50',
                          '12340', '1978000', true),
                      MyAppDesigns.detailsOrder('16/02', 'Yaar Muhammad', '10',
                          '12340', '1878040', false),
                      MyAppDesigns.detailsOrder('15/02', 'Yaar Muhammad', '45',
                          '12340', '1878720', false),
                      const Divider(
                        height: 0,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '-- Bandhi --',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      MyAppDesigns.detailsTitle(),
                      const Divider(
                        height: 0,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      MyAppDesigns.detailsOrder('20/02', 'Shehroz Bhiria', '25',
                          '12340', '1978450', true),
                      MyAppDesigns.detailsOrder(
                          '19/02', 'Zubair', '35', '12340', '1978170', false),
                      MyAppDesigns.detailsOrder(
                          '17/02', 'Nirsumal', '50', '12340', '1978000', true),
                      MyAppDesigns.detailsOrder('16/02', 'Anwar Munawar', '10',
                          '12340', '1878040', false),
                      MyAppDesigns.detailsOrder('15/02', 'Yaar Muhammad', '45',
                          '12340', '1878720', false),
                      const Divider(
                        height: 0,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '-- Sakrand --',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      MyAppDesigns.detailsTitle(),
                      const Divider(
                        height: 0,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      MyAppDesigns.detailsOrder('20/02', 'Yaar Muhammad', '25',
                          '12340', '1978450', true),
                      MyAppDesigns.detailsOrder('19/02', 'Shehroz Bhiria', '35',
                          '12340', '1978170', false),
                      MyAppDesigns.detailsOrder('17/02', 'Hashim Brother', '50',
                          '12340', '1978000', true),
                      MyAppDesigns.detailsOrder('16/02', 'Sheroz Bhiria', '10',
                          '12340', '1878040', false),
                      MyAppDesigns.detailsOrder('15/02', 'Ashraf Daur', '45',
                          '12340', '1878720', false),
                    ],
                  )
                : Container()
          ],
        ),
      )),
    );
  }
}
