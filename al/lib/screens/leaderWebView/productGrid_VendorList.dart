import 'package:al/dao/productStore.dart';
import 'package:al/models/category/category.dart';
import 'package:al/models/product/product.dart';
import 'package:al/screens/leaderWebView/productCard_grid.dart';
import 'package:flutter/material.dart';

class ProductGrid extends StatefulWidget {
  // Product grid which comes under a specific category
  final Category category;
  const ProductGrid({Key? key, required this.category}) : super(key: key);

  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<List<Product>>(
        stream: ProductStore().products(widget.category.userId!, widget.category.categoryId!),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> products) {
          if (products.hasError) {
            print(products.error);
          }
          if (products.data == null) {
            return Container();
          }
          return Container(
            margin: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.blueGrey.shade100,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.blueGrey)),
            child: ExpansionTile(
              maintainState: true,
              textColor: Colors.blue,
              iconColor: Colors.blue,
              collapsedTextColor: Colors.black,
              collapsedIconColor: Colors.black,
              leading: Icon(Icons.adjust),
              title: Text(
                widget.category.categoryName!,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              children: [
                if (products.data!.length != 0)
                  GridView.builder(
                    padding: EdgeInsets.all(5),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    addAutomaticKeepAlives: true,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      childAspectRatio: 11 / 5,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemCount: products.data!.length,
                    itemBuilder: (context, productIndex) {
                      return ProductCard(product: products.data![productIndex]);
                    },
                  ),
                if (products.data!.length == 0)
                  Text(
                    'No Products in this Category',
                    style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, letterSpacing: 2),
                  ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
