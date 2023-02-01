import 'dart:async';
import 'package:av/providers/fireAuth.dart';
import 'package:av/providers/loading.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class OtpDetailsScreen extends StatefulWidget {
  // Phone for otp verification
  final String phone;
  const OtpDetailsScreen({Key? key, required this.phone}) : super(key: key);

  @override
  _OtpDetailsScreenState createState() => _OtpDetailsScreenState();
}

class _OtpDetailsScreenState extends State<OtpDetailsScreen> {
  // Otp code retrieved
  String _otp = '';
  bool _otpSent = false;
  late Timer _timer;

  @override
  void initState() {
    // Timer managing the visibility of resend button
    _timer = Timer(Duration(seconds: 30), () {
      setState(() {
        _otpSent = true;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Main otp code authentication function
    void otpAuth() async {
      Provider.of<Loading>(context, listen: false).onLoading();
      await Provider.of<FireAuth>(context, listen: false).otpAuth(_otp, context);
      Provider.of<Loading>(context, listen: false).offLoading();
    }

    // TextField to get otp code
    final otpPin = PinCodeTextField(
      length: 6,
      animationType: AnimationType.fade,
      backgroundColor: Colors.transparent,
      useHapticFeedback: true,
      textStyle: TextStyle(letterSpacing: 3, fontSize: 25, color: Colors.blueGrey, fontWeight: FontWeight.bold),
      mainAxisAlignment: MainAxisAlignment.center,
      keyboardType: TextInputType.phone,
      animationDuration: Duration(milliseconds: 300),
      cursorHeight: 10,
      pinTheme: PinTheme(
          borderRadius: BorderRadius.circular(10),
          fieldOuterPadding: EdgeInsets.all(5),
          shape: PinCodeFieldShape.box,
          fieldHeight: 40,
          fieldWidth: 30,
          activeColor: Colors.blue,
          selectedColor: Colors.blue,
          inactiveColor: Colors.blueGrey,
          borderWidth: 2),
      onCompleted: (pin) {
        _otp = pin;
        otpAuth();
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'Enter the otp',
                      style:
                          TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold, letterSpacing: 5),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Sent to +91' + widget.phone,
                      style:
                          TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 3),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  width: 280,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      border: Border.all(color: Colors.blueGrey)),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Container(color: Colors.blue, width: 260, height: 2),
                        ),
                        Text(
                          'Enter the otp',
                          style: TextStyle(
                              fontSize: 15, color: Colors.blueGrey, fontWeight: FontWeight.bold, letterSpacing: 3),
                        ),
                        otpPin,
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Container(color: Colors.blue, width: 260, height: 2),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_otpSent)
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.white,
                      border: Border.all(color: Colors.blueGrey),
                    ),
                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          _otpSent = false;
                        });
                        await Provider.of<FireAuth>(context, listen: false).resendOtpAuth(context);
                        _timer = Timer(const Duration(seconds: 30), () {
                          setState(() {
                            _otpSent = true;
                          });
                        });
                      },
                      child: const Text(
                        'Resend',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey, fontSize: 20),
                      ),
                    ),
                  )
                else
                  const Text(
                    'Otp has been sent successfully',
                    style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 3),
                  ),
              ],
            ),
          ),
        ),
      );
  }
}
