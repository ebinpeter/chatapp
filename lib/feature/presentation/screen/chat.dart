import 'package:chattick/core/colors.dart';
import 'package:chattick/core/firebase_const.dart';
import 'package:chattick/core/media_query.dart';
import 'package:chattick/feature/presentation/bloc/chat/chat_bloc.dart';
import 'package:chattick/feature/presentation/screen/chat_screen.dart';
import 'package:chattick/feature/presentation/widget/textfeild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController search_Controller = TextEditingController();

  @override
  void initState() {
    context.read<ChatBloc>().add(LoadedChat());
    context.read<ChatBloc>().add(LoadCurrentUser());  // Fetch the current user


    // TODO: implement initState
    super.initState();
  }

  String chatroomID(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] > user2.toLowerCase().codeUnits[0]) {
      return "$user2$user1";
    } else {
      return "$user1$user2";
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Chats", style: TextStyle(color: Coloure.AppBarText)),
        backgroundColor: Coloure.BackGround,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Coloure.AppBarText),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.list, color: Coloure.AppBarText),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Coloure.BackGround,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isPortrait = constraints.maxHeight > constraints.maxWidth;

          return isPortrait
              ? _buildPortraitUI(context)
              : _buildLandscapeUI(context);
        },
      ),
    );
  }

  Widget _buildPortraitUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 90,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildStoryAvatar("Your Story", Icons.add),
                _buildStoryAvatar("Midala Hu", Icons.image),
                _buildStoryAvatar("Salsabila", Icons.person),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomTextField(
            labelText: "search here",
            controller: search_Controller,
            height: MediaQueryUtil.heightPercentage(context, 6),
            width: MediaQueryUtil.widthPercentage(context, 90),
          ),
        ),
        Expanded(
          child: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is UserError) {
                return Center(
                  child: Text(state.message),
                );
              }
              if (state is UserLoaded&&  state is  CurrentUserLoaded) {
                final currentUser = (state as CurrentUserLoaded).currentUser;
                final chats = (state as UserLoaded).chats;
                return ListView.builder(
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    var curerentuser = currentUser;
                    var chat = chats[index];
                    return _buildChatTile(
                        chat['name'],
                        chat['message'],
                        chat['date'],
                        chat['isOnline'],
                        curerentuser
                    );
                  },
                );
              } else {
                return const Center(child: Text('No chats available'));
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeUI(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 90,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildStoryAvatar("Your Story", Icons.add),
                      _buildStoryAvatar("Midala Hu", Icons.image),
                      _buildStoryAvatar("Salsabila", Icons.person),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Coloure.FeildText,
                    filled: true,
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    if (state is UserLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is UserError) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    if (state is UserLoaded &&  state is  CurrentUserLoaded) {
                      final currentUser = (state as CurrentUserLoaded).currentUser; // Get current user data
                      final chats = (state as UserLoaded).chats;
                      return ListView.builder(
                        itemCount: chats.length,
                        itemBuilder: (context, index) {
                          var curerentuser = currentUser;
                          var chat = chats[index];
                          return _buildChatTile(
                            chat['name'],
                            chat['message'],
                            chat['date'],
                            chat['isOnline'],
                            curerentuser
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text('No chats available'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            color: Coloure.FeildText,
            child: const Center(
              child: Text('Chat Details Pane (for larger screens)'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStoryAvatar(String name, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue,
            child: Icon(icon, color: Coloure.ButtonText),
          ),
          const SizedBox(height: 8),
          Text(name, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _buildChatTile(String name, String message, String date, bool isOnline,Map<String,dynamic>usermap) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text(name[0], style: const TextStyle(color: Colors.white)),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(message),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(date),
          const SizedBox(height: 4),
          const CircleAvatar(
            radius: 10,
            backgroundColor: Colors.blue,
            child:
                Text("1", style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ],
      ),
      onTap: () {
        try{
        //   Map<String,dynamic>usermap={
        //   "name":name,
        // };
        String rooid = chatroomID("ebin"!, name);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(userMap: usermap, chatRoomId: '',),
          ),
        );}catch(e){
          print("errrr:$e");
        }
      },

    );
  }
}
