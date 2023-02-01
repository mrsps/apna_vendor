import 'package:av/dao/mediaStore.dart';
import 'package:av/dao/orderFormStore.dart';
import 'package:av/dao/orderStore.dart';
import 'package:av/dao/userStore.dart';
import 'package:av/models/appuser/appuser.dart';
import 'package:av/helpers/dynamicLinks.dart';
import 'package:av/models/orderform/orderform.dart';
import 'package:av/providers/fireAuth.dart';
import 'package:av/providers/loading.dart';
import 'package:av/widgets/alertDialog.dart';
import 'package:av/widgets/snackBar.dart';
import 'package:av/screens/vendorList_leader/catalogue_vendorList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VendorList extends StatefulWidget {
  const VendorList({Key? key}) : super(key: key);

  @override
  _VendorListState createState() => _VendorListState();
}

class _VendorListState extends State<VendorList> {
  // VendorList showing vendors linked to a specific leader
  // With their orderForm status

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        shadowColor: Colors.black,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Vendor List',
              style: TextStyle(color: Colors.white, fontSize: 25, letterSpacing: 3),
            ),
            InkWell(
              onTap: () {
                DynamicLink().shareLeaderCatalogue(Provider.of<FireAuth>(context, listen: false).currentUserId);
              },
              borderRadius: BorderRadius.circular(30),
              child: Icon(
                Icons.share,
                size: 30,
              ),
            )
          ],
        ),
        toolbarHeight: 50,
      ),
      body: StreamBuilder<List<String>>(
          stream: UserStore().vendors(Provider.of<FireAuth>(context, listen: false).currentUserId),
          builder: (BuildContext context, AsyncSnapshot<List<String>> vendors) {
            if (vendors.hasError) {
              throw (vendors.error!);
            }
            if (vendors.connectionState == ConnectionState.waiting) {
              return LoadingIndicator();
            }
            if (vendors.data!.length == 0) {
              return Container(
                padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      size: 100,
                      color: Colors.blueGrey,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'No Vendors',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2, fontSize: 30),
                      ),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
                padding: EdgeInsets.all(5),
                itemCount: vendors.data!.length,
                itemBuilder: (context, vendorIndex) {
                  return FutureBuilder(
                      future: UserStore().getUser(vendors.data![vendorIndex]),
                      builder: (BuildContext context, AsyncSnapshot<AppUser?> vendor) {
                        if (vendor.hasError) {
                          throw (vendor.error!);
                        }
                        if (vendor.connectionState == ConnectionState.waiting) {
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
                        if (vendor.data == null) {
                          return Container();
                        }
                        return Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.blueGrey),
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: StreamBuilder<String?>(
                                      stream: MediaStore().getUrl(vendor.data!.userId!),
                                      builder: (BuildContext context, AsyncSnapshot<String?> url) {
                                        if (url.hasError) {
                                          throw (url.error!);
                                        }
                                        if (url.connectionState == ConnectionState.waiting) {
                                          return CircleAvatar(
                                            backgroundColor: Colors.black54,
                                            child: CircularProgressIndicator(
                                              backgroundColor: Colors.white,
                                              color: Colors.blue,
                                            ),
                                          );
                                        }
                                        return CircleAvatar(
                                          backgroundColor: Colors.black54,
                                          backgroundImage: url.hasData ? NetworkImage(url.data!) : null,
                                          child: url.hasData
                                              ? null
                                              : Icon(
                                                  Icons.person_pin,
                                                  color: Colors.white,
                                                ),
                                        );
                                      },
                                    ),
                                  ),
                                  trailing: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 10),
                                    width: 75,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            DynamicLink().shareVendorCatalogue(
                                                Provider.of<FireAuth>(context, listen: false).currentUserId,
                                                vendors.data![vendorIndex]);
                                          },
                                          child: Icon(
                                            Icons.share,
                                            color: Colors.blueGrey,
                                            size: 30,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            bool orderExists =
                                                await OrderStore().orderVendorExists(vendors.data![vendorIndex],Provider.of<FireAuth>(context,listen: false).currentUserId);
                                            if (orderExists) {
                                              showAlert('Cannot delete vendor with open orders.', context);
                                            } else {
                                              showSnack('Vendor Deleted', context);
                                              await UserStore().deleteVendor(vendors.data![vendorIndex],
                                                  Provider.of<FireAuth>(context, listen: false).currentUserId);
                                            }
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: 30,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  title: Text(
                                    vendor.data!.userName!,
                                    style: TextStyle(color: Colors.black54, letterSpacing: 3),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CatalogueVendorList(
                                          vendorId: vendor.data!.userId!,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
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
                                          stream: OrderFormStore().getOrderForm(vendors.data![vendorIndex]),
                                          builder: (BuildContext context, AsyncSnapshot<OrderForm?> orderForm) {
                                            if (orderForm.hasError) {
                                              throw (orderForm.error!);
                                            }
                                            if (orderForm.data == null)
                                              return Text(
                                                'Closed for Orders',
                                                style: TextStyle(
                                                    color: Colors.red, fontWeight: FontWeight.bold, letterSpacing: 2),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              );

                                            Duration timeLeft =
                                                orderForm.data!.timestamp!.toDate().difference(DateTime.now());

                                            if (orderForm.data!.orderFormState == OrderFormState.INACTIVE || timeLeft.isNegative)
                                              return Text(
                                                'Closed for Orders',
                                                style: TextStyle(
                                                    color: Colors.red, fontWeight: FontWeight.bold, letterSpacing: 2),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              );
                                            return Text(
                                              'Open for Orders : ' +
                                                  (timeLeft.inDays > 0
                                                      ? timeLeft.inDays.toString() + ' days left'
                                                      : timeLeft.inHours.toString() + ' hours left'),
                                              style: TextStyle(
                                                  color: Colors.green, fontWeight: FontWeight.bold, letterSpacing: 2),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            );
                                          }),
                                    ),
                                  ),
                                ),
                              ],
                            ));
                      });
                });
          }),
    );
  }
}
