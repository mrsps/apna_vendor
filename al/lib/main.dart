import 'package:al/providers/fireNotify.dart';
import 'package:al/providers/orderManagement.dart';
import 'package:al/screens/leaderWebView/leaderVendorWebView.dart';
import 'package:al/screens/leaderWebView/leaderWebView.dart';
import 'package:al/screens/vendorWebView/vendorWebView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setUrlStrategy(PathUrlStrategy());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Getting associated leader and vendor Ids
  final String myUrl = Uri.base.toString();
  final String? leaderId = Uri.base.queryParameters['leaderId'];
  final String? vendorId = Uri.base.queryParameters['vendorId'];

  @override
  Widget build(BuildContext context) {
    if (leaderId == null && vendorId != null) {
      // Only vendor web view with no order functionality
      return MaterialApp(
        theme: ThemeData(dividerColor: Colors.transparent),
        debugShowCheckedModeBanner: false,
        initialRoute: '/', // Initial Screen
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: (_) => VendorWebView(vendorId: vendorId!));
        },
      );
    } else {
      return MultiProvider(
        providers: [
          Provider(create: (context) => FireNotify(leaderId == null ? '' : leaderId)),
          ChangeNotifierProvider(create: (context) => OrderManager(leaderId == null ? '' : leaderId)),
        ],
        child: MaterialApp(
          theme: ThemeData(dividerColor: Colors.transparent),
          debugShowCheckedModeBanner: false,
          initialRoute: '/', // Initial Screen
          onGenerateRoute: (settings) {
            if (vendorId == null && leaderId != null)
              // Leader web view with all linked vendors
              return MaterialPageRoute(builder: (_) => LeaderWebView(leaderId: leaderId!));
            else if (vendorId != null && leaderId != null)
              // Leader web view with a specific vendor
              return MaterialPageRoute(builder: (_) => LeaderVendorWebView(leaderId: leaderId!, vendorId: vendorId!));
            else
              // Error Page
              return MaterialPageRoute(builder: (_) => ErrorLink());
          },
        ),
      );
    }
  }
}

class ErrorLink extends StatelessWidget {
  const ErrorLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.blue.shade200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              color: Colors.transparent,
              shape: CircleBorder(),
              elevation: 10,
              child: Icon(
                Icons.error,
                color: Colors.white,
                size: MediaQuery.of(context).size.shortestSide / 5,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Error!!\nNo linked vendor found.',
              style: TextStyle(fontSize: MediaQuery.of(context).size.shortestSide / 10, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
