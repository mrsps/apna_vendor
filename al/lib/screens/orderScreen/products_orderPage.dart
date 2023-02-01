import 'package:al/models/product/product.dart';
import 'package:al/providers/orderManagement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsOrder extends StatefulWidget {
  const ProductsOrder({Key? key}) : super(key: key);

  @override
  _ProductsOrderState createState() => _ProductsOrderState();
}

class _ProductsOrderState extends State<ProductsOrder> {
  // Main products list with quantities and price and total price
  @override
  Widget build(BuildContext context) {
    OrderManager orderManager = Provider.of<OrderManager>(context);
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        ListTile(
          leading: Container(
            width: 120,
            alignment: Alignment.centerLeft,
            child: Text('Product Name',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2)),
          ),
          trailing: Container(
            width: 170,
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
                  width: 75,
                  child: Text(
                    'Price',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: Colors.white,
          thickness: 2,
        ),
        ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blueGrey)),
                  child: MediaQuery.of(context).size.width > 400
                      ? ListTile(
                          leading: Text(
                            (index + 1).toString() + '.  ' + orderManager.products[index].productName!,
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Container(
                            width: 275,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 100,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          orderManager.decrement(orderManager.products[index]);
                                        },
                                        iconSize: 20,
                                        color: orderManager.quantities[orderManager.products[index].productId!] ==
                                                orderManager.products[index].productMinimumQuantity
                                            ? Colors.blueGrey.shade200
                                            : Colors.blueGrey,
                                        icon: Icon(
                                          Icons.remove_circle,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          orderManager.quantities[orderManager.products[index].productId!].toString(),
                                          style: TextStyle(color: Colors.blueGrey, letterSpacing: 2),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          orderManager.increment(orderManager.products[index]);
                                        },
                                        iconSize: 20,
                                        color: Colors.blueGrey,
                                        icon: Icon(
                                          Icons.add_circle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 80,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            'X',
                                            style: TextStyle(color: Colors.blue, letterSpacing: 2),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        measureString(orderManager.products[index].productMeasure!),
                                        style: TextStyle(color: Colors.blueGrey, letterSpacing: 2),
                                        textAlign: TextAlign.end,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                  child: Text(
                                    ':',
                                    style: TextStyle(color: Colors.blueGrey, letterSpacing: 2),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  width: 75,
                                  child: Text(
                                    '₹' +
                                        (orderManager.products[index].productPrice! *
                                                orderManager.quantities[orderManager.products[index].productId!]!)
                                            .toStringAsFixed(1),
                                    style: TextStyle(color: Colors.blueGrey, letterSpacing: 2),
                                    textAlign: TextAlign.start,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                (index + 1).toString() + '.  ' + orderManager.products[index].productName!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 100,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            orderManager.decrement(orderManager.products[index]);
                                          },
                                          iconSize: 20,
                                          color: orderManager.quantities[orderManager.products[index].productId!] ==
                                                  orderManager.products[index].productMinimumQuantity
                                              ? Colors.blueGrey.shade200
                                              : Colors.blueGrey,
                                          icon: Icon(
                                            Icons.remove_circle,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            orderManager.quantities[orderManager.products[index].productId!].toString(),
                                            style: TextStyle(color: Colors.blueGrey, letterSpacing: 2),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            orderManager.increment(orderManager.products[index]);
                                          },
                                          iconSize: 20,
                                          color: Colors.blueGrey,
                                          icon: Icon(
                                            Icons.add_circle,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 80,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              'X',
                                              style: TextStyle(color: Colors.blue, letterSpacing: 2),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          measureString(orderManager.products[index].productMeasure!),
                                          style: TextStyle(color: Colors.blueGrey, letterSpacing: 2),
                                          textAlign: TextAlign.end,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                    child: Text(
                                      ':',
                                      style: TextStyle(color: Colors.blueGrey, letterSpacing: 2),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 75,
                                    child: Text(
                                      '₹' +
                                          (orderManager.products[index].productPrice! *
                                                  orderManager.quantities[orderManager.products[index].productId!]!)
                                              .toStringAsFixed(1),
                                      style: TextStyle(color: Colors.blueGrey, letterSpacing: 2),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                ),
            separatorBuilder: (context, index) => Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
            itemCount: orderManager.products.length),
        Divider(
          color: Colors.white,
          thickness: 2,
        ),
        ListTile(
          trailing: Container(
            width: 170,
            alignment: Alignment.centerLeft,
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
                SizedBox(
                  width: 75,
                  child: Text(
                    '₹' + orderManager.total.toStringAsFixed(1),
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
