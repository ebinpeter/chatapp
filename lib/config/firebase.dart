import 'package:chattick/core/firebase_const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class Firebase_api{
  String? authverificationId;

  static Future<void>UpdateUserData()async{
    try{
      // DocumentSnapshot  userdoc =firestore.collection("user").doc(userId)
    }catch(e){  
      print("Error updating user data: $e");
    }
  }
  Future<void> sendOTP({required String phoneNumber, BuildContext? context}) async {
    try {

      await auth.verifyPhoneNumber(
        phoneNumber: "+91$phoneNumber",
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            await auth.signInWithCredential(credential);
          } catch (e) {
            print("Error during automatic sign-in: $e");
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          throw PlatformException(code: e.code, message: e.message);
        },
        codeSent: (String verificationId, int? resendToken) {
          authverificationId = verificationId;
          // Object?.hash('/otpVerification', extra: "+91 $phoneNumber".trim());
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          authverificationId = verificationId;
        },
      );
    } catch (e) {
      print("Error during phone number verification: $e");
    rethrow;
    }
  }

}