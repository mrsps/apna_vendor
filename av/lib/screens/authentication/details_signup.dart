import 'package:av/models/appuser/appuser.dart';
import 'package:av/providers/fireAuth.dart';
import 'package:av/widgets/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class DetailsSignUpScreen extends StatefulWidget {
  // Phone and userRole of the new user
  final String phone;
  final UserRole userRole;
  const DetailsSignUpScreen({Key? key, required this.phone, required this.userRole}) : super(key: key);

  @override
  _DetailsSignUpScreenState createState() => _DetailsSignUpScreenState();
}

class _DetailsSignUpScreenState extends State<DetailsSignUpScreen> {
  // Name and pin entered by the new user
  String _name = '', _ePin = '';

  final _formKey = GlobalKey<FormState>();
  FocusNode _nameFocus = FocusNode();
  FocusNode _ePinFocus = FocusNode();

  // Main otp generating function
  void otpGenerate() async {
    if (_ePin == '') {
      showSnack('Enter Pin First', context);
      return;
    }
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await Provider.of<FireAuth>(context, listen: false)
          .sendOtpAuth(widget.phone, _ePin, _name, widget.userRole, context);
      _formKey.currentState!.reset();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TextField to enter name
    final nameField = TextFormField(
      textAlign: TextAlign.center,
      style: TextStyle(letterSpacing: 2, fontSize: 25, color: Colors.blue, fontWeight: FontWeight.bold),
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      focusNode: _nameFocus,
      validator: (name) => name!.isEmpty ? 'Required' : null,
      onSaved: (text) => _name = text!,
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintText: 'XXXXX XXXXX',
        hintStyle: TextStyle(color: Colors.blueGrey, letterSpacing: 2, fontSize: 20),
      ),
      onFieldSubmitted: (term) {
        FocusScope.of(context).requestFocus(_ePinFocus);
      },
    );

    // TextField to enter new pin
    final enterPin = PinCodeTextField(
      focusNode: _ePinFocus,
      length: 4,
      animationType: AnimationType.fade,
      backgroundColor: Colors.transparent,
      useHapticFeedback: true,
      textStyle: TextStyle(letterSpacing: 5, fontSize: 25, color: Colors.blueGrey, fontWeight: FontWeight.bold),
      mainAxisAlignment: MainAxisAlignment.center,
      keyboardType: TextInputType.phone,
      animationDuration: Duration(milliseconds: 300),
      cursorHeight: 20,
      pinTheme: PinTheme(
          fieldOuterPadding: EdgeInsets.all(5),
          shape: PinCodeFieldShape.circle,
          fieldHeight: 40,
          fieldWidth: 40,
          activeColor: Colors.blue,
          selectedColor: Colors.blue,
          inactiveColor: Colors.blueGrey,
          borderWidth: 3),
      onCompleted: (pin) {
        _ePin = pin;
        otpGenerate();
      },
      onChanged: (pin) {},
      appContext: context,
    );

    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height + MediaQuery.of(context).viewInsets.bottom,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Set Up Your\nAccount',
                    style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold, letterSpacing: 3),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    margin: EdgeInsets.all(30),
                    width: 270,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      border: Border.all(color: Colors.blueGrey),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Enter Your Name',
                          style: TextStyle(
                              fontSize: 15, color: Colors.blueGrey, fontWeight: FontWeight.bold, letterSpacing: 3),
                        ),
                        nameField,
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Container(color: Colors.blue, width: 250, height: 2),
                        ),
                        Text(
                          'Enter Pin',
                          style: TextStyle(
                              fontSize: 15, color: Colors.blueGrey, fontWeight: FontWeight.bold, letterSpacing: 3),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: enterPin,
                        ),
                      ],
                    ),
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
                        otpGenerate();
                      },
                      icon: Icon(Icons.arrow_forward),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
