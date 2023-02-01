import 'package:av/dao/categoryStore.dart';
import 'package:av/models/category/category.dart';
import 'package:av/screens/vendorList_leader/productListLeader_catalogue.dart';
import 'package:flutter/material.dart';

class CatalogueVendorList extends StatefulWidget {
  // Catalogue of a specfic vendor
  final String vendorId;
  const CatalogueVendorList({Key? key, required this.vendorId}) : super(key: key);

  @override
  _CatalogueVendorListState createState() => _CatalogueVendorListState();
}

class _CatalogueVendorListState extends State<CatalogueVendorList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        shadowColor: Colors.black,
        elevation: 20,
        leading: null,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Vendor Products',
              style: TextStyle(color: Colors.white, fontSize: 25, letterSpacing: 3),
            ),
          ],
        ),
        toolbarHeight: 50,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.blue.shade200,
        padding: EdgeInsets.symmetric(vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<List<Category>>(
                  stream: CategoryStore().categories(widget.vendorId),
                  builder: (BuildContext context, AsyncSnapshot<List<Category>> categories) {
                    if (categories.hasError) {
                      print(categories.error);
                    }
                    if (categories.connectionState == ConnectionState.waiting) {
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
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
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2, fontSize: 30),
                              ),
                            ),
                            Text(
                              "Vendor has no products",
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
                          return ProductListLeader(category: categories.data![categoryIndex]);
                        },
                      );
                  }),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
