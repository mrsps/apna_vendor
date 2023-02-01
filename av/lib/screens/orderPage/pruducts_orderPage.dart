import 'package:av/dao/productStore.dart';
import 'package:av/models/order/order.dart';
import 'package:av/models/product/product.dart';
import 'package:flutter/material.dart';

class ProductsOrderPage extends StatefulWidget {
  // Details of products linked to the order
  final Order order;
  const ProductsOrderPage({Key? key, required this.order}) : super(key: key);

  @override
  _ProductsOrderPageState createState() => _ProductsOrderPageState();
}

class _ProductsOrderPageState extends State<ProductsOrderPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blueGrey)),
              margin: EdgeInsets.symmetric(horizontal: 5),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: FutureBuilder<Product?>(
                  future: ProductStore().getProduct(widget.order.products!.entries.toList()[index].key),
                  builder: (BuildContext context, AsyncSnapshot<Product?> product) {
                    if (product.hasError) {
                      throw (product.error!);
                    }
                    if (product.connectionState == ConnectionState.waiting) {
                      return Container(
                        width: 150,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: LinearProgressIndicator(),
                      );
                    }
                    if (product.data == null) return Container();
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          (index + 1).toString() + '.  ' + product.data!.productName!,
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Spacer(),
                        SizedBox(
                          width: 175,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 80,
                                child: Row(
                                  children: [
                                    Text(
                                      widget.order.products!.entries.toList()[index].value.toString(),
                                      style: TextStyle(color: Colors.blueGrey, letterSpacing: 2),
                                      textAlign: TextAlign.end,
                                    ),
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
                                      'kg',
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
                                      (product.data!.productPrice! *
                                              widget.order.products!.entries.toList()[index].value)
                                          .toStringAsFixed(1),
                                  style: TextStyle(color: Colors.blueGrey, letterSpacing: 2),
                                  textAlign: TextAlign.start,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  }),
            ),
        separatorBuilder: (context, index) => Divider(
              color: Colors.white,
              thickness: 2,
            ),
        itemCount: widget.order.products!.values.length);
  }
}
