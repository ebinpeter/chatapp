import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../feature/presentation/screen/details_page.dart';
import '../feature/presentation/screen/otp_page.dart';

class FirebaseApi extends GetxController {
  // Use Rx variables for reactive state management in GetX
  Rx<String?> authVerificationId = Rx<String?>(null);
  RxBool isCodeSent = false.obs;
  RxBool isLoading = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to send OTP
  Future<void> sendOTP({required String phoneNumber, required BuildContext context}) async {
    isLoading.value = true;  // Set loading state to true

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Automatic verification
          try {
            await _auth.signInWithCredential(credential);
            print('Phone number automatically verified and user signed in: ${_auth.currentUser}');
          } catch (e) {
            print("Error during automatic sign-in: $e");
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Phone number verification failed: ${e.message}');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Verification failed: ${e.message}')));
          isLoading.value = false;  // Stop loading if verification failed
        },
        codeSent: (String verificationId, int? resendToken) {
          // Store the verification ID to use later in OTP verification
          authVerificationId.value = verificationId;  // Update the reactive variable
          isCodeSent.value = true;
          isLoading.value = false;

          print('Verification code sent to $phoneNumber');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('OTP sent to $phoneNumber')));

          // Navigate to OTP verification page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpPage(verificationId: verificationId),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle timeout after 60 seconds
          authVerificationId.value = verificationId;
          print('Auto retrieval timeout');
        },
      );
    } catch (e) {
      print("Error during phone number verification: $e");
      isLoading.value = false;  // Stop loading on error
      rethrow;
    }
  }

  // Function to verify the OTP entered by the user
  Future<void> verifyOTP({required String otp, required BuildContext context,authVerificationIdss}) async {
    if (authVerificationIdss == null) {
      print("Verification ID is null. Please resend the OTP.");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Verification ID is null. Please resend the OTP.')));
      return;
    }

    // Create credential using the verificationId and OTP entered by the user
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: authVerificationIdss!,
      smsCode: otp,
    );

    try {
      // Sign in with the generated credential
      await _auth.signInWithCredential(credential);
      print("Phone verification successful.");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Phone verification successful')));

      // Navigate to home page or desired screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>DetailsPage(),
        ),
      );    } on FirebaseAuthException catch (e) {
      print("Invalid OTP: ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid OTP: ${e.message}')));
    }
  }


}
