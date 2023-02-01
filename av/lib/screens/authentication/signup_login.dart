import 'package:av/models/appuser/appuser.dart';
import 'package:av/screens/authentication/details_signup.dart';
import 'package:flutter/material.dart';

class SignUpLoginScreen extends StatefulWidget {
  // Phone number from the login screen
  final String phone;
  const SignUpLoginScreen({Key? key, required this.phone}) : super(key: key);

  @override
  _SignUpLoginScreenState createState() => _SignUpLoginScreenState();
}

class _SignUpLoginScreenState extends State<SignUpLoginScreen> {
  // UserRole chosen by the new user
  late UserRole _userRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.blue.shade200,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'Sign Up\nAs:',
                  style: TextStyle(fontSize: 50, color: Colors.white, letterSpacing: 5, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    _userRole = UserRole.VENDOR;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsSignUpScreen(phone: widget.phone, userRole: _userRole),
                      ),
                    );
                  });
                },
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  height: 120,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.blueGrey),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_bag_rounded,
                        size: 60,
                        color: Colors.blueGrey,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Vendor',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    _userRole = UserRole.LEADER;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsSignUpScreen(phone: widget.phone, userRole: _userRole),
                      ),
                    );
                  });
                },
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  height: 120,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.blueGrey),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_pin,
                        size: 60,
                        color: Colors.blueGrey,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Leader',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
