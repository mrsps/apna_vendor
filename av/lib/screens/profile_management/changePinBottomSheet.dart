import 'package:av/helpers/sharedPreferences.dart';
import 'package:av/models/appuser/appuser.dart';
import 'package:av/providers/fireAuth.dart';
import 'package:av/providers/loading.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class ChangePin extends StatefulWidget {
  const ChangePin({Key? key}) : super(key: key);

  @override
  _ChangePinState createState() => _ChangePinState();
}

class _ChangePinState extends State<ChangePin> {
  // Old and new pin
  String _oldPin = '', _newPin = '';

  FocusNode _oldFocus = FocusNode();
  FocusNode _newFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    // Main change function
    void change() async {
      Provider.of<Loading>(context, listen: false).onLoading();
      FireAuth fireAuth = Provider.of<FireAuth>(context, listen: false);
      if (_oldPin != fireAuth.currentUser.userPin) {
        Provider.of<Loading>(context, listen: false).offLoading();
        Navigator.pop(context, 'Wrong Pin');
      } else {
        AppUser appUser = Provider.of<FireAuth>(context, listen: false).currentUser.copyWith(userPin: _newPin);
        await Provider.of<FireAuth>(context, listen: false).setCurrentUser(appUser);
        await SharedCache().logIn(appUser);
        Provider.of<Loading>(context, listen: false).offLoading();
        Navigator.pop(context, 'Pin Changed');
      }
    }

    // TextField to enter an old pin
    final oldPinField = PinCodeTextField(
      enablePinAutofill: false,
      length: 4,
      focusNode: _oldFocus,
      animationType: AnimationType.fade,
      backgroundColor: Colors.transparent,
      autoFocus: true,
      useHapticFeedback: true,
      textStyle: TextStyle(fontSize: 25, color: Colors.blueGrey, fontWeight: FontWeight.bold),
      mainAxisAlignment: MainAxisAlignment.center,
      keyboardType: TextInputType.phone,
      animationDuration: Duration(milliseconds: 300),
      cursorHeight: 20,
      pinTheme: PinTheme(
          fieldOuterPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
          shape: PinCodeFieldShape.circle,
          fieldHeight: 60,
          fieldWidth: 40,
          activeColor: Colors.blue,
          selectedColor: Colors.blue,
          inactiveColor: Colors.blueGrey,
          borderWidth: 3),
      onCompleted: (pin) {
        _oldPin = pin;
        if (_newPin == '') {
          FocusScope.of(context).requestFocus(_newFocus);
        } else
          change();
      },
      onChanged: (pin) {},
      appContext: context,
    );

    // TextField to enter a new pin
    final newPinField = PinCodeTextField(
      enablePinAutofill: false,
      length: 4,
      focusNode: _newFocus,
      animationType: AnimationType.fade,
      backgroundColor: Colors.transparent,
      useHapticFeedback: true,
      textStyle: TextStyle(fontSize: 25, color: Colors.blueGrey, fontWeight: FontWeight.bold),
      mainAxisAlignment: MainAxisAlignment.center,
      keyboardType: TextInputType.phone,
      animationDuration: Duration(milliseconds: 300),
      cursorHeight: 20,
      pinTheme: PinTheme(
          fieldOuterPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          shape: PinCodeFieldShape.circle,
          fieldHeight: 40,
          fieldWidth: 40,
          activeColor: Colors.blue,
          selectedColor: Colors.blue,
          inactiveColor: Colors.blueGrey,
          borderWidth: 3),
      onCompleted: (pin) {
        _newPin = pin;
        if (_oldPin == '') {
          FocusScope.of(context).requestFocus(_oldFocus);
        } else
          change();
      },
      onChanged: (pin) {},
      appContext: context,
    );

    return Container(
      height: 190 + MediaQuery.of(context).viewInsets.bottom,
      decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          border: Border.all(color: Colors.white)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: Container(
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blueGrey,
                border: Border.all(color: Colors.black),
              ),
              child: Text(
                'Change Pin',
                style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 3, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            trailing: SizedBox(
              width: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueGrey,
                      border: Border.all(color: Colors.black),
                    ),
                    child: Provider.of<Loading>(context).isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                              color: Colors.blue,
                            ),
                          )
                        : IconButton(
                            iconSize: 20,
                            onPressed: () {
                              change();
                            },
                            icon: Icon(
                              Icons.done,
                              color: Colors.white,
                            ),
                          ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueGrey,
                      border: Border.all(color: Colors.black),
                    ),
                    child: IconButton(
                      iconSize: 20,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(5),
                        height: 4,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Text(
                      'Old Pin',
                      style: TextStyle(),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(5),
                        height: 4,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 180, height: 50, child: oldPinField),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(5),
                        height: 4,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Text(
                      'New Pin',
                      style: TextStyle(),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(5),
                        height: 4,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 180, height: 50, child: newPinField),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom,
          )
        ],
      ),
    );
  }
}
