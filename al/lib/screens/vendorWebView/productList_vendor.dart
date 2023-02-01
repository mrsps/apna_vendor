import 'package:al/dao/productStore.dart';
import 'package:al/models/category/category.dart';
import 'package:al/models/product/product.dart';
import 'package:al/screens/vendorWebView/productCard_list.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  // List of products of a specific category
  final Category category;
  const ProductList({Key? key, required this.category}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<List<Product>>(
        stream: ProductStore().products(widget.category.userId!, widget.category.categoryId!),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> products) {
          if (products.hasError) {
            print(products.error);
          }
          if (products.connectionState == ConnectionState.waiting) {}
          if (products.data == null) {
            return Container();
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
                style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
              ),
              children: [
                if (products.data!.length != 0)
                  GridView.builder(
                    addAutomaticKeepAlives: true,
                    padding: EdgeInsets.all(5),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      childAspectRatio: 11 / 5,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemCount: products.data!.length,
                    itemBuilder: (context, productIndex) {
                      return ProductCardVendor(product: products.data![productIndex]);
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

  @override
  bool get wantKeepAlive => true;
}
