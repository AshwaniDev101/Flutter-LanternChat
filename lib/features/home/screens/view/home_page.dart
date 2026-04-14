import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lanternchat/core/theme/app_colors.dart';
import 'package:lanternchat/features/contact/screens/view/contact_page.dart';
import 'package:lanternchat/features/conversation/screens/view/conversation_page.dart';
import 'package:lanternchat/features/conversation/screens/view/group_page.dart';
import 'package:lanternchat/features/home/screens/view/widgets/custom_navigation_bar.dart';
import 'package:lanternchat/features/profile/screens/view/profile_page.dart';
import 'package:lanternchat/features/qr/screens/view/qr_page.dart';
import 'package:lanternchat/features/settings/screens/view/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    ConversationPage(),
    ContactPage(),
    // GroupsPage(),
    QrCodePage(),
    // ProfilePage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final isWeb = kIsWeb;

    return Scaffold(body: isWeb ? _webLayout() : _mobileLayout());
  }

  // Mobile layout
  Widget _mobileLayout() {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: _bottomBar(),
    );
  }

  // Web layout
  Widget _webLayout() {
    return Row(
      children: [
        CustomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() => _currentIndex = index);
          },
        ),

        const VerticalDivider(width: 1),

        Expanded(
          child: IndexedStack(index: _currentIndex, children: _pages),
        ),
      ],
    );
  }

  Widget _bottomBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.muteColor,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
        BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Contacts'),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'QR Code'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],

      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
