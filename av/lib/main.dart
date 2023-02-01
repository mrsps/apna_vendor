import 'package:av/helpers/sharedPreferences.dart';
import 'package:av/providers/fireAuth.dart';
import 'package:av/helpers/routeGenerator.dart';
import 'package:av/providers/loading.dart';
import 'package:av/screens/dashboard/dashboard.dart';
import 'package:av/screens/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(), // Main App
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      statusBarColor: Colors.blueGrey,
    ));
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FireAuth()),
        ChangeNotifierProvider(create: (context) => Loading())
      ],
      child: FutureBuilder(
        future: SharedCache().isLoggedIn(),
        // Checking if user details in cache
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData)
            return Container();
          else
            return MaterialApp(
              theme: ThemeData(
                dividerColor: Colors.transparent,
              ),
              debugShowCheckedModeBanner: false,
              initialRoute: snapshot.data! ? DashboardScreen.id : LoginScreen.id,
              onGenerateRoute: RouteGenerator.generateRoute,
            );
        },
      ),
    );
  }
}
