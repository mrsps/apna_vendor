import 'package:flutter/material.dart';

// Generic snack bar showing function
void showSnack(String response, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.blueGrey.withOpacity(0.7),
    content: Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        response,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.blueGrey,
            letterSpacing: 3,
            fontWeight: FontWeight.bold),
      ),
    ),
  ),);
}