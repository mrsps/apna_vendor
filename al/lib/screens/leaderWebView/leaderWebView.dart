import 'package:al/dao/userStore.dart';
import 'package:al/providers/fireNotify.dart';
import 'package:al/providers/orderManagement.dart';
import 'package:al/screens/leaderWebView/notificationDialog.dart';
import 'package:al/screens/leaderWebView/vendorList_leader.dart';
import 'package:al/screens/orderScreen/orderPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaderWebView extends StatefulWidget {
  // Leader web view of a specific leader
  final String leaderId;
  const LeaderWebView({Key? key, required this.leaderId}) : super(key: key);

  @override
  _LeaderWebViewState createState() => _LeaderWebViewState();
}

class _LeaderWebViewState extends State<LeaderWebView> {
  @override
  Widget build(BuildContext context) {
    Provider.of<FireNotify>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.blue.shade200,
        padding: EdgeInsets.all(5),
        child: StreamBuilder<List<String>>(
            stream: UserStore().vendors(widget.leaderId),
            builder: (BuildContext context, AsyncSnapshot<List<String>> vendors) {
              if (vendors.hasError) {
                print(vendors.error);
              }
              if (vendors.data == null) {
                return Container();
              }
              if (vendors.data!.length == 0) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Icon(
                          Icons.error,
                          size: 50,
                          color: Colors.blueGrey,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'No Vendors',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                      ],
                    ));
              }
              return ListView.builder(
                  addAutomaticKeepAlives: true,
                  padding: EdgeInsets.all(5),
                  itemCount: vendors.data!.length,
                  itemBuilder: (context, vendorIndex) {
                    return VendorList(vendorId: vendors.data![vendorIndex]);
                  });
            }),
      ),
    );
  }
}
