import 'package:flutter/material.dart';

class Loading with ChangeNotifier {
  // Bool to define loading state
  bool isLoading = false;

  // To toggle the loading state
  void onLoading() {
    if (!isLoading) {
      isLoading = !isLoading;
    }
    notifyListeners();
  }

  // To toggle the loading state
  void offLoading() {
    if (isLoading) {
      isLoading = !isLoading;
    }
    notifyListeners();
  }
}

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  _LoadingIndicatorState createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          color: Colors.blueGrey,
        ),
      ),
    );
  }
}
