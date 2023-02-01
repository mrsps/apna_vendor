import 'package:av/helpers/dynamicLinks.dart';
import 'package:av/providers/fireAuth.dart';
import 'package:av/screens/orders_leader/orders_leader.dart';
import 'package:av/screens/profile_management/profile_dashboard.dart';
import 'package:av/screens/vendorList_leader/vendorList_leader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaderDashboard extends StatefulWidget {
  static const String id = 'leader_dashboard';
  const LeaderDashboard({Key? key}) : super(key: key);

  @override
  _LeaderDashboardState createState() => _LeaderDashboardState();
}

class _LeaderDashboardState extends State<LeaderDashboard> {
  // For main navigation view
  int _page = 0;
  final PageController _controller = PageController(initialPage: 0);

  @override
  void initState() {
    // Identifying whether the app is opened using dynamic links
    DynamicLink().dynamicLinks(Provider.of<FireAuth>(context, listen: false).currentUserId);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Vendors'),
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
              child: VendorList(),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.blue.shade200,
              child: OrdersLeader(),
            ),
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
