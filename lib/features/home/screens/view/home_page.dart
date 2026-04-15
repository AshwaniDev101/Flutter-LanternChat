import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lanternchat/core/theme/app_colors.dart';
import 'package:lanternchat/features/chat/screens/view/chat_page.dart';
import 'package:lanternchat/features/contact/screens/view/contact_page.dart';
import 'package:lanternchat/features/conversation/screens/view/conversation_page.dart';
import 'package:lanternchat/features/conversation/screens/view/group_page.dart';
import 'package:lanternchat/features/home/screens/view/widgets/custom_navigation_bar.dart';
import 'package:lanternchat/features/profile/screens/view/profile_page.dart';
import 'package:lanternchat/features/qr/screens/view/qr_page.dart';
import 'package:lanternchat/features/settings/screens/view/settings_page.dart';
import 'package:lanternchat/models/conversations/conversation_entry.dart';

import '../../../../core/router/router_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  ConversationEntry? _selectedConversation;

  // late final List<Widget> _pages;


  // @override
  // void initState() {
  //   super.initState();
  //
  //   _pages = [
  //     ConversationPage(
  //       onConversationTap: (entry) {
  //         if (kIsWeb) {
  //           setState(() {
  //             _selectedConversation = entry;
  //           });
  //         } else {
  //           context.push(AppRoute.chat, extra: entry);
  //         }
  //       },
  //     ),
  //     ContactPage(),
  //     QrCodePage(),
  //     SettingsPage(),
  //   ];
  // }

  List<Widget> _buildPages() {
    return [
      ConversationPage(
        onConversationTap: (entry) {
          if (kIsWeb) {
            setState(() {
              _selectedConversation = entry;
            });
          } else {
            context.push(AppRoute.chat, extra: entry);

          }
        },
      ),
      ContactPage(),
      QrCodePage(),
      SettingsPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isWeb = kIsWeb;

    return Scaffold(body: isWeb ? _webLayout() : _mobileLayout());
  }



  // Mobile layout
  Widget _mobileLayout() {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _buildPages()),
      bottomNavigationBar: _bottomBar(),
    );
  }

  // Web layout
  double _panelWidth = 400;

  double _startX = 0;
  double _startWidth = 400;
  bool _isDragging = false;

  Widget _webLayout() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;

        if (_panelWidth == 400) {
          _panelWidth = (maxWidth * 0.3).clamp(400, 800);
        }

        return Row(
          children: [
            CustomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() => _currentIndex = index);
              },
            ),

            // const VerticalDivider(width: 1),
            SizedBox(
              width: _panelWidth,
              child: IndexedStack(index: _currentIndex, children: _buildPages()),
            ),

            Listener(
              onPointerDown: (event) {
                _isDragging = true;
                _startX = event.position.dx;
                _startWidth = _panelWidth;
              },
              onPointerMove: (event) {
                if (!_isDragging) return;

                final delta = event.position.dx - _startX;

                setState(() {
                  _panelWidth = (_startWidth + delta).clamp(400, 800);
                });
              },
              onPointerUp: (_) {
                _isDragging = false;
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.resizeLeftRight,
                child: Container(
                  width: 1,
                  color: Theme.of(context).colorScheme.outlineVariant
                ),
              ),
            ),

            Expanded(
              child:  _selectedConversation==null? Scaffold(
                appBar: AppBar(),
                body:Center(child: Text("Welcome to lantern chat"))

              ): ChatPage(
                  key: ValueKey(_selectedConversation!.conversation!.conversationId.toString()),
                  conversationEntry: _selectedConversation!)
            ),
          ],
        );
      },
    );
  }

  // Widget _webLayout() {
  //   return Row(
  //     children: [
  //       CustomNavigationBar(
  //         currentIndex: _currentIndex,
  //         onTap: (index) {
  //           setState(() => _currentIndex = index);
  //         },
  //       ),
  //
  //       const VerticalDivider(width: 1),
  //
  //       Expanded(
  //         child: IndexedStack(index: _currentIndex, children: _pages),
  //       ),
  //     ],
  //   );
  // }

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
