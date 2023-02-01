import 'package:av/dao/productStore.dart';
import 'package:av/models/order/order.dart';
import 'package:av/screens/orderPage/consumer_orderPage.dart';
import 'package:av/screens/orderPage/pruducts_orderPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  // Order for which details needed to be shown
  final Order order;
  const OrderPage({Key? key, required this.order}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        shadowColor: Colors.black,
        elevation: 0,
        title: Text(
          'Order Details',
          style: TextStyle(color: Colors.white, fontSize: 25, letterSpacing: 3),
        ),
        toolbarHeight: 50,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                children: [
                  Container(
                    child: Text(
                      'Product Name',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2),
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 175,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 75,
                          child: Text(
                            'Quantity',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                          child: Text(
                            ':',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          child: Text(
                            'Price',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.white,
              thickness: 2,
            ),
            if (widget.order.products != null) ProductsOrderPage(order: widget.order),
            Divider(
              color: Colors.white,
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 190,
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 75,
                        child: Text(
                          'Total',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                        child: Text(
                          ':',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      FutureBuilder<double?>(
                          future: ProductStore().getCartSum(widget.order.products!),
                          builder: (BuildContext context, AsyncSnapshot<double?> sum) {
                            if (sum.hasError) {
                              throw (sum.error!);
                            }
                            if (sum.connectionState == ConnectionState.waiting) {
                              return Container(
                                width: 85,
                                padding: EdgeInsets.all(10),
                                child: LinearProgressIndicator(),
                              );
                            }
                            if (sum.data == null) return Container();
                            return SizedBox(
                              width: 80,
                              child: Text(
                                '₹' + sum.data!.toStringAsFixed(1),
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2),
                                textAlign: TextAlign.start,
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 2,
              color: Colors.blueGrey,
            ),
            ConsumerOrderPage(consumerId: widget.order.consumerId!)
          ],
        ),
      ),
    );
  }
}
