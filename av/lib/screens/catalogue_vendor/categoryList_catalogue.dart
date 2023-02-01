import 'package:av/dao/categoryStore.dart';
import 'package:av/models/category/category.dart';
import 'package:av/screens/catalogue_vendor/productListVendor_categoryList.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  // Showing all categories for a specific vendor
  final String vendorId;
  const CategoryList({Key? key,required this.vendorId}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Category>>(
        stream: CategoryStore().categories(widget.vendorId),
        builder: (BuildContext context, AsyncSnapshot<List<Category>> categories) {
          if (categories.hasError) {
            print(categories.error);
          }
          if (categories.connectionState == ConnectionState.waiting) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  color: Colors.blueGrey,
                ),
              ),
            );
          }
          if (categories.data!.length == 0)
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Icon(
                    Icons.error,
                    size: 100,
                    color: Colors.blueGrey,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'No Categories',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2, fontSize: 30),
                    ),
                  ),
                  Text(
                    "Lets start by adding\na Category",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 2,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            );
          else
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: categories.data!.length,
              itemBuilder: (context, categoryIndex) {
                return ProductListVendor(category: categories.data![categoryIndex]);
              },
            );
        });
  }
}
