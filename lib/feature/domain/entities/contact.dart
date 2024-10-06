
import 'dart:typed_data';

class ContactEntity {
  final String displayname;
  final String phoneNumber;
  final Uint8List? image;

  ContactEntity({
    required this.displayname,
    required this.phoneNumber,
    required this.image,
  });
}

