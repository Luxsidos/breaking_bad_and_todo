import 'package:braking_bad_todo/ui/screens/home/homePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth _authUser = FirebaseAuth.instance;

class SmsVerifyPage extends StatelessWidget {
  SmsVerifyPage({Key? key}) : super(key: key);

  FirebaseFirestore _database = FirebaseFirestore.instance;
  var _formKey = GlobalKey<FormState>();
  String? _phoneNumberInput;
  String? _verificationId;
  String? _usernameInput;
  TextEditingController smsCode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter phone number..."),
                maxLength: 13,
                initialValue: "+998",
                validator: (e) {
                  if (e!.length != 13) {
                    return "Enter the phone number in full!";
                  }
                },
                onSaved: (e) {
                  _phoneNumberInput = e;
                },
              ),
              OutlinedButton(
                onPressed: () async {
                  await _phoneVerify(context);
                  showDialog(
                    barrierDismissible: false,
                    useSafeArea: false,
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: smsCode,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    prefixIcon: Icon(Icons.message),
                                    hintText: "SMS CODE",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                  maxLength: 6,
                                ),
                                TextButton(
                                  child: Text("CONFIRM"),
                                  onPressed: () async {
                                    PhoneAuthCredential phoneAuthCredential =
                                        PhoneAuthProvider.credential(
                                            verificationId: _verificationId!,
                                            smsCode: smsCode.text);
                                    await _authUser.signInWithCredential(
                                        phoneAuthCredential);
                                    _authUser.currentUser!
                                        .updateDisplayName(_usernameInput);
                                    await Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  "SMS",
                  style: TextStyle(color: Colors.white),
                ),
                style: OutlinedButton.styleFrom(backgroundColor: Colors.yellow),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _phoneVerify(ctx) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        _authUser.verifyPhoneNumber(
            phoneNumber: _phoneNumberInput!,
            verificationCompleted: (PhoneAuthCredential credential) {},
            verificationFailed: (FirebaseAuthException credential) {
              ScaffoldMessenger.of(ctx).showSnackBar(
                SnackBar(content: Text("Invalid Code!")),
              );
            },
            codeSent: (String verificationId, int? resendToken) async {
              _verificationId = verificationId;
            },
            codeAutoRetrievalTimeout: (String text) {
              print("TEXT $text");
            });
      } catch (e) {
        print("ERROR: $e");
      }
    }
  }

  // Future _query() async {
  //   DocumentSnapshot todoUser =
  //       await _database.collection('todo').doc('todo1').get();
  //   print(
  //       "-------------------- KELGAN TODO: " + todoUser['subject'].toString());
  // }
}
