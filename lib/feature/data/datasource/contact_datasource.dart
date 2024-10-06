import 'package:chattick/feature/data/model/contact_model.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactDataSource {
  Future<List<ContactModel>> fetchingContacts() async {
    if (await FlutterContacts.requestPermission()) {
      try {
        List<Contact> fetchedContacts = await FlutterContacts.getContacts(withProperties: true);
        return fetchedContacts.map((contact) => ContactModel.fromContact(contact)).toList();
      } catch (e) {
        print('Error fetching contacts: $e');
        return [];
      }
    } else {
      print('Permission to access contacts was denied');
      return [];
    }
  }
}
