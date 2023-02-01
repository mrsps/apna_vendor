import 'dart:io';
import 'package:av/dao/mediaStore.dart';
import 'package:av/dao/productStore.dart';
import 'package:av/models/media/media.dart';
import 'package:av/models/product/product.dart';
import 'package:av/helpers/randomIdMaker.dart';
import 'package:av/providers/fireAuth.dart';
import 'package:av/providers/loading.dart';
import 'package:av/widgets/snackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:av/widgets/mediaPicker.dart';

class ProductAdd extends StatefulWidget {
  // Adding a product in a certain category
  final String categoryId;
  const ProductAdd({Key? key, required this.categoryId}) : super(key: key);

  @override
  _ProductAddState createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  // All variables needed to add a product
  File? _image;
  String? _productName;
  double? _productPrice;
  int? _productQuantity;
  String _selectedMeasure = measureString(Measure.KILOGRAM);

  final formKey = GlobalKey<FormState>();
  FocusNode nameFocus = FocusNode();
  FocusNode priceFocus = FocusNode();
  FocusNode qPriceFocus = FocusNode();
  FocusNode quantityFocus = FocusNode();

  // Main add fucntion
  void add() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Provider.of<Loading>(context, listen: false).onLoading();
      String productId = getRandomID('Product');
      await ProductStore().setProduct(Product(
          userId: Provider.of<FireAuth>(context, listen: false).currentUserId,
          productId: productId,
          categoryId: widget.categoryId,
          productName: _productName,
          productMeasure: stringMeasure(_selectedMeasure),
          productPrice: _productPrice,
          productMinimumQuantity: _productQuantity));
      if (_image != null) {
        String url = (await MediaStore().uploadImage(_image!))!;
        String mediaId = getRandomID('Media');
        await MediaStore().setMedia(
          Media(entityId: productId, mediaId: mediaId, mediaUrl: url),
        );
      }
      Provider.of<Loading>(context, listen: false).offLoading();
      showSnack('Product Added', context);
      Navigator.of(context).pop();
    }
  }

  // Widget builder for different quantities
  List<Widget> measurements(var x) {
    List<Widget> list = [];
    Measure.values.forEach((measure) {
      list.add(
        InkWell(
          onTap: () {
            x(() {
              _selectedMeasure = measureString(measure);
            });
          },
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
                color: _selectedMeasure == measureString(measure) ? Colors.blueGrey : Colors.white,
                border: Border.all(color: Colors.blueGrey, width: 2),
                borderRadius: BorderRadius.circular(25)),
            child: Text(
              measureString(measure),
              style: TextStyle(
                  fontSize: 25, color: _selectedMeasure == measureString(measure) ? Colors.white : Colors.blueGrey),
            ),
          ),
        ),
      );
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    // TextField to enter the name
    final nameField = TextFormField(
      style: TextStyle(letterSpacing: 3, fontSize: 20, color: Colors.blueGrey, fontWeight: FontWeight.bold),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      focusNode: nameFocus,
      validator: (name) => name!.length == 0 ? 'Invalid Name' : null,
      onSaved: (name) => _productName = name!.trim(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        labelText: 'Product Name',
        labelStyle: TextStyle(letterSpacing: 1, fontSize: 15, fontWeight: FontWeight.normal),
        hintStyle: TextStyle(color: Colors.blueGrey, letterSpacing: 3, fontSize: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onFieldSubmitted: (term) {
        FocusScope.of(context).requestFocus(priceFocus);
      },
    );

    // TextField to enter the price
    final priceField = TextFormField(
      style: TextStyle(letterSpacing: 3, fontSize: 20, color: Colors.blueGrey, fontWeight: FontWeight.bold),
      keyboardType: TextInputType.numberWithOptions(),
      textInputAction: TextInputAction.next,
      focusNode: priceFocus,
      validator: (price) => price!.length == 0 || double.tryParse(price) == null ? 'Invalid Price' : null,
      onSaved: (price) => _productPrice = double.parse(price!.trim()),
      decoration: InputDecoration(
        prefix: Text("₹:"),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        labelText: 'Price',
        labelStyle: TextStyle(letterSpacing: 1, fontSize: 15, fontWeight: FontWeight.normal),
        hintStyle: TextStyle(color: Colors.blueGrey, letterSpacing: 2, fontSize: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onFieldSubmitted: (term) {
        FocusScope.of(context).requestFocus(qPriceFocus);
      },
    );

    // TextField to enter the quantity
    final quantityField = TextFormField(
      style: TextStyle(letterSpacing: 3, fontSize: 18, color: Colors.blueGrey, fontWeight: FontWeight.bold),
      keyboardType: TextInputType.numberWithOptions(),
      textInputAction: TextInputAction.next,
      focusNode: qPriceFocus,
      onSaved: (quantity) => _productQuantity = (quantity!.length==0) ? 1 : int.parse(quantity.trim()),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        suffix: Text(
          ' x ' + _selectedMeasure,
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
        labelText: 'Minimum Quantity',
        labelStyle: TextStyle(letterSpacing: 1, fontSize: 15, fontWeight: FontWeight.normal),
        hintStyle: TextStyle(color: Colors.blueGrey, letterSpacing: 2, fontSize: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onFieldSubmitted: (term) {
        add();
      },
    );

    return Container(
      height: 330 + MediaQuery.of(context).viewInsets.bottom,
      decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
          border: Border.all(color: Colors.white)),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: Container(
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blueGrey,
                  border: Border.all(color: Colors.black),
                ),
                child: Text(
                  'Add Product',
                  style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 3, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              trailing: SizedBox(
                width: 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueGrey,
                        border: Border.all(color: Colors.black),
                      ),
                      child: Provider.of<Loading>(context).isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                                color: Colors.blue,
                              ),
                            )
                          : IconButton(
                              iconSize: 20,
                              onPressed: () {
                                add();
                              },
                              icon: Icon(
                                Icons.done,
                                color: Colors.white,
                              ),
                            ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueGrey,
                        border: Border.all(color: Colors.black),
                      ),
                      child: IconButton(
                        iconSize: 20,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: nameField,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async {
                    File? temp = await showDialog(
                        context: context,
                        builder: (context) {
                          return MediaPicker();
                        });
                    _image = temp == null ? _image : temp;
                    setState(() {});
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 125,
                    width: 125,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black),
                        image: _image != null ? DecorationImage(fit: BoxFit.fill, image: FileImage(_image!)) : null),
                    child: _image == null
                        ? Icon(
                            Icons.add_a_photo,
                            color: Colors.blue.shade50,
                            size: 75,
                          )
                        : null,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: priceField,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                            child: Text(
                              '/',
                              style: TextStyle(fontSize: 50, color: Colors.blueGrey, fontWeight: FontWeight.w200),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 15, 5),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(25),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(builder: (context, dialogState) {
                                      return AlertDialog(
                                        insetPadding: EdgeInsets.zero,
                                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                                        titlePadding: EdgeInsets.all(10),
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        backgroundColor: Colors.blue.shade100,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                        title: Text(
                                          'Choose measurement',
                                          textAlign: TextAlign.center,
                                        ),
                                        content: SizedBox(
                                          width: 100,
                                          child: Wrap(
                                              alignment: WrapAlignment.center,
                                              runAlignment: WrapAlignment.center,
                                              spacing: 10,
                                              runSpacing: 10,
                                              children: measurements(dialogState)),
                                        ),
                                        actions: [
                                          Center(
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<Color>(Colors.blue.shade300),
                                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ))),
                                              onPressed: () {
                                                setState(() {
                                                  Navigator.of(context).pop();
                                                });
                                              },
                                              child: Text('Ok'),
                                            ),
                                          )
                                        ],
                                      );
                                    });
                                  },
                                );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Text(
                                  _selectedMeasure,
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 15, 10),
                        child: quantityField,
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom,
            )
          ],
        ),
      ),
    );
  }
}
