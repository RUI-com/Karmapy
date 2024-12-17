// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously, body_might_complete_normally_nullable, unnecessary_nullable_for_final_variable_declarations

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Theme/color.dart';
import 'package:get/get.dart';

import '../components/coustombuttonath.dart';

import '../components/textformfildwidget.dart';
import '../test.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return;
    }
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Get.offAllNamed("/homepage");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 5,
                  ),
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 10,
                  ),
                  Text(
                    "Login to continue using the app",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 40),
                  Textformfildwidget(
                    lable: "Email",
                    mycontroler: email,
                    hinttext: "Enter your email",
                    validator: (val) {
                      if (val == "") {
                        return "Can't To be Empty";
                      }
                    },
                  ),
                  Textformfildwidget(
                    lable: "Password",
                    mycontroler: password,
                    hinttext: "Enter your password",
                    isPassword: true,
                    validator: (val) {
                      if (val == "") {
                        return "Can't To be Empty";
                      }
                    },
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () async {
                        if (email.text == "") {
                          showErrorDialog(
                              context,
                              "Error",
                              "Enter email to reset password",
                              Icons.info,
                              Colors.red);
                          return;
                        }

                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: email.text);
                        showErrorDialog(
                            context,
                            "Info",
                            "Go to email to reset password",
                            Icons.info,
                            Colors.blue);
                      },
                      child: Text(
                        'forgot password?',
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            CoustomButtonAuth(
              title: "Login",
              onPressed: () async {
                if (formState.currentState!.validate()) {
                  try {
                    final credential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email.text, password: password.text);
                    if (credential.user!.emailVerified) {
                      Get.offAllNamed("/homepage");
                    } else {
                      FirebaseAuth.instance.currentUser!
                          .sendEmailVerification();
                      showErrorDialog(
                          context,
                          "Info",
                          "Verify Your Email Address to Activate Your Account",
                          Icons.info,
                          Colors.blue);
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      Get.snackbar("Error", "No user found for that email.");
                    } else if (e.code == 'wrong-password') {
                      showErrorDialog(
                          context,
                          "Error",
                          "Wrong password provided for that user.",
                          Icons.error,
                          Colors.red);
                    } else {
                      showErrorDialog(
                          context,
                          "Error",
                          "An unknown error occurred.",
                          Icons.error,
                          Colors.red);
                    }
                  }
                } else {
                  print("Not Valid");
                }
              },
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Or Sign in with',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            // Social media icons

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(70)),
                    child: Center(
                        child: Image.asset(
                      "assets/logo/3.png",
                      height: 20,
                    )),
                  ),
                ),
                // Google
                InkWell(
                  onTap: () {
                    signInWithGoogle();
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(70)),
                    child: Center(
                        child: Image.asset(
                      "assets/logo/4.png",
                      height: 20,
                    )),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(70)),
                    child: Center(
                        child: Image.asset(
                      "assets/logo/2.png",
                      height: 20,
                    )),
                  ),
                ),
              ],
            ),
            Container(
              height: 20,
            ),
            // Text(
            //   "Don't have An Account? Resister",
            //   textAlign: TextAlign.center,
            // ),
            InkWell(
              onTap: () {
                Get.toNamed('/signup');
              },
              child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(children: [
                    TextSpan(text: "Don't have An Account? "),
                    TextSpan(
                        text: "sign up",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        )),
                  ])),
            ),
          ],
        ),
      ),
    );
  }
}
