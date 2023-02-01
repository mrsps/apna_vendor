import 'package:al/providers/orderManagement.dart';
import 'package:al/screens/leaderWebView/vendorList_leader.dart';
import 'package:al/screens/orderScreen/orderPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notificationDialog.dart';

class LeaderVendorWebView extends StatefulWidget {
  // Leader view for a specific linked vendor and leader
  final String leaderId;
  final String vendorId;
  const LeaderVendorWebView({Key? key, required this.leaderId, required this.vendorId}) : super(key: key);

  @override
  _LeaderVendorWebViewState createState() => _LeaderVendorWebViewState();
}

class _LeaderVendorWebViewState extends State<LeaderVendorWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        shadowColor: Colors.black,
        elevation: 20,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text(
              'Catalogue',
              style: TextStyle(color: Colors.white, letterSpacing: 2),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: IconButton(
                onPressed: () async {
                  bool? x = await showDialog(
                      context: context,
                      builder: (context) => NotificationDialog(
                        leaderId: widget.leaderId,
                      ));
                  if (x != null)
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.blueGrey,
                        content: (Text(
                          'Successfully Subscribed !!',
                          textAlign: TextAlign.center,
                        ))));
                },
                icon: Icon(Icons.notifications),
                hoverColor: Colors.blue.withOpacity(0.3),
                splashRadius: 20,
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue.shade200)),
              onPressed: () {
                if (Provider.of<OrderManager>(context, listen: false).products.length != 0)
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPage()));
              },
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Icon(Icons.shopping_cart),
                    Text(
                      ' : ' + Provider.of<OrderManager>(context).products.length.toString() + ' items',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(5),
          child: VendorList(vendorId: widget.vendorId),
        ),
      ),
    );
  }
}
