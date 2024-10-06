import 'package:chattick/core/textstyle.dart';
import 'package:chattick/feature/presentation/bloc/contact/contacts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
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
  List<Contact> contacts = [];
  List<Contact> filteredContacts = [];
  bool isSearching = false;
  @override
  void initState() {
    _fetchContacts();
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

  Future<void> _fetchContacts() async {
    if (await FlutterContacts.requestPermission()) {
      List<Contact> fetchedContacts = await FlutterContacts.getContacts(withProperties: true);
      setState(() {
        contacts = fetchedContacts;
        filteredContacts = contacts;
      });
    }
  }

  void _filterContacts() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredContacts = contacts
          .where((contact) =>
          contact.displayName.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Coloure().BackGround,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Coloure().BackGround,
        title:Row(
          children: [
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: isSearching
                    ? CustomTextField(
                  labelText: "Search",
                  controller: searchController,
                  isRequired: false,
                  height: MediaQueryUtil.heightPercentage(context, 6),
                  width: MediaQueryUtil.widthPercentage(context, 90),
                )
                    : const Text(
                  "Contacts",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            IconButton(
              icon: Icon(isSearching ? Icons.clear : Icons.search, color: Colors.black),
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                  if (!isSearching) {
                    searchController.clear();
                    filteredContacts = contacts;
                  }
                });
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isPortrait = constraints.maxHeight > constraints.maxWidth;

            return BlocBuilder<ContactsBloc, ContactsState>(
              builder: (context, state) {
                if (state is ContactLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ContactError) {
                  return Center(child: Text(state.message));
                } else if (state is ContactLoaded) {
                  final contacts = state.contats;
                  return ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      final contact = contacts[index];
                      return ListTile(
                        title: Text(contact.displayname),
                      );
                    },
                  );
                }
                return const Center(child: Text("No contacts found"));
              },
            );

            //   Padding(
            //   padding: EdgeInsets.all(
            //     isPortrait
            //         ? MediaQueryUtil.widthPercentage(context, 2)
            //         : MediaQueryUtil.widthPercentage(context, 2),
            //   ),
            //   child: Column(
            //     children: [
            //
            //       Expanded(
            //         child: filteredContacts.isEmpty
            //             ? const Center(child: CircularProgressIndicator())
            //             : ListView.builder(
            //           itemCount: filteredContacts.length,
            //           itemBuilder: (context, index) {
            //             final contact = filteredContacts[index];
            //             return ListTile(
            //               leading: CircleAvatar(
            //                 child: Text(contact.displayName[0]),
            //               ),
            //               title: Text(
            //                 contact.displayName,
            //                 style:style.UserName(context)
            //               ),
            //               onTap: () {
            //                 // Handle contact tap
            //               },
            //             );
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // );
          },
        ),
      ),
    );
  }
}
