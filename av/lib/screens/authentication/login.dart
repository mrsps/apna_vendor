import 'package:av/providers/fireAuth.dart';
import 'package:av/providers/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Phone number of appUser
  String _phone = '';

  final _formKey = GlobalKey<FormState>();
  FocusNode _phoneFocus = FocusNode();

  // Main login function
  void login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Provider.of<Loading>(context, listen: false).onLoading();
      await Provider.of<FireAuth>(context, listen: false).checkIfPhoneInUse(_phone, context);
      Provider.of<Loading>(context, listen: false).offLoading();
      FocusScope.of(context).unfocus();
    }
  }

  // To check if phone number is valid or not
  bool validate(String s) {
    if (s.length == 10 && double.tryParse(s) != null) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // Text field to enter phone
    final phoneField = TextFormField(
      style: TextStyle(letterSpacing: 3, fontSize: 20, color: Colors.black54, fontWeight: FontWeight.bold),
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.done,
      focusNode: _phoneFocus,
      validator: (phone) => validate(phone!) ? null : 'Invalid Phone Number',
      onSaved: (phone) => _phone = phone!.trim(),
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone),
          contentPadding: EdgeInsets.all(10),
          labelText: 'Phone No.',
          labelStyle: TextStyle(letterSpacing: 1, fontSize: 15, fontWeight: FontWeight.normal),
          hintText: 'XXXXXXXXXX',
          hintStyle: TextStyle(color: Colors.black26, letterSpacing: 2, fontSize: 20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))),
      onFieldSubmitted: (term) {
        login();
      },
    );

    if (Provider.of<Loading>(context).isLoading)
      return LoadingIndicator();
    else
      return Scaffold(
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.blue.shade200,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart,
                    size: (MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom) / 4,
                    color: Colors.white,
                  ),
                  Container(
                    width: 240,
                    margin: EdgeInsets.symmetric(vertical: 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white,
                        border: Border.all(color: Colors.blueGrey)),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: phoneField,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white,
                        border: Border.all(color: Colors.blueGrey)),
                    child: IconButton(
                        padding: EdgeInsets.all(10),
                        color: Colors.blueGrey,
                        iconSize: 50,
                        onPressed: () {
                          login();
                        },
                        icon: Icon(Icons.arrow_forward)),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}
