import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String date;
  final String deviceToken;
  final String firstName;
  final String imageUri;
  final bool isOnline;
  final String lastName;
  final String message;
  final String phone;
  final String uid;

  UserModel({
    required this.date,
    required this.deviceToken,
    required this.firstName,
    required this.imageUri,
    required this.isOnline,
    required this.lastName,
    required this.message,
    required this.phone,
    required this.uid,
  });

  // Factory method to create a UserModel from a Firestore document
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return UserModel(
      date: data['date'] ?? '',
      deviceToken: data['device_token'] ?? '',
      firstName: data['firstName'] ?? '',
      imageUri: data['imageUri'] ?? '',
      isOnline: data['isOnline'] ?? false,
      lastName: data['lastName'] ?? '',
      message: data['message'] ?? '',
      phone: data['phone'] ?? '',
      uid: data['uid'] ?? '',
    );
  }

  // Method to convert UserModel to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'device_token': deviceToken,
      'firstName': firstName,
      'imageUri': imageUri,
      'isOnline': isOnline,
      'lastName': lastName,
      'message': message,
      'phone': phone,
      'uid': uid,
    };
  }
}
