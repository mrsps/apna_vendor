import 'package:av/dao/orderFormStore.dart';
import 'package:av/models/orderform/orderform.dart';
import 'package:av/providers/fireAuth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderingSwitch extends StatefulWidget {
  const OrderingSwitch({Key? key}) : super(key: key);

  @override
  _OrderingSwitchState createState() => _OrderingSwitchState();
}

class _OrderingSwitchState extends State<OrderingSwitch> {
  // OrderSwitch handles the managing of orderForm states linked to the vendor

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OrderForm?>(
        stream: OrderFormStore().getOrderForm(Provider.of<FireAuth>(context).currentUserId),
        builder: (BuildContext context, AsyncSnapshot<OrderForm?> orderForm) {
          if (orderForm.hasError) {
            throw (orderForm.error!);
          }
          if (orderForm.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: const EdgeInsets.all(5),
              child: CircularProgressIndicator(
                color: Colors.white,
                backgroundColor: Colors.blue,
              ),
            );
          }
          return Switch(
              activeColor: Colors.white,
              inactiveThumbColor: Colors.white,
              activeTrackColor: Colors.green,
              inactiveTrackColor: Colors.red,
              value: orderForm.data == null
                  ? false
                  : (orderForm.data!.orderFormState == OrderFormState.INACTIVE ||
                          orderForm.data!.timestamp!.toDate().difference(DateTime.now()).isNegative
                      ? false
                      : true),
              onChanged: (value) async {
                if (value) {
                  int days = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        int value = 1;
                        return StatefulBuilder(builder: (context, dialogState) {
                          return AlertDialog(
                            insetPadding: EdgeInsets.zero,
                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                            titlePadding: EdgeInsets.all(10),
                            backgroundColor: Colors.blue.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            title: Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: Colors.white)),
                              child: Text(
                                'Ordering opened for:',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            content: Row(
                              children: [
                                Spacer(),
                                IconButton(
                                  onPressed: () {
                                    if (value != 1)
                                      dialogState(() {
                                        value--;
                                      });
                                  },
                                  iconSize: 20,
                                  color: Colors.blueGrey,
                                  icon: Icon(
                                    Icons.remove_circle,
                                  ),
                                ),
                                Text(
                                  value.toString(),
                                  style:
                                      TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, letterSpacing: 2),
                                  textAlign: TextAlign.center,
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (value != 20)
                                      dialogState(() {
                                        value++;
                                      });
                                  },
                                  iconSize: 20,
                                  color: Colors.blueGrey,
                                  icon: Icon(
                                    Icons.add_circle,
                                  ),
                                ),
                                Text(
                                  'Days   ',
                                  style: TextStyle(color: Colors.blueGrey),
                                ),
                                Spacer()
                              ],
                            ),
                            actions: [
                              Center(
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade300),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ))),
                                  onPressed: () {
                                    Navigator.pop(context, value);
                                  },
                                  child: Text('Ok'),
                                ),
                              )
                            ],
                          );
                        });
                      });
                  // var functions = FirebaseFunctions.instance;
                  // functions.useFunctionsEmulator('localhost', 5001);
                  FirebaseFunctions.instance.httpsCallable('vendorOpen').call(
                    <String, dynamic>{
                      "vendorId": Provider.of<FireAuth>(context, listen: false).currentUserId,
                      "days": days,
                    },
                  );
                  await OrderFormStore().createOrderForm(Provider.of<FireAuth>(context, listen: false).currentUserId,
                      Timestamp.fromDate(DateTime.now().add(Duration(days: days))));
                } else
                  OrderFormStore().deleteOrderForm(orderForm.data!);
                setState(() {});
              });
        });
  }
}
