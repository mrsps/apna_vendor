import 'package:av/dao/categoryStore.dart';
import 'package:av/dao/productStore.dart';
import 'package:av/models/category/category.dart';
import 'package:av/models/product/product.dart';
import 'package:av/screens/catalogue_vendor/productCard_productList.dart';
import 'package:av/widgets/alertDialog.dart';
import 'package:av/widgets/snackBar.dart';
import 'package:flutter/material.dart';
import 'addCategoryBottomSheet.dart';
import 'addProductBottomSheet.dart';

class ProductListVendor extends StatefulWidget {
  // Product grid view for a certain category
  final Category category;
  const ProductListVendor({Key? key, required this.category}) : super(key: key);

  @override
  _ProductListVendorState createState() => _ProductListVendorState();
}

class _ProductListVendorState extends State<ProductListVendor> {
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
              border: Border.all(color: Colors.blueGrey),
            ),
            child: ExpansionTile(
              textColor: Colors.blue,
              iconColor: Colors.blue,
              collapsedTextColor: Colors.black,
              collapsedIconColor: Colors.black,
              leading: Icon(Icons.adjust),
              title: Text(
                widget.category.categoryName!,
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
                      childAspectRatio: 3 / 5,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      crossAxisCount: 3,
                    ),
                    itemCount: products.data!.length,
                    itemBuilder: (context, productIndex) {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.blueGrey),
                        ),
                        child: ProductCard(
                          product: products.data![productIndex],
                        ),
                      );
                    },
                  ),
                if (products.data!.length == 0)
                  Text(
                    'Start by adding a product',
                    style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, letterSpacing: 2),
                  ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => ProductAdd(
                              categoryId: widget.category.categoryId!,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Text(
                            'Add Product',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => CategoryAddOrEdit(categoryId: widget.category.categoryId!),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Text(
                            'Edit Category',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.blueGrey),
                        ),
                        child: IconButton(
                          onPressed: () async {
                            bool productExists = await ProductStore().productExists(widget.category.categoryId!);
                            if (productExists) {
                              showAlert('Cannot delete category with products.', context);
                            } else {
                              showSnack('Category Deleted', context);
                              await CategoryStore().deleteCategory(widget.category);
                            }
                          },
                          iconSize: 30,
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
