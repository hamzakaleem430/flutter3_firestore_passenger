import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter3_firestore_passenger/screens/tabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'sign_screen.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  String photoURL = '';
  String error = '';

  final email = TextEditingController();

  final password = TextEditingController();

  final address = TextEditingController();

  final displayName = TextEditingController();

  final lastName = TextEditingController();

  final phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              key: _scaffoldKey,

              appBar: AppBar(
                backgroundColor: Colors.lightBlue,
                elevation: 0.0,
                title: Text('Register'),
                automaticallyImplyLeading: false,
              ), //appBar
              body: Container(
                color: Colors.grey.shade200,
                child: Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 28.0, top: 7.0, right: 28.0, bottom: 7.0),
                          child: TextFormField(
                            controller: displayName,
                            decoration: InputDecoration(
                                hintText: 'Firstname', labelText: 'Firstname'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 28.0, top: 7.0, right: 28.0, bottom: 7.0),
                          child: TextFormField(
                            controller: lastName,
                            //validator: (val) => val.isEmpty ? 'Enter a Lastname' : null,
                            //decoration: textInputDecoration.copyWith(hintText: 'Lastname'),
                            decoration: InputDecoration(
                                hintText: 'Lastname', labelText: 'Lastname'),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 28.0, top: 7.0, right: 28.0, bottom: 7.0),
                          child: TextFormField(
                            controller: address,
                            //validator: (val) => val.isEmpty ? 'Enter a Address' : null,
                            //decoration: textInputDecoration.copyWith(hintText: 'Address'),
                            decoration: InputDecoration(
                                hintText: 'Address', labelText: 'Address'),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 28.0, top: 7.0, right: 28.0, bottom: 7.0),
                          child: TextFormField(
                            controller: phone,
                            decoration: InputDecoration(
                                hintText: 'Phonenumber',
                                labelText: 'Phonenumber'),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 28.0, top: 7.0, right: 28.0, bottom: 7.0),
                          child: TextFormField(
                            controller: email,
                            decoration: InputDecoration(
                                hintText: 'Email', labelText: 'Email'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 28.0, top: 7.0, right: 28.0, bottom: 7.0),
                          child: TextFormField(
                            controller: password,
                            //validator: (val) => val.isEmpty ? 'Enter a Password' : null,
                            obscureText: true,
                            //decoration: textInputDecoration.copyWith(hintText: 'Password'),
                            decoration: InputDecoration(
                                hintText: 'Password', labelText: 'Password'),
                          ),
                        ),

                        Text(
                          error,
                          style: TextStyle(
                              color: Colors.lightGreen.shade700, fontSize: 7.0),
                        ), //text

                        Column(
                          children: <Widget>[
                            ButtonTheme(
                              minWidth: 320.0,
                              height: 45.0,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0)),
                                color: Colors.lightBlue,
                                onPressed: () async {
                                  // widget.toggleView();

                                  FirebaseAuth.instance
                                      .authStateChanges()
                                      .listen((User? user) async {
                                    if (user == null) {
                                      try {
                                        UserCredential userCredential =
                                            await FirebaseAuth.instance
                                                .createUserWithEmailAndPassword(
                                                    email: email.text,
                                                    password: password.text);
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'weak-password') {
                                          print(
                                              'The password provided is too weak.');
                                        } else if (e.code ==
                                            'email-already-in-use') {
                                          print(
                                              'The account already exists for that email.');
                                        }
                                      } catch (e) {
                                        print(e);
                                      }
                                    } else {
                                      var currentUser =
                                          FirebaseAuth.instance.currentUser;

                                      CollectionReference? users =
                                          FirebaseFirestore.instance
                                              .collection('users');

                                      return users.doc(currentUser?.uid).set({
                                        "id": currentUser!.uid,
                                        "displayName": displayName.text,
                                        "name": displayName.text,
                                        "lastName": lastName.text,
                                        "address": address.text,
                                        "phone": phone.text,
                                        "email": email.text,
                                        "photoURL":
                                            "https://firebasestorage.googleapis.com/v0/b/my-uber-taxi.appspot.com/o/users%2FNb1wBH4QIDQ5hlRld2T7HvXJvSU2?alt=media&token=68a85266-0423-40be-854e-3c87d2d30bc3",
                                      }).then((value) {
                                        print("User Added");
                                      }).catchError((error) =>
                                          print("Failed to add user: $error"));
                                    }
                                  });
                                },
                                child: Text('Register',
                                    style: TextStyle(color: Colors.white)),
                              ), //rec
                            ), //flat
                          ], //widget
                        ), //column

                        Divider(),

                        Column(
                          children: <Widget>[
                            ButtonTheme(
                              minWidth: 320.0,
                              height: 45.0,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0)),
                                onPressed: () async {
                                  //widget.toggleView();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignScreen()));
                                },
                                child: Text('Back to Login',
                                    style: TextStyle(color: Colors.lightBlue)),
                              ), //rec
                            ), //flat
                          ], //widget
                        ), //column
                      ],
                    ),
                  ),
                ),
              ), //textform
            );
          }

          return TabsScreen();
        });
  }
}
