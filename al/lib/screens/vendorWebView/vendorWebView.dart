import 'package:al/dao/categoryStore.dart';
import 'package:al/models/category/category.dart';
import 'package:al/screens/vendorWebView/productList_vendor.dart';
import 'package:flutter/material.dart';

class VendorWebView extends StatefulWidget {
  // Vendor view of a specific vendor
  final String vendorId;
  const VendorWebView({Key? key, required this.vendorId}) : super(key: key);

  @override
  _VendorWebViewState createState() => _VendorWebViewState();
}

class _VendorWebViewState extends State<VendorWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        shadowColor: Colors.black,
        elevation: 20,
        leading: Container(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Vendor Products',
              style: TextStyle(color: Colors.white,letterSpacing: 2),
            ),
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.blue.shade200,
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<List<Category>>(
                  stream: CategoryStore().categories(widget.vendorId),
                  builder: (BuildContext context, AsyncSnapshot<List<Category>> categories) {
                    if (categories.hasError) {
                      print(categories.error);
                    }
                    if (categories.connectionState == ConnectionState.waiting) {}
                    if (categories.data == null) {
                      return Container();
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
                                color: Colors.black,
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
                          ));
                    else
                      return ListView.builder(
                        addAutomaticKeepAlives: true,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: categories.data!.length,
                        itemBuilder: (context, categoryIndex) {
                          return ProductList(category: categories.data![categoryIndex]);
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
