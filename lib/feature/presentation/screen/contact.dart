import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/colors.dart';
import '../../../core/media_query.dart';
import '../widget/textfeild.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({super.key});

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final TextEditingController searchController = TextEditingController();
  List<String> contacts = List.generate(20, (index) => 'Contact $index'); // Sample data
  List<String> filteredContacts = [];

  @override
  void initState() {
    super.initState();
    filteredContacts = contacts;
    searchController.addListener(_filterContacts);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterContacts);
    searchController.dispose();
    super.dispose();
  }

  void _filterContacts() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredContacts = contacts
          .where((contact) => contact.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Coloure().BackGround,
      appBar: AppBar(
        backgroundColor: Coloure().BackGround,
        title: Text("Contacts"),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isPortrait = constraints.maxHeight > constraints.maxWidth;

            return Padding(
              padding: EdgeInsets.all(
                isPortrait
                    ? MediaQueryUtil.widthPercentage(context, 4)
                    : MediaQueryUtil.widthPercentage(context, 2),
              ),
              child: Column(
                children: [
                  CustomTextField(
                    labelText: "Search",
                    controller: searchController,
                    isRequired: false,
                    height: MediaQueryUtil.heightPercentage(context, isPortrait ? 6 : 12),
                    width: MediaQueryUtil.widthPercentage(context, isPortrait ? 90 : 70),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredContacts.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(),

                          title: Text(
                            filteredContacts[index],
                            style: TextStyle(color: Colors.red),
                          ),
                          onTap: () {
                            // Handle contact tap
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
