import 'package:av/models/appuser/appuser.dart';
import 'package:av/providers/fireAuth.dart';
import 'package:av/providers/loading.dart';
import 'package:av/screens/authentication/details_signup.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class PinLoginScreen extends StatefulWidget {
  final String phone;
  const PinLoginScreen({Key? key, required this.phone}) : super(key: key);

  @override
  _PinLoginScreenState createState() => _PinLoginScreenState();
}

class _PinLoginScreenState extends State<PinLoginScreen> {
  // Pin of the appUser
  String _pin = '';

  @override
  Widget build(BuildContext context) {
    // Showing snackbar in case authentication failed
    void showSnack(String response) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          action: SnackBarAction(
            textColor: Colors.white,
            label: 'Forgot Pin ?',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsSignUpScreen(phone: widget.phone, userRole: UserRole.LEADER),
                ),
              );
            },
          ),
          backgroundColor: Colors.blueGrey.withOpacity(0.7),
          content: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.7), borderRadius: BorderRadius.circular(10)),
            child: Text(
              response,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blueGrey, letterSpacing: 3, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    }

    // Main authentication function
    void auth() async {
      Provider.of<Loading>(context, listen: false).onLoading();
      String? response = await Provider.of<FireAuth>(context, listen: false).login(widget.phone, _pin, context);
      Provider.of<Loading>(context, listen: false).offLoading();
      if (response != null) showSnack(response);
    }

    // TextField to enter Pin
    final pinField = PinCodeTextField(
      enablePinAutofill: false,
      length: 4,
      animationType: AnimationType.fade,
      backgroundColor: Colors.transparent,
      useHapticFeedback: true,
      textStyle: TextStyle(fontSize: 25, color: Colors.blueGrey, fontWeight: FontWeight.bold),
      mainAxisAlignment: MainAxisAlignment.center,
      keyboardType: TextInputType.phone,
      animationDuration: Duration(milliseconds: 300),
      cursorHeight: 20,
      pinTheme: PinTheme(
          fieldOuterPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          shape: PinCodeFieldShape.circle,
          fieldHeight: 40,
          fieldWidth: 40,
          activeColor: Colors.blue,
          selectedColor: Colors.blue,
          inactiveColor: Colors.blueGrey,
          borderWidth: 3),
      onCompleted: (pin) {
        _pin = pin;
        auth();
      },
      onChanged: (pin) {},
      appContext: context,
    );

    if (Provider.of<Loading>(context).isLoading)
      return LoadingIndicator();
    else
      return Scaffold(
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.blue.shade200,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                              (MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom) / 12,
                          letterSpacing: 5,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Back!!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                              (MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom) / 12,
                          letterSpacing: 5,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Enter pin for ' + widget.phone,
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  width: 210,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    border: Border.all(color: Colors.blueGrey),
                  ),
                  child: pinField,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                    border: Border.all(color: Colors.blueGrey),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.all(10),
                    color: Colors.blueGrey,
                    iconSize: 50,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
