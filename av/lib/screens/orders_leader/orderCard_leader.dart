import 'package:av/models/order/order.dart';
import 'package:av/dao/consumerStore.dart';
import 'package:av/dao/orderStore.dart';
import 'package:av/dao/userStore.dart';
import 'package:av/models/appuser/appuser.dart';
import 'package:av/models/consumer/consumer.dart';
import 'package:av/providers/loading.dart';
import 'package:av/screens/orderPage/orderPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderLeaderCard extends StatefulWidget {
  // Order for which details are to be shown
  final Order order;
  const OrderLeaderCard({Key? key, required this.order}) : super(key: key);

  @override
  _OrderLeaderCardState createState() => _OrderLeaderCardState();
}

class _OrderLeaderCardState extends State<OrderLeaderCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPage(order: widget.order)));
          },
          splashColor: Colors.blueGrey,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blueGrey),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<AppUser?>(
                    future: UserStore().getUser(widget.order.vendorId!),
                    builder: (BuildContext context, AsyncSnapshot<AppUser?> vendor) {
                      if (vendor.hasError) {
                        throw (vendor.error!);
                      }
                      if (vendor.connectionState == ConnectionState.waiting) {
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: LinearProgressIndicator(),
                        );
                      }
                      return RichText(
                        text: TextSpan(children: [
                          TextSpan(text: 'Vendor Name: ', style: TextStyle(color: Colors.black, fontSize: 18)),
                          TextSpan(
                              text: ' ' + vendor.data!.userName!,
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18)),
                        ]),
                      );
                    }),
                SizedBox(
                  height: 5,
                ),
                FutureBuilder<ConsumerAddress?>(
                    future: ConsumerStore().getConsumer(widget.order.consumerId!),
                    builder: (BuildContext context, AsyncSnapshot<ConsumerAddress?> consumerAddress) {
                      if (consumerAddress.hasError) {
                        throw (consumerAddress.error!);
                      }
                      if (consumerAddress.connectionState == ConnectionState.waiting) {
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: LinearProgressIndicator(),
                        );
                      }
                      return RichText(
                        text: TextSpan(children: [
                          TextSpan(text: 'Consumer Name: ', style: TextStyle(color: Colors.black, fontSize: 18)),
                          TextSpan(
                              text: ' ' + consumerAddress.data!.consumerName!,
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18)),
                        ]),
                      );
                    }),
                SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(text: 'Order Status: ', style: TextStyle(color: Colors.black, letterSpacing: 2)),
                    if (widget.order.orderState == OrderState.CREATED)
                      TextSpan(
                          text: 'Created',
                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, letterSpacing: 2)),
                    if (widget.order.orderState == OrderState.SHIPPED)
                      TextSpan(
                          text: 'Shipped',
                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, letterSpacing: 2)),
                    if (widget.order.orderState == OrderState.DELIVERED)
                      TextSpan(
                          text: 'Delivered',
                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, letterSpacing: 2)),
                    if (widget.order.orderState == OrderState.CANCELLED)
                      TextSpan(
                          text: 'Cancelled',
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, letterSpacing: 2)),
                  ]),
                ),
                SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(text: 'Payment Status: ', style: TextStyle(color: Colors.black, letterSpacing: 2)),
                    if (widget.order.paymentState == PaymentState.PENDING)
                      TextSpan(
                          text: 'Pending',
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, letterSpacing: 2)),
                    if (widget.order.paymentState == PaymentState.DONE)
                      TextSpan(
                          text: 'Done',
                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, letterSpacing: 2)),
                  ]),
                ),
                if (widget.order.orderState == OrderState.CREATED)
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: ElevatedButton(
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.lightBlue)),
                              onPressed: () async {
                                Provider.of<Loading>(context, listen: false).onLoading;
                                await OrderStore().setOrder(widget.order
                                    .copyWith(orderState: OrderState.SHIPPED, paymentState: PaymentState.DONE));
                                Provider.of<Loading>(context, listen: false).offLoading;
                              },
                              child: Provider.of<Loading>(context).isLoading
                                  ? LinearProgressIndicator(
                                      color: Colors.white,
                                      backgroundColor: Colors.blueGrey,
                                    )
                                  : Text('Confirm Payment')),
                        ),
                      ),
                      if (widget.order.paymentState == PaymentState.PENDING)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: ElevatedButton(
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                                onPressed: () async {
                                  Provider.of<Loading>(context, listen: false).onLoading;
                                  await OrderStore().setOrder(widget.order.copyWith(orderState: OrderState.CANCELLED));
                                  Provider.of<Loading>(context, listen: false).offLoading;
                                },
                                child: Provider.of<Loading>(context).isLoading
                                    ? LinearProgressIndicator(
                                        color: Colors.white,
                                        backgroundColor: Colors.blueGrey,
                                      )
                                    : Text('Cancel')),
                          ),
                        ),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
