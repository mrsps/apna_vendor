import 'package:al/dao/orderStore.dart';
import 'package:al/helpers/randomIdMaker.dart';
import 'package:al/models/consumer/consumer.dart';
import 'package:al/providers/orderManagement.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsumerDetails extends StatefulWidget {
  const ConsumerDetails({Key? key}) : super(key: key);

  @override
  _ConsumerDetailsState createState() => _ConsumerDetailsState();
}

class _ConsumerDetailsState extends State<ConsumerDetails> {
  // Details of the consumer which made an order
  String _phone = '';
  String _name = '';
  String _houseNumber = '';
  String _apartment = '';

  final _formKey = GlobalKey<FormState>();
  FocusNode _phoneFocus = FocusNode();
  FocusNode _nameFocus = FocusNode();
  FocusNode _houseFocus = FocusNode();
  FocusNode _apartFocus = FocusNode();
  bool _isLoading = false;

  // Main create order function
  void create() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String consumerId = getRandomID('Consumer');
      await OrderStore().createOrder(
          Provider.of<OrderManager>(context, listen: false).quantities,
          ConsumerAddress(
              consumerId: consumerId,
              consumerPhone: _phone,
              consumerName: _name,
              consumerHouse: _houseNumber,
              consumerApartment: _apartment),
          Provider.of<OrderManager>(context, listen: false).leaderId,
          Provider.of<OrderManager>(context, listen: false).products);
      // Cloud function to notify other users
      FirebaseFunctions.instance.httpsCallable('orderCreated').call(
        <String, dynamic>{
          "consumerName": _name,
          "items": Provider.of<OrderManager>(context, listen: false).products.length,
          "leaderId": Provider.of<OrderManager>(context, listen: false).leaderId
        },
      );
      Provider.of<OrderManager>(context, listen: false).reset();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blueGrey,
          content: (Text(
            'Order Created !!',
            textAlign: TextAlign.center,
          ))));
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      _formKey.currentState!.reset();
      FocusScope.of(context).unfocus();
    }
    setState(() {
      _isLoading = false;
    });
  }

  bool validate(String s) {
    if (s.length == 10 && double.tryParse(s) != null) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // TextField to enter the phone no.
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      onFieldSubmitted: (term) {
        FocusScope.of(context).requestFocus(_nameFocus);
      },
    );

    // TextField to enter the name
    final nameField = TextFormField(
      style: TextStyle(letterSpacing: 2, color: Colors.black54),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      focusNode: _nameFocus,
      validator: (name) => name!.length != 0 ? null : 'Required',
      onSaved: (name) => _name = name!,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          labelText: 'Name',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      onFieldSubmitted: (term) {
        FocusScope.of(context).requestFocus(_houseFocus);
      },
    );

    // TextField to enter the house no.
    final houseField = TextFormField(
      style: TextStyle(letterSpacing: 2, color: Colors.black54),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      focusNode: _houseFocus,
      validator: (house) => house!.length != 0 ? null : 'Required',
      onSaved: (house) => _houseNumber = house!,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          labelText: 'House Number',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      onFieldSubmitted: (term) {
        FocusScope.of(context).requestFocus(_apartFocus);
      },
    );

    // TextField to enter the apartment no.
    final apartField = TextFormField(
      style: TextStyle(letterSpacing: 2, color: Colors.black54),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      focusNode: _apartFocus,
      validator: (apart) => apart!.length != 0 ? null : 'Required',
      onSaved: (apart) => _apartment = apart!,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          labelText: 'Apartment Name',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      onFieldSubmitted: (term) {
        create();
      },
    );

    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        shadowColor: Colors.black,
        elevation: 20,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Create Order',
              style: TextStyle(color: Colors.white, letterSpacing: 2),
            ),
          ],
        ),
        toolbarHeight: 50,
      ),
      body: MediaQuery.of(context).size.width < 850
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/order.png',
                          height: 250,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Material(
                            elevation: 10,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    border: Border.all(color: Colors.blueGrey),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text('Enter your details',
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        letterSpacing: 3))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Material(
                            elevation: 10,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), side: BorderSide(color: Colors.blueGrey)),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: phoneField,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Material(
                            elevation: 10,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), side: BorderSide(color: Colors.blueGrey)),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: nameField,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Material(
                            elevation: 10,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), side: BorderSide(color: Colors.blueGrey)),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: houseField,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Material(
                            elevation: 10,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), side: BorderSide(color: Colors.blueGrey)),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: apartField,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: ElevatedButton(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueGrey)),
                            onPressed: () {
                              create();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                'Create Order',
                                style: TextStyle(color: Colors.white, fontSize: 25),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(100),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Image.asset('assets/order.png')),
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Material(
                                elevation: 10,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.blueGrey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      border: Border.all(color: Colors.blueGrey),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    'Enter your details',
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        letterSpacing: 3),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Material(
                                elevation: 10,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10), side: BorderSide(color: Colors.blueGrey)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: phoneField,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Material(
                                elevation: 10,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10), side: BorderSide(color: Colors.blueGrey)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: nameField,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Material(
                                elevation: 10,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10), side: BorderSide(color: Colors.blueGrey)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: houseField,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Material(
                                elevation: 10,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10), side: BorderSide(color: Colors.blueGrey)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: apartField,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: ElevatedButton(
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueGrey)),
                                onPressed: () {
                                  create();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: _isLoading
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5),
                                          child: CircularProgressIndicator(
                                            backgroundColor: Colors.white,
                                            color: Colors.blue.shade200,
                                          ),
                                        )
                                      : Text(
                                          'Create Order',
                                          style: TextStyle(color: Colors.white, fontSize: 25),
                                        ),
                                ),
                              ),
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
