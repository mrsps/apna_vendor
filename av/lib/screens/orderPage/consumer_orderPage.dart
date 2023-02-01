import 'package:av/dao/consumerStore.dart';
import 'package:av/models/consumer/consumer.dart';
import 'package:flutter/material.dart';

class ConsumerOrderPage extends StatefulWidget {
  // Details of consumer linked to the order
  final String consumerId;
  const ConsumerOrderPage({Key? key, required this.consumerId}) : super(key: key);

  @override
  _ConsumerOrderPageState createState() => _ConsumerOrderPageState();
}

class _ConsumerOrderPageState extends State<ConsumerOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.blueGrey)),
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      child: FutureBuilder<ConsumerAddress?>(
          future: ConsumerStore().getConsumer(widget.consumerId),
          builder: (BuildContext context, AsyncSnapshot<ConsumerAddress?> consumerAddress) {
            if (consumerAddress.hasError) {
              throw (consumerAddress.error!);
            }
            if (consumerAddress.connectionState == ConnectionState.waiting) {
              return Container(
                width: 150,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: LinearProgressIndicator(),
              );
            }
            if (consumerAddress.data == null) return Container();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(color: Colors.blueGrey, borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Consumer Details',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(text: 'Name: ', style: TextStyle(color: Colors.blueGrey, fontSize: 18)),
                    TextSpan(
                        text: ' ' + consumerAddress.data!.consumerName!,
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey, fontSize: 18)),
                  ]),
                ),
                SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(text: 'Phone No.: ', style: TextStyle(color: Colors.blueGrey, fontSize: 18)),
                    TextSpan(
                        text: ' ' + consumerAddress.data!.consumerPhone!,
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey, fontSize: 18)),
                  ]),
                ),
                SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(text: 'House No.: ', style: TextStyle(color: Colors.blueGrey, fontSize: 18)),
                    TextSpan(
                        text: ' ' + consumerAddress.data!.consumerHouse!,
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey, fontSize: 18)),
                  ]),
                ),
                SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(text: 'Apartment: ', style: TextStyle(color: Colors.blueGrey, fontSize: 18)),
                    TextSpan(
                        text: ' ' + consumerAddress.data!.consumerApartment!,
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey, fontSize: 18)),
                  ]),
                ),
              ],
            );
          }),
    );
  }
}