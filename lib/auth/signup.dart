// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, avoid_print, unused_local_variable, body_might_complete_normally_nullable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Theme/color.dart';
import '../components/coustombuttonath.dart';

import '../components/textformfildwidget.dart';
import '../test.dart';

class Singup extends StatefulWidget {
  const Singup({super.key});

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
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
                    height: 10,
                  ),
                  Text(
                    "Create Account",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 10,
                  ),
                  Text(
                    "Hi wellcome back you’re been missed",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Container(
                    height: 30,
                  ),
                  Textformfildwidget(
                    lable: "Name",
                    mycontroler: username,
                    hinttext: "Enter your Name",
                    validator: (val) {
                      if (val == "") {
                        return "Can't To be Empty";
                      }
                    },
                  ),
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
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CoustomButtonAuth(
                title: "Sign Up",
                onPressed: () async {
                  if (formState.currentState!.validate()) {
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email.text,
                        password: password.text,
                      );

                      // إرسال رسالة التحقق
                      FirebaseAuth.instance.currentUser!
                          .sendEmailVerification();

                      // الانتقال إلى صفحة تسجيل الدخول
                      Get.snackbar(
                        "Success",
                        "Account created successfully! Please check your email to verify your account.",
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                      Get.offNamed("/login");
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        showErrorDialog(
                            context,
                            "Error",
                            "The password provided is too weak.",
                            Icons.error,
                            Colors.red);
                      } else if (e.code == 'email-already-in-use') {
                        showErrorDialog(
                            context,
                            "Error",
                            "The account already exists for that email.",
                            Icons.error,
                            Colors.red);
                      }
                    } catch (e) {
                      print(e);
                    }
                  } else {
                    print("Not Valid");
                  }
                }),

            Container(
              height: 50,
            ),
            // Text(
            //   "Don't have An Account? Resister",
            //   textAlign: TextAlign.center,
            // ),
            InkWell(
              onTap: () {
                Get.toNamed('/login');
              },
              child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(children: [
                    TextSpan(text: "Already have an account? "),
                    TextSpan(
                        text: "Login",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        )),
                  ])),
            )
          ],
        ),
      ),
    );
  }
}
