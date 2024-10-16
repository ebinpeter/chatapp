import 'package:chattick/core/colors.dart';
import 'package:chattick/feature/presentation/screen/chat.dart';
import 'package:chattick/feature/presentation/screen/contact.dart';
import 'package:chattick/feature/presentation/screen/more.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _selectedIndex = 1;

  final List<Widget> _pages = [
   const ContactsList(),
    const ChatPage(),
    const MorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: FlashyTabBar(
        backgroundColor: Coloure.BackGround,
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          FlashyTabBarItem(
            icon: const Icon(Icons.contacts),
            title: const Text('Contact'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.chat),
            title: const Text('Chat'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.more_horiz),
            title: const Text('More'),
          ),

        ],
      ),
    );
  }
}

