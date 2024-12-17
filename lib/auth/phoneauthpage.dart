// ignore_for_file: unused_field, prefer_const_constructors, avoid_print, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final TextEditingController phoneController = TextEditingController();
  String? _verificationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // إدخال رقم الهاتف مع التحقق من صحة التنسيق
            InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                print(number.phoneNumber);
              },
              onInputValidated: (bool isValid) {
                print(isValid ? "Valid" : "Invalid");
              },
              initialValue: PhoneNumber(isoCode: 'GB'), // رمز البلد - سوريا
              selectorConfig: SelectorConfig(
                  selectorType:
                      PhoneInputSelectorType.DROPDOWN), // تم تعديل هذه القيمة
              ignoreBlank: false,

              textFieldController: phoneController,
              formatInput: true,
              selectorTextStyle:
                  TextStyle(color: Colors.black), // تغيير لون النص
              inputDecoration: InputDecoration(
                labelText: 'Phone Number',
                hintText: 'Enter your phone number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // تأكد من إدخال رقم الهاتف بشكل صحيح
                String phoneNumber = phoneController.text.trim();
                if (phoneNumber.isEmpty) {
                  showErrorDialog(context, "Error", "Phone number is required",
                      Icons.error, Colors.red);
                  return;
                }

                if (!phoneNumber.startsWith("+44")) {
                  phoneNumber = "+44" + phoneNumber; // تأكد من إضافة رمز البلد
                }

                try {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: phoneNumber, // رقم الهاتف مع رمز البلد
                    verificationCompleted:
                        (PhoneAuthCredential credential) async {
                      // إذا تم التحقق بنجاح تلقائيًا
                      await FirebaseAuth.instance
                          .signInWithCredential(credential);
                      Get.offAllNamed("/homepage");
                    },
                    verificationFailed: (FirebaseAuthException e) {
                      showErrorDialog(
                          context,
                          "Error",
                          e.message ?? "Verification failed",
                          Icons.error,
                          Colors.red);
                    },
                    codeSent: (String verificationId, int? resendToken) {
                      _verificationId = verificationId;
                      // إرسال رمز التحقق
                      showErrorDialog(
                          context,
                          "Info",
                          "OTP sent, check your phone",
                          Icons.info,
                          Colors.blue);
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {
                      _verificationId = verificationId;
                    },
                  );
                } catch (e) {
                  print("Error: $e");
                  showErrorDialog(
                      context,
                      "Error",
                      "An error occurred, please try again",
                      Icons.error,
                      Colors.red);
                }
              },
              child: Text('Verify Phone Number'),
            ),
          ],
        ),
      ),
    );
  }

  // دالة لعرض الرسائل
  void showErrorDialog(BuildContext context, String title, String message,
      IconData icon, Color color) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Icon(icon, color: color),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
