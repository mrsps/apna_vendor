import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationDialog extends StatefulWidget {
  // Subscribing to notifications linked with a specific leader
  final String leaderId;
  const NotificationDialog({Key? key, required this.leaderId}) : super(key: key);

  @override
  _NotificationDialogState createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog> {
  // Phone no. entered by the user
  String _phone = '';

  final _formKey = GlobalKey<FormState>();
  FocusNode _phoneFocus = FocusNode();
  bool _isLoading = false;

  // Function to validate entered phone no.
  bool validate(String s) {
    if (s.length == 10 && double.tryParse(s) != null) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // Main subscribing function which also calls a cloud function
    Future<void> subscribe() async {
      setState(() {
        _isLoading = true;
      });
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        DocumentReference<Map<String, dynamic>> documentReference =
            FirebaseFirestore.instance.collection('leaderConsumers').doc(widget.leaderId);
        await documentReference.get().then((snapshot) {
          List? numbers = snapshot.data()!['numbers'];
          if (numbers != null) {
            if (!numbers.contains(_phone)) {
              documentReference.set({
                'numbers': FieldValue.arrayUnion([_phone]),
              }, SetOptions(merge: true));
            }
          } else {
            documentReference.set({
              'numbers': FieldValue.arrayUnion([_phone]),
            }, SetOptions(merge: true));
          }
          FirebaseFunctions.instance.httpsCallable('informUser').call(
            <String, dynamic>{
              "phone": _phone,
            },
          );
        });
        Navigator.pop(context, true);
        _formKey.currentState!.reset();
        FocusScope.of(context).unfocus();
      }
      setState(() {
        _isLoading = false;
      });
    }

    // TextField to get phone no. from the user
    final phoneField = TextFormField(
      style: TextStyle(letterSpacing: 3, color: Colors.black54),
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      focusNode: _phoneFocus,
      validator: (phone) => validate(phone!) ? null : 'Invalid Phone Number',
      onSaved: (phone) => _phone = phone!,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone),
          contentPadding: EdgeInsets.all(10),
          labelText: 'Phone No.',
          hintText: 'XXXXXXXXXX',
          hintStyle: TextStyle(color: Colors.black26, letterSpacing: 2),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))),
      onFieldSubmitted: (term) {
        subscribe();
      },
    );

    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: Colors.blue.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      content: Form(
        key: _formKey,
        child: Container(
          height: 125,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text(
                'Subscribe for WhatsApp Notification',
                style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                child: phoneField,
              ),
            ],
          ),
        ),
      ),
      actions: [
        Center(
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade300),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ))),
            onPressed: () async {
              if (!_isLoading) await subscribe();
            },
            child: _isLoading
                ? SizedBox(
                    width: 100,
                    child: LinearProgressIndicator(
                      color: Colors.blueGrey,
                      backgroundColor: Colors.white,
                    ),
                  )
                : SizedBox(
                    width: 100,
                    child: Text(
                      'Subscribe',
                      textAlign: TextAlign.center,
                    ),
                  ),
          ),
        )
      ],
    );
  }
}
