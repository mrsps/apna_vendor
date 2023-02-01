import 'package:av/screens/orders_vendor/orders_vendor.dart';
import 'package:av/screens/profile_management/profile_dashboard.dart';
import 'package:av/screens/catalogue_vendor/catalogue_vendor.dart';
import 'package:flutter/material.dart';

class VendorDashboard extends StatefulWidget {
  static const String id = 'vendor_dashboard';
  const VendorDashboard({Key? key}) : super(key: key);

  @override
  _VendorDashboardState createState() => _VendorDashboardState();
}

class _VendorDashboardState extends State<VendorDashboard> {
  // For main navigation view
  int _page = 0;
  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blueGrey,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(color: Colors.white),
        unselectedLabelStyle: TextStyle(color: Colors.black),
        currentIndex: _page,
        onTap: (index) {
          _page = index;
          _controller.jumpToPage(index);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.line_style), label: 'Catalogue'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
      ),
      body: SafeArea(
        child: PageView(
          controller: _controller,
          onPageChanged: (page) {
            setState(() {
              _page = page;
            });
          },
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.blue.shade200,
              child: CatalogueVendor(),
            ),
            Container(width: MediaQuery.of(context).size.width, color: Colors.blue.shade200, child: OrdersVendor()),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.blue.shade200,
              child: ProfileDashboard(),
            )
          ],
        ),
      ),
    );
  }
}
