import 'package:av/helpers/sharedPreferences.dart';
import 'package:av/models/appuser/appuser.dart';
import 'package:av/providers/fireAuth.dart';
import 'package:av/providers/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateName extends StatefulWidget {
  const UpdateName({Key? key}) : super(key: key);

  @override
  _UpdateNameState createState() => _UpdateNameState();
}

class _UpdateNameState extends State<UpdateName> {
  // New name entered by the user
  String _userName = '';
  final _formKey = GlobalKey<FormState>();
  FocusNode _nameFocus = FocusNode();

  // Main name change function
  void add() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Provider.of<Loading>(context, listen: false).onLoading();
      AppUser appUser = Provider.of<FireAuth>(context, listen: false).currentUser.copyWith(userName: _userName);
      await Provider.of<FireAuth>(context, listen: false).setCurrentUser(appUser);
      await SharedCache().logIn(appUser);
      Provider.of<Loading>(context, listen: false).offLoading();
      Navigator.pop(context, 'Name Changed');
    }
  }

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
      style: TextStyle(letterSpacing: 3, fontSize: 20, color: Colors.blueGrey, fontWeight: FontWeight.bold),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      focusNode: _nameFocus,
      validator: (name) => name!.length == 0 ? 'Invalid Name' : null,
      onSaved: (name) => _userName = name!.trim(),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: 'User Name',
          labelStyle: TextStyle(letterSpacing: 1, fontSize: 15, fontWeight: FontWeight.normal),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))),
      onFieldSubmitted: (term) {
        add();
      },
    );

    return Container(
      height: 160 + MediaQuery.of(context).viewInsets.bottom,
      decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          border: Border.all(color: Colors.white)),
      child: Form(
        key: _formKey,
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
                  'Update Name',
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
                                add();
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
                          Navigator.of(context).pop();
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
            Padding(
              padding: const EdgeInsets.all(10),
              child: nameField,
            ),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom,
            )
          ],
        ),
      ),
    );
  }
}
