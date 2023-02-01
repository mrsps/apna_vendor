import 'package:al/dao/mediaStore.dart';
import 'package:al/models/product/product.dart';
import 'package:flutter/material.dart';

class ProductCardVendor extends StatefulWidget {
  // Widget card of a specific product
  final Product product;
  const ProductCardVendor({Key? key, required this.product}) : super(key: key);

  @override
  _ProductCardVendorState createState() => _ProductCardVendorState();
}

class _ProductCardVendorState extends State<ProductCardVendor> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<String?>(
        stream: MediaStore().getUrl(widget.product.productId!),
        builder: (BuildContext context, AsyncSnapshot<String?> url) {
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.blueGrey),
            ),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      height: constraints.maxHeight,
                      width: constraints.maxHeight,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(15),
                            image: url.hasData ? DecorationImage(image: NetworkImage(url.data!)) : null,
                            border: Border.all(color: Colors.white)),
                        child: url.hasData
                            ? null
                            : Icon(
                                Icons.photo,
                                size: constraints.maxHeight / 2,
                                color: Colors.white,
                              ),
                      ),
                    ),
                    Container(
                      width: 2,
                      height: constraints.maxHeight,
                      color: Colors.blueGrey,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.product.productName!,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '₹' +
                                  widget.product.productPrice!.toStringAsFixed(0) +
                                  ' / ' +
                                  measureString(widget.product.productMeasure!),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (widget.product.productMinimumQuantity != 1)
                              Text(
                                'Min Qty: ' + widget.product.productMinimumQuantity!.toString(),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
