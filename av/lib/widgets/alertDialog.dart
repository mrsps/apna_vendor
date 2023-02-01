import 'package:flutter/material.dart';

// Generic dialog box showing function
void showAlert(String response, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      titlePadding: EdgeInsets.all(10),
      backgroundColor: Colors.blue.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      content: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Text(
          response,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
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
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Ok'),
          ),
        )
      ],
    ),
  );
}
