import 'package:av/dao/mediaStore.dart';
import 'package:av/dao/productStore.dart';
import 'package:av/models/category/category.dart';
import 'package:av/models/product/product.dart';
import 'package:flutter/material.dart';

class ProductListLeader extends StatefulWidget {
  // Product grid view for a certain category
  final Category category;
  const ProductListLeader({Key? key, required this.category}) : super(key: key);

  @override
  _ProductListLeaderState createState() => _ProductListLeaderState();
}

class _ProductListLeaderState extends State<ProductListLeader> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
        stream: ProductStore().products(widget.category.userId!, widget.category.categoryId!),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> products) {
          if (products.hasError) {
            print(products.error);
          }
          if (products.connectionState == ConnectionState.waiting) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  color: Colors.blueGrey,
                ),
              ),
            );
          }
          return Container(
            margin: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.blueGrey)),
            child: ExpansionTile(
              textColor: Colors.blue,
              iconColor: Colors.blue,
              collapsedTextColor: Colors.black,
              collapsedIconColor: Colors.black,
              leading: Icon(Icons.adjust),
              title: Text(
                widget.category.categoryName!,
                style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 3),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              children: [
                if (products.data!.length != 0)
                  GridView.builder(
                    padding: EdgeInsets.all(5),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 3 / 5, crossAxisSpacing: 5, mainAxisSpacing: 5, crossAxisCount: 3),
                    itemCount: products.data!.length,
                    itemBuilder: (context, productIndex) {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.blueGrey)),
                        child: LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints) {
                            return Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  height: constraints.maxWidth,
                                  width: constraints.maxWidth,
                                  child: StreamBuilder<String?>(
                                      stream: MediaStore().getUrl(products.data![productIndex].productId!),
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
                                            border: Border.all(color: Colors.white, width: 2),
                                          ),
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
                                  products.data![productIndex].productName!,
                                  style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Spacer(),
                                Text(
                                  '₹' +
                                      products.data![productIndex].productPrice!.toStringAsFixed(0) +
                                      ' / ' +
                                      measureString(products.data![productIndex].productMeasure!),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Spacer(),
                                if (products.data![productIndex].productMinimumQuantity != 1)
                                  Text(
                                    'Min Qty: ' + products.data![productIndex].productMinimumQuantity.toString(),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                Spacer(),
                              ],
                            );
                          },
                        ),
                      );
                    },
                  ),
                if (products.data!.length == 0)
                  Text(
                    'No Products in this Category',
                    style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, letterSpacing: 2),
                  ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          );
        });
  }
}
