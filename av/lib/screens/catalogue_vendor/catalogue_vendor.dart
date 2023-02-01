import 'package:av/helpers/dynamicLinks.dart';
import 'package:av/providers/fireAuth.dart';
import 'package:av/screens/catalogue_vendor/categoryList_catalogue.dart';
import 'package:av/screens/catalogue_vendor/addCategoryBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatalogueVendor extends StatefulWidget {
  const CatalogueVendor({Key? key}) : super(key: key);

  @override
  _CatalogueVendorState createState() => _CatalogueVendorState();
}

class _CatalogueVendorState extends State<CatalogueVendor> {
  // Managing catalogue for a certain vendor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Product Catalogue',
              style: TextStyle(color: Colors.white, fontSize: 25, letterSpacing: 3),
            ),
            IconButton(
              onPressed: () {
                DynamicLink().createDynamicLink(Provider.of<FireAuth>(context, listen: false).currentUserId);
              },
              icon: Icon(Icons.share),
            )
          ],
        ),
        toolbarHeight: 50,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CategoryList(
                vendorId: Provider.of<FireAuth>(context, listen: false).currentUserId,
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => CategoryAddOrEdit(
                        categoryId: '',
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                      ),
                    );
                  },
                  child: Container(
                    height: 40,
                    width: 150,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.blueGrey)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_circle,
                          size: 30,
                          color: Colors.blueGrey,
                        ),
                        Spacer(),
                        Text(
                          'Add Category',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
                        ),
                        Spacer()
                      ],
                    ),
                  ),
                ),
              ),
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
