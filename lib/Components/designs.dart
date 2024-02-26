import 'package:baboo_and_co/Components/functions.dart';
import 'package:baboo_and_co/details.dart';
import 'package:flutter/material.dart';

class MyAppDesigns {
  static title() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              'Party Name',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.transparent),
            ),
          ),
          Text(
            ':',
            style: TextStyle(color: Colors.transparent),
          ),
          Text(
            'BNDHI',
            style: TextStyle(fontSize: 17, color: Colors.red),
          ),
          Text(':'),
          Text(
            'KHRP',
            style: TextStyle(fontSize: 17, color: Colors.red),
          ),
          Text(':'),
          Text(
            'RNPR',
            style: TextStyle(fontSize: 17, color: Colors.red),
          ),
          Text(':'),
          Text(
            'SKRD',
            style: TextStyle(fontSize: 17, color: Colors.red),
          )
        ],
      ),
    );
  }

  static order(
      String dealer, bandhi, sakrand, khairpur, ranipur, BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: Column(
          children: [
            const Divider(
              color: Colors.black12,
            ),
            InkWell(
              onTap: () {
                MyAppComponents.goToPage(
                    context: context,
                    navigateTo: DetailsScreen(
                      title: '$dealer Details',
                      isCustomer: true,
                      isShop: false,
                    ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(
                      dealer,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  const Text(':'),
                  SizedBox(
                    width: 40,
                    child: Center(
                      child: Text(
                        bandhi,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Text(':'),
                  SizedBox(
                    width: 40,
                    child: Center(
                      child: Text(
                        khairpur,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Text(':'),
                  SizedBox(
                    width: 40,
                    child: Center(
                      child: Text(
                        ranipur,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Text(':'),
                  SizedBox(
                    width: 40,
                    child: Center(
                      child: Text(
                        sakrand,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  static total(String dealer, bandhi, sakrand, khairpur, ranipur) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    dealer,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                const Text(
                  ':',
                  style: TextStyle(color: Colors.transparent),
                ),
                SizedBox(
                  width: 40,
                  child: Center(
                    child: Text(
                      bandhi,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                ),
                const Text(':'),
                SizedBox(
                  width: 40,
                  child: Center(
                    child: Text(
                      khairpur,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                ),
                const Text(':'),
                SizedBox(
                  width: 40,
                  child: Center(
                    child: Text(
                      ranipur,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                ),
                const Text(':'),
                SizedBox(
                  width: 40,
                  child: Center(
                    child: Text(
                      sakrand,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  static detailsTitle(bool isShop) {
    return Row(
      children: [
        const Expanded(
          flex: 1,
          child: Center(
            child: Text(
              'Date',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          width: 1,
          height: 50,
          color: Colors.black,
          child: const SizedBox(child: Text('')),
        ),
        Expanded(
          flex: 3,
          child: Center(
            child: Text(
              isShop ? 'Customer' : 'Mill',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          width: 1,
          height: 50,
          color: Colors.black,
          child: const SizedBox(child: Text('')),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              isShop ? 'Bags' : 'Tons',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          width: 1,
          height: 50,
          color: Colors.black,
          child: const SizedBox(child: Text('')),
        ),
        Expanded(
          flex: 2,
          child: Center(
            child: Text(
              isShop ? 'Rate' : 'Due Rate',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          width: 1,
          height: 50,
          color: Colors.black,
          child: const SizedBox(child: Text('')),
        ),
        const Expanded(
          flex: 2,
          child: Center(
            child: Text(
              'Total',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  static detailsOrder(String date, mill, tons, due, total, bool isSold) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  date,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSold ? Colors.blue : Colors.red),
                ),
              ),
            ),
            Container(
              width: 1,
              height: 50,
              color: Colors.black,
              child: const SizedBox(child: Text('')),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  mill,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSold ? Colors.blue : Colors.red),
                ),
              ),
            ),
            Container(
              width: 1,
              height: 50,
              color: Colors.black,
              child: const SizedBox(child: Text('')),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  tons,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSold ? Colors.blue : Colors.red),
                ),
              ),
            ),
            Container(
              width: 1,
              height: 50,
              color: Colors.black,
              child: const SizedBox(child: Text('')),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  due,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSold ? Colors.blue : Colors.red),
                ),
              ),
            ),
            Container(
              width: 1,
              height: 50,
              color: Colors.black,
              child: const SizedBox(child: Text('')),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  total,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSold ? Colors.blue : Colors.red),
                ),
              ),
            ),
          ],
        ),
        Divider(
          height: 0,
          thickness: 1,
          color: Colors.black,
        ),
      ],
    );
  }
}
