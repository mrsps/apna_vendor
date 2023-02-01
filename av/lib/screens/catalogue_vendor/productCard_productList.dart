import 'package:av/dao/mediaStore.dart';
import 'package:av/dao/orderStore.dart';
import 'package:av/dao/productStore.dart';
import 'package:av/models/product/product.dart';
import 'package:av/widgets/alertDialog.dart';
import 'package:av/widgets/snackBar.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  // Product card for a certain product
  final Product product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  height: constraints.maxWidth,
                  width: constraints.maxWidth,
                  child: StreamBuilder<String?>(
                      stream: MediaStore().getUrl(widget.product.productId!),
                      builder: (BuildContext context, AsyncSnapshot<String?> url) {
                        if (url.hasError) {
                          throw (url.error!);
                        }
                        if (url.connectionState == ConnectionState.waiting) {
                          return Container(
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                  color: Colors.blue,
                                ),
                              ));
                        }
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(15),
                              image: url.hasData ? DecorationImage(image: NetworkImage(url.data!)) : null,
                              border: Border.all(color: Colors.white, width: 2)),
                          child: url.hasData
                              ? null
                              : Icon(
                                  Icons.photo,
                                  size: constraints.maxWidth / 2,
                                  color: Colors.white,
                                ),
                        );
                      }),
                ),
                Spacer(),
                Text(
                  widget.product.productName!,
                  style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                Text(
                  '₹' +
                      widget.product.productPrice!.toStringAsFixed(0) +
                      ' / ' +
                      measureString(widget.product.productMeasure!),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                if (widget.product.productMinimumQuantity != 1)
                  Text(
                    'Min Qty: ' + widget.product.productMinimumQuantity!.toString(),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                Spacer()
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: InkWell(
                splashColor: Colors.red,
                borderRadius: BorderRadius.circular(5),
                onTap: () async {
                  bool orderExists =
                      await OrderStore().orderProductExists(widget.product.productId!, widget.product.userId!);
                  print(orderExists);
                  if (orderExists) {
                    showAlert('Cannot delete product which\nIs a part of an open order.', context);
                  } else {
                    showSnack('Product Deleted', context);
                    await ProductStore().deleteProduct(widget.product.productId!).then((value) => null);
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
