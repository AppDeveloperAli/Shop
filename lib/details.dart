// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:baboo_and_co/Components/designs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsScreen extends StatefulWidget {
  final List<dynamic>? data;
  final String title;
  final bool isShop, isCustomer;

  DetailsScreen({
    Key? key,
    required this.title,
    required this.isShop,
    required this.isCustomer,
    required this.data,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String getFormattedDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDateTime = DateFormat('dd-MM').format(dateTime);
    return formattedDateTime;
  }

  List<dynamic> filterOrdersByDealerName(
      List<dynamic> allOrders, String dealerName) {
    return allOrders
        .where((order) => order['dealer_name'] == dealerName)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> allOrdersShop = [];
    if (widget.data != null && widget.data!.isNotEmpty) {
      for (var doc in widget.data!) {
        if (doc['orders'] != null) {
          List<dynamic> orders = doc['orders'];
          allOrdersShop.addAll(orders);
        }
      }
      allOrdersShop.sort((a, b) {
        final dateTimeA = DateTime.parse(a['dateTime']);
        final dateTimeB = DateTime.parse(b['dateTime']);
        return dateTimeB.compareTo(dateTimeA);
      });
    }

    List<dynamic> filteredOrders =
        filterOrdersByDealerName(widget.data!, widget.title);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.black,
                ),
                MyAppDesigns.detailsTitle(widget.isShop),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.black,
                ),
                filteredOrders.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          'No orders found for ${widget.title}',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: filteredOrders.length,
                        itemBuilder: (context, index) {
                          return MyAppDesigns.detailsOrder(
                            getFormattedDate(filteredOrders[index]['dateTime']),
                            filteredOrders[index]['dealer_name'],
                            filteredOrders[index]['tons'],
                            filteredOrders[index]['due_price'],
                            filteredOrders[index]['millType'],
                            filteredOrders[index]['orderType'] == 'Purchasing'
                                ? false
                                : true,
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
