import 'package:av/dao/orderFormStore.dart';
import 'package:av/dao/orderStore.dart';
import 'package:av/models/order/order.dart';
import 'package:av/models/orderform/orderform.dart';
import 'package:av/providers/fireAuth.dart';
import 'package:av/providers/loading.dart';
import 'package:av/screens/orders_vendor/ordering_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:av/screens/orders_vendor/orderCard_vendor.dart';

class OrdersVendor extends StatefulWidget {
  const OrdersVendor({Key? key}) : super(key: key);

  @override
  _OrdersVendorState createState() => _OrdersVendorState();
}

class _OrdersVendorState extends State<OrdersVendor> {
  @override
  Widget build(BuildContext context) {
    // Having order status and order cards for each order linked to the vendor
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        shadowColor: Colors.black,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ordering Status',
              style: TextStyle(color: Colors.white, fontSize: 25, letterSpacing: 3),
            ),
            OrderingSwitch()
          ],
        ),
        toolbarHeight: 50,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Material(
              color: Colors.blueGrey,
              elevation: 10,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blueGrey)),
                  child: StreamBuilder<OrderForm?>(
                      stream: OrderFormStore().getOrderForm(Provider.of<FireAuth>(context).currentUserId),
                      builder: (BuildContext context, AsyncSnapshot<OrderForm?> orderForm) {
                        if (orderForm.hasError) {
                          throw (orderForm.error!);
                        }
                        if (orderForm.connectionState == ConnectionState.waiting) {
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: LinearProgressIndicator(),
                          );
                        }
                        if (orderForm.data == null)
                          return Text(
                            'Closed for Orders',
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, letterSpacing: 2),
                          );

                        Duration timeLeft = orderForm.data!.timestamp!.toDate().difference(DateTime.now());

                        if (orderForm.data!.orderFormState == OrderFormState.INACTIVE || timeLeft.isNegative)
                          return Text(
                            'Closed for Orders',
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, letterSpacing: 2),
                          );
                        return Text(
                            'Open for Orders : ' +
                                (timeLeft.inDays > 0
                                    ? timeLeft.inDays.toString() + ' days left'
                                    : timeLeft.inHours.toString() + ' hours left'),
                            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, letterSpacing: 2));
                      })),
            ),
          ),
          Divider(color: Colors.white, thickness: 2),
          Expanded(
            child: StreamBuilder<List<Order>>(
                stream: OrderStore().ordersVendor(Provider.of<FireAuth>(context, listen: false).currentUserId),
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2, fontSize: 30),
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
                        return OrderVendorCard(order: orders.data![orderIndex]);
                      });
                }),
          ),
        ],
      ),
    );
  }
}
