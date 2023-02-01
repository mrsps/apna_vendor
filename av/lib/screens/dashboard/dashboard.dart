import 'package:av/models/appuser/appuser.dart';
import 'package:av/helpers/sharedPreferences.dart';
import 'package:av/providers/fireAuth.dart';
import 'package:av/providers/loading.dart';
import 'package:av/screens/dashboard/vendor_dashboard.dart';
import 'package:av/screens/dashboard/leader_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  static const String id = 'dashboard_screen';
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedCache().isLoggedIn(),
        // First checking if user present in cache
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData)
            return LoadingIndicator();
          else {
            if (snapshot.data!)
              // User present in cache
              return FutureBuilder(
                  future: SharedCache().setUser(),
                  // Getting user from cache
                  builder: (BuildContext context, AsyncSnapshot<AppUser?> snapshot) {
                    if (!snapshot.hasData)
                      return LoadingIndicator();
                    else {
                      Provider.of<FireAuth>(context, listen: false).currentUser = snapshot.data!;
                      Provider.of<FireAuth>(context, listen: false).currentUserId = snapshot.data!.userId!;
                      switch (snapshot.data!.userRole) {
                        case UserRole.LEADER:
                          return LeaderDashboard();
                        case UserRole.VENDOR:
                          return VendorDashboard();
                        case null:
                          return LoadingIndicator();
                      }
                    }
                  });
            else {
              // User not present in cache
              AppUser appUser = Provider.of<FireAuth>(context, listen: false).currentUser;
              return FutureBuilder(
                  future: SharedCache().logIn(appUser),
                  // Getting user stored into cache
                  builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                    if (!snapshot.hasData)
                      return LoadingIndicator();
                    else {
                      switch (appUser.userRole) {
                        case UserRole.LEADER:
                          return LeaderDashboard();
                        case UserRole.VENDOR:
                          return VendorDashboard();
                        case null:
                          return LoadingIndicator();
                      }
                    }
                  });
            }
          }
        });
  }
}
