import 'package:al/dao/categoryStore.dart';
import 'package:al/dao/mediaStore.dart';
import 'package:al/dao/orderFormStore.dart';
import 'package:al/dao/userStore.dart';
import 'package:al/models/appuser/appuser.dart';
import 'package:al/models/category/category.dart';
import 'package:al/models/orderform/orderform.dart';
import 'package:al/screens/leaderWebView/productGrid_VendorList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VendorList extends StatefulWidget {
  // Vendor list tile of a specific vendor
  final String vendorId;
  const VendorList({Key? key, required this.vendorId}) : super(key: key);

  @override
  _VendorListState createState() => _VendorListState();
}

class _VendorListState extends State<VendorList> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
        future: UserStore().getUser(widget.vendorId),
        builder: (BuildContext context, AsyncSnapshot<AppUser?> vendor) {
          if (vendor.hasError) {
            print(vendor.error);
          }
          if (vendor.data == null) {
            return Container();
          }
          return Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.blueGrey)),
            child: ExpansionTile(
              initiallyExpanded: true,
              maintainState: true,
              textColor: Colors.blue,
              iconColor: Colors.blue,
              collapsedTextColor: Colors.black,
              collapsedIconColor: Colors.black,
              title: Row(
                children: [
                  StreamBuilder<String?>(
                    stream: MediaStore().getUrl(vendor.data!.userId!),
                    builder: (BuildContext context, AsyncSnapshot<String?> url) {
                      if (url.hasError) {
                        print(vendor.error);
                      }
                      return Container(
                        height: 45,
                        width: 45,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.blueGrey),
                            image: url.hasData ? DecorationImage(image: NetworkImage(url.data!)) : null),
                        child: url.hasData
                            ? null
                            : Icon(
                                Icons.person_pin,
                                color: Colors.black,
                              ),
                      );
                    },
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    vendor.data!.userName!,
                    style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Material(
                    color: Colors.blueGrey,
                    elevation: 10,
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.blueGrey)),
                      child: StreamBuilder<OrderForm?>(
                          stream: OrderFormStore().getOrderForm(widget.vendorId),
                          builder: (BuildContext context, AsyncSnapshot<OrderForm?> orderForm) {
                            if (orderForm.hasError) {
                              throw (orderForm.error!);
                            }
                            if (orderForm.data == null)
                              return Text(
                                'Closed for Orders',
                                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, letterSpacing: 2),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              );

                            Duration timeLeft = orderForm.data!.timestamp!.toDate().difference(DateTime.now());

                            if (orderForm.data!.orderFormState == OrderFormState.INACTIVE || timeLeft.isNegative)
                              return Text(
                                'Closed for Orders',
                                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, letterSpacing: 2),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              );
                            return Text(
                              'Open for Orders : ' +
                                  (timeLeft.inDays > 0
                                      ? timeLeft.inDays.toString() + ' days left'
                                      : timeLeft.inHours.toString() + ' hours left'),
                              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, letterSpacing: 2),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            );
                          }),
                    ),
                  ),
                ),
                StreamBuilder<OrderForm?>(
                    stream: OrderFormStore().getOrderForm(widget.vendorId),
                    builder: (BuildContext context, AsyncSnapshot<OrderForm?> orderForm) {
                      if (orderForm.hasError) {
                        throw (orderForm.error!);
                      }
                      if (orderForm.data == null) return Container();
                      if (orderForm.data!.orderFormState == OrderFormState.INACTIVE ||
                          orderForm.data!.timestamp!.compareTo(Timestamp.now()) < 0) return Container();
                      return StreamBuilder<List<Category>>(
                          stream: CategoryStore().categories(vendor.data!.userId!),
                          builder: (BuildContext context, AsyncSnapshot<List<Category>> categories) {
                            if (categories.hasError) {
                              print(categories.error);
                            }
                            if (categories.data == null) {
                              return Container();
                            }
                            if (categories.data!.length == 0)
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.error,
                                        size: 50,
                                        color: Colors.blueGrey,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          'No Categories',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Vendor has no products",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.blueGrey,
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
                                  return ProductGrid(category: categories.data![categoryIndex]);
                                },
                              );
                          });
                    }),
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
