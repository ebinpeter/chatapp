import 'package:chattick/config/firebase_setting/access_firebase_token.dart';
import 'package:chattick/config/firebase_setting/firebase_messaging.dart';
import 'package:chattick/core/firebase_const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../feature/presentation/screen/details_page.dart';
import '../../feature/presentation/screen/otp_page.dart';

class FirebaseApi extends GetxController {
  Rx<String?> authVerificationId = Rx<String?>(null);
  RxBool isCodeSent = false.obs;
  RxBool isLoading = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to send OTP
  Future<void> sendOTP(
      {required String phoneNumber, required BuildContext context}) async {
    isLoading.value = true; // Set loading state to true

    try {
      // User? currentUser = FirebaseAuth.instance.currentUser;
      // if (currentUser != null) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text('User is already Login')),
      //   );
      //   isLoading.value = false;
      //   return;
      // }
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            await _auth.signInWithCredential(credential);
            print(
                'Phone number automatically verified and user signed in: ${_auth.currentUser}');
          } catch (e) {
            print("Error during automatic sign-in: $e");
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Phone number verification failed: ${e.message}');
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Verification failed: ${e.message}')));
          isLoading.value = false;
        },
        codeSent: (String verificationId, int? resendToken) {
          authVerificationId.value = verificationId;
          isCodeSent.value = true;
          isLoading.value = false;

          print('Verification code sent to $phoneNumber');
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('OTP sent to $phoneNumber')));
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
      isLoading.value = false; // Stop loading on error
      rethrow;
    }
  }

  Future<void> verifyOTP(
      {required String otp,
      required BuildContext context,
      authVerificationIdss}) async {
    if (authVerificationIdss == null) {
      print("Verification ID is null. Please resend the OTP.");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Verification ID is null. Please resend the OTP.')));
      return;
    }

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: authVerificationIdss!,
      smsCode: otp,
    );

    try {
      await _auth.signInWithCredential(credential);
      print("Phone verification successful.");
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Phone verification successful')));
      SharedPreferences sprf = await SharedPreferences.getInstance();
      sprf.setBool("isLogin", true);
      FirebaseCM().sendTopicNotification('notification', "Welcome to Chattick!", "Thank you for joining! Start chatting with your friends and stay connected.");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsPage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      print("Invalid OTP: ${e.message}");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid OTP: ${e.message}')));
    }
  }

  Future<void> updateUserDetails(
      String firstName, String lastName, String imageUrl) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userId = user.uid;
      DocumentReference userDoc =
          FirebaseFirestore.instance.collection('users').doc(userId);
      SharedPreferences pref = await SharedPreferences.getInstance();
     String? phone =  pref.getString("phoneNo");
      try {
        String accessToken = await AccessTokenFirebase().getAccessToke();
        DocumentSnapshot docSnapshot = await userDoc.get();

        if (docSnapshot.exists) {
          await userDoc.set({
            'firstName': firstName,
            'lastName': lastName,
            'imageUri':imageUrl,
            'device_token':accessToken,
            "uid":firebaseAuth.currentUser!.uid,
            "phone":phone??"",
            "message":"",
            "isOnline":true,
            "date":""
          });
          print('User details updated successfully');
        } else {
          print('Document not found, creating a new one');
          await userDoc.set({
            'firstName': firstName,
            'lastName': lastName,
            'imageUri':imageUrl,
            'device_token':accessToken,
            "uid":firebaseAuth.currentUser!.uid,
            "phone":phone??"",
            "message":"",
            "isOnline":true,
            "date":""
          });
          print('User details created successfully');
        }
      } catch (e) {
        print('Failed to update user details: $e');
      }
    } else {
      print('No authenticated user found');
    }
  }

  Future<bool> isLogincheck() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var login = pref.getBool("isLogin") ?? false;
    return login;
  }

  static getuser()async{
    await firestore.collection("users").snapshots();
  }
static  Future<DocumentSnapshot?> fetchCurrentUser() async {
  try {
    final String currentUserId = firebaseAuth.currentUser!.uid;
    final userSnapshot = await firestore.collection('users').doc(currentUserId).get();
    if (userSnapshot.exists) {
      print('Current user data fetched: ${userSnapshot.data()}');
      return userSnapshot;
    } else {
      print('No user found with the current UID.');
      return null;
    }
  } catch (e) {
    print('Error fetching current user: $e');
    return null;
  }
}
}
