// import 'dart:typed_data';
// import 'package:chattick/feature/domain/entities/contact.dart';
// import 'package:flutter_contacts/contact.dart';
//
// class ContactModel extends ContactEntity {
//   final Uint8List image;
//
//   ContactModel({
//     required String displayname,
//     required String phoneNumber,
//     required this.image,
//   }) : super(displayname: displayname, phoneNumber: phoneNumber,image: image);
//
//   factory ContactModel.fromContact(Contact contact) {
//     return ContactModel(
//       displayname: contact.displayName,
//       phoneNumber: contact.phones.isNotEmpty ? contact.phones.first.number : 'No Number',
//       image:  (contact.photo as Uint8List?) ?? Uint8List(0)
//     );
//   }
// }
