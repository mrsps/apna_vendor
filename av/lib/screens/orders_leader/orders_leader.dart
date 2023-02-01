import 'package:av/dao/orderStore.dart';
import 'package:av/models/order/order.dart';
import 'package:av/providers/fireAuth.dart';
import 'package:av/providers/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:av/screens/orders_leader/orderCard_leader.dart';

class OrdersLeader extends StatefulWidget {
  const OrdersLeader({Key? key}) : super(key: key);

  @override
  _OrdersLeaderState createState() => _OrdersLeaderState();
}

class _OrdersLeaderState extends State<OrdersLeader> {
  @override
  Widget build(BuildContext context) {
    // Having order cards for each order linked to the leader
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        shadowColor: Colors.black,
        elevation: 20,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Orders',
              style: TextStyle(color: Colors.white, fontSize: 25, letterSpacing: 3),
            ),
          ],
        ),
        toolbarHeight: 50,
      ),
      body: StreamBuilder<List<Order>>(
          stream: OrderStore().ordersLeader(Provider.of<FireAuth>(context, listen: false).currentUserId),
          builder: (BuildContext context, AsyncSnapshot<List<Order>> orders) {
            if (orders.hasError) {
              throw (orders.error!);
            }
            if (orders.connectionState == ConnectionState.waiting) {
              return LoadingIndicator();
            }
            if (orders.data!.length == 0) {
              return Container(
                padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      size: 100,
                      color: Colors.blueGrey,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'No Orders',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2, fontSize: 30),
                      ),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
                padding: EdgeInsets.all(5),
                itemCount: orders.data!.length,
                itemBuilder: (context, orderIndex) {
                  return OrderLeaderCard(order: orders.data![orderIndex]);
                });
          }),
    );
  }
}