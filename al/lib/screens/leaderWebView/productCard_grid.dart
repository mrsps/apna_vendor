import 'package:al/dao/mediaStore.dart';
import 'package:al/models/product/product.dart';
import 'package:al/providers/orderManagement.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  // Product card of a specific product
  final Product product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    OrderManager orderManager = Provider.of<OrderManager>(context);
    super.build(context);
    return MaterialButton(
      minWidth: 0,
      padding: EdgeInsets.zero,
      color: orderManager.products.contains(widget.product) ? Colors.blue.shade100 : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: BorderSide(color: Colors.blueGrey)),
      hoverElevation: 20,
      hoverColor: Colors.blue.withOpacity(0.1),
      onPressed: () {
        if (orderManager.products.contains(widget.product))
          orderManager.deleteProduct(widget.product);
        else
          orderManager.addProduct(widget.product);
      },
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            children: [
              Row(
                children: [
                  StreamBuilder<String?>(
                      stream: MediaStore().getUrl(widget.product.productId!),
                      builder: (BuildContext context, AsyncSnapshot<String?> url) {
                        if (url.hasError) {
                          print(url.error);
                        }
                        return Container(
                          padding: EdgeInsets.all(5),
                          height: constraints.maxHeight,
                          width: constraints.maxHeight,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(15),
                                image: url.hasData ? DecorationImage(image: NetworkImage(url.data!)) : null,
                                border: Border.all(color: Colors.white, width: 2)),
                            child:
                            url.hasData
                                ? null
                                : Icon(
                                    Icons.photo,
                                    size: constraints.maxHeight / 2,
                                    color: Colors.white,
                                  ),
                          ),
                        );
                      }),
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
              ),
              if (orderManager.products.contains(widget.product))
                Positioned(
                  top: 2,
                  left: 2,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blueGrey,
                        border: Border.all(color: Colors.white, width: 2)),
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
