import 'package:chattick/core/firebase_const.dart';
import 'package:chattick/core/textstyle.dart';
import 'package:chattick/feature/presentation/bloc/contact/contacts_bloc.dart';
import 'package:chattick/feature/presentation/screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:googleapis/servicecontrol/v2.dart';
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
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    context.read<ContactsBloc>().add(fetchContactevent());
    searchController.addListener((){
      setState(() {});
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }


  List<Map<String, dynamic>> _filterContacts(List<Map<String, dynamic>> contacts) {
    final query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      return contacts;
    }
    return contacts.where((contact) {
      return contact['firstName'] != null && contact['firstName'].toLowerCase().contains(query);
    }).toList();
  }

  String ChatRoomID(String? user1,String? user2){
    if(user1![0].toLowerCase().codeUnits[0]>user2![0].toLowerCase().codeUnits[0]){
      return "$user1$user2";
    }else{
      return "$user1$user2";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Coloure.BackGround,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Coloure.BackGround,
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

            return BlocBuilder<ContactsBloc,ContactsState>(
                builder: (context, state) {
                  if(state is ContactLoading ){
                    return const Center(child: CircularProgressIndicator());
                  }if(state is ContactError){
                    return  Text(state.message);
                  }if(state is ContactLoaded){
                   final  filteredContacts = _filterContacts(state.users);
                    return ListView.builder(
                      itemCount: filteredContacts.length,
                      itemBuilder: (BuildContext context,index) {
                        final contact = filteredContacts[index];
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text(contact["firstName"].isNotEmpty?contact["firstName"][0]:""),
                          ),
                          title: Text(
                           contact["firstName"],
                            style: style.UserName(context),
                          ),
                          onTap: () {
                            String roomID = ChatRoomID(firebaseAuth.currentUser?.displayName, contact["firstName"]);

                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                ChatScreen(userMap:contact, chatRoomId: roomID,),
                            ));
                          },
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
