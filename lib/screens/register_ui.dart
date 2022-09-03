import 'package:flutter/material.dart';
import 'package:flutter3_firestore_passenger/screens/login_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter3_firestore_passenger/screens/tabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'sign_screen.dart';

class RegisterUI extends StatefulWidget {
  RegisterUI({Key? key}) : super(key: key);

  @override
  State<RegisterUI> createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> {
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
              backgroundColor: Colors.black,
              // appBar: AppBar(
              //   backgroundColor: Colors.lightBlue,
              //   elevation: 0.0,
              //   title: Text('Register'),
              //   automaticallyImplyLeading: false,
              // ), //appBar
              body: SingleChildScrollView(
                reverse: true,
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontFamily: 'bold',
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Create a new account',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'medium',
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: displayName,
                                decoration: InputDecoration(
                                  hintText: 'Firstname',
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(Icons.person_outline),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(25)),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: lastName,
                                decoration: InputDecoration(
                                  hintText: 'Lastname',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(25)),
                                  prefixIcon: Icon(Icons.person_rounded),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: address,
                                decoration: InputDecoration(
                                  hintText: 'Address',
                                  prefixIcon: Icon(Icons.home),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(25)),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: phone,
                                decoration: InputDecoration(
                                  hintText: 'Phonenumber',
                                  prefixIcon: Icon(Icons.phone),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(25)),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: email,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  prefixIcon: Icon(Icons.email_outlined),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(25)),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                obscureText: true,
                                controller: password,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  prefixIcon: Icon(Icons.lock_outline),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(25)),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                child: const Text(
                                  "Sign up",
                                  style: TextStyle(fontFamily: 'semi-bold'),
                                ),
                                onPressed: () async {
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
                                  // Navigator.push(
                                  //     context,
                                  //     new MaterialPageRoute(
                                  //         builder: (context) => phoneVerification()));
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context).primaryColor,
                                  onPrimary: Colors.white,
                                  minimumSize: const Size.fromHeight(60),
                                  // padding: EdgeInsets.symmetric(horizontal: 70, vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              // Center(
                              //   child: RichText(
                              //     textAlign: TextAlign.center,
                              //     text: TextSpan(
                              //       text:
                              //           'By continuing Sign up ypu agree to the following ',
                              //       style: TextStyle(
                              //           color: Colors.black,
                              //           fontSize: 12,
                              //           fontFamily: 'regular'),
                              //       children: <TextSpan>[
                              //         TextSpan(
                              //           text: ' Terms & Conditions',
                              //           style: TextStyle(
                              //               fontFamily: 'semi-bold',
                              //               color: Colors.deepOrange),
                              //         ),
                              //         TextSpan(
                              //           text: ' without reservation',
                              //           style: TextStyle(
                              //               color: Colors.black,
                              //               fontSize: 12,
                              //               fontFamily: 'regular'),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                color: Colors.grey.shade600,
                padding: EdgeInsets.all(16),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginUI()));
                  },
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Already have an account?',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'regular'),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Sign in',
                            style: TextStyle(
                              fontFamily: 'semi-bold',
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            )),
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

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.deepOrange.shade300,
  //     body: _buildBody(),
  //     bottomNavigationBar: Container(
  //       color: Colors.deepOrange.shade100,
  //       padding: EdgeInsets.all(16),
  //       child: InkWell(
  //         onTap: () {
  //           Navigator.push(
  //               context, MaterialPageRoute(builder: (context) => LoginUI()));
  //         },
  //         child: RichText(
  //           textAlign: TextAlign.center,
  //           text: TextSpan(
  //             text: 'Already have an account?',
  //             style: TextStyle(
  //                 color: Colors.black, fontSize: 16, fontFamily: 'regular'),
  //             children: <TextSpan>[
  //               TextSpan(
  //                   text: 'Sign in',
  //                   style: TextStyle(
  //                       fontFamily: 'semi-bold', color: Colors.deepOrange)),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildBody() {
    return SingleChildScrollView(
      reverse: true,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'bold',
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Create a new account',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'medium',
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Firstname',
                      prefixIcon: Icon(Icons.person_outline),
                      border: InputBorder.none,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Lastname',
                      prefixIcon: Icon(Icons.person_rounded),
                      border: InputBorder.none,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Address',
                      prefixIcon: Icon(Icons.home),
                      border: InputBorder.none,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Phonenumber',
                      prefixIcon: Icon(Icons.phone),
                      border: InputBorder.none,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: InputBorder.none,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock_outline),
                        border: InputBorder.none),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text(
                      "Sign up",
                      style: TextStyle(fontFamily: 'semi-bold'),
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (context) => phoneVerification()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrange,
                      onPrimary: Colors.white,
                      minimumSize: const Size.fromHeight(60),
                      // padding: EdgeInsets.symmetric(horizontal: 70, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // Center(
                  //   child: RichText(
                  //     textAlign: TextAlign.center,
                  //     text: TextSpan(
                  //       text:
                  //           'By continuing Sign up ypu agree to the following ',
                  //       style: TextStyle(
                  //           color: Colors.black,
                  //           fontSize: 12,
                  //           fontFamily: 'regular'),
                  //       children: <TextSpan>[
                  //         TextSpan(
                  //           text: ' Terms & Conditions',
                  //           style: TextStyle(
                  //               fontFamily: 'semi-bold',
                  //               color: Colors.deepOrange),
                  //         ),
                  //         TextSpan(
                  //           text: ' without reservation',
                  //           style: TextStyle(
                  //               color: Colors.black,
                  //               fontSize: 12,
                  //               fontFamily: 'regular'),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
