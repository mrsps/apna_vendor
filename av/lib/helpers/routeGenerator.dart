import 'package:av/screens/dashboard/dashboard.dart';
import 'package:av/screens/authentication/login.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings){
    switch (settings.name) {
      case LoginScreen.id:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case DashboardScreen.id:
        return MaterialPageRoute(builder: (context) => DashboardScreen());
    }
    return _errorRoute();
  }

  // Error page in navigation
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Error in routing'),
        ),
      );
    });
  }
}