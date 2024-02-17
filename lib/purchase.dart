import 'package:baboo_and_co/Widgets/TextField.dart';
import 'package:flutter/material.dart';

class PurchaseScreen extends StatefulWidget {
  String title;
  PurchaseScreen({super.key, required this.title});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

enum MillType { Sakrand, Bandhi, Khairpur, Ranipur }

class _PurchaseScreenState extends State<PurchaseScreen> {
  TextEditingController customerController = TextEditingController();
  MillType? millType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title}...'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Text(
                    '-- Available Tons --',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Ranipur',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Khairpur',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Bandhi',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Sakrand',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '204',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '138',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '129',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '194',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: MyTextInputText(
                      controller: customerController,
                      labelText: 'Dealer Name',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: MyTextInputText(
                              controller: customerController,
                              labelText: 'Tons',
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                        Expanded(
                          child: MyTextInputText(
                            controller: customerController,
                            labelText: 'Price',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: Text(MillType.Bandhi.name),
                          value: MillType.Bandhi,
                          groupValue: millType,
                          onChanged: (value) {
                            setState(() {
                              millType = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: Text(MillType.Sakrand.name),
                          value: MillType.Sakrand,
                          groupValue: millType,
                          onChanged: (value) {
                            setState(() {
                              millType = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: Text(MillType.Ranipur.name),
                          value: MillType.Ranipur,
                          groupValue: millType,
                          onChanged: (value) {
                            setState(() {
                              millType = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: Text(MillType.Khairpur.name),
                          value: MillType.Khairpur,
                          groupValue: millType,
                          onChanged: (value) {
                            setState(() {
                              millType = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Card(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 5,
                        margin: const EdgeInsets.all(10),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              'Place an Order',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
