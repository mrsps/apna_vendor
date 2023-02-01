import 'package:al/screens/orderScreen/consumer_products.dart';
import 'package:al/screens/orderScreen/products_orderPage.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  // Main order screen displaying all products anda associated quantities
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        shadowColor: Colors.black,
        elevation: 20,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Shopping Cart',
              style: TextStyle(color: Colors.white, letterSpacing: 2),
            ),
            Spacer(),
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue.shade200)),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ConsumerDetails()));
              },
              child: Text(
                'Proceed',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        toolbarHeight: 50,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.blue.shade200,
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(child: ProductsOrder()),
      ),
    );
  }
}
