import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/features/chat/provider/typing_provider.dart';
import 'package:lanternchat/features/chat/screens/view/widgets/chat_bubble.dart';
import 'package:lanternchat/models/messages/message.dart';
import 'package:lanternchat/models/users/contact.dart';

import '../../../../../models/conversations/conversation_tile.dart';

class _ServiceConstants {
  static const String uid = 'uid';
}

class TypingIndicator extends ConsumerStatefulWidget {
  final String conversationId;
  final String uid;

  const TypingIndicator({required this.conversationId, required this.uid, super.key});

  @override
  ConsumerState<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends ConsumerState<TypingIndicator> {
  Timer? _typingTimer;
  bool _isTyping = false;
  String _typingUid = '';

  @override
  void initState() {
    super.initState();

    ref.listenManual(
      typingStreamProvider(TypingTo(conversationId: widget.conversationId, uid: widget.uid)),
      (previous, next) {
        next.whenData((event) {
          final raw = event.snapshot.value;
          if (raw == null) return;

          final typingMap = Map<String, dynamic>.from(raw as Map);
          _typingUid = typingMap[_ServiceConstants.uid] as String;
          _startTypingTimer('');
        });
      },
      fireImmediately: true, // important → behaves like initial watch
    );
  }

  @override
  Widget build(BuildContext context) {
    // final participantStream = ref.watch(participantStreamProvider(contact.conversationId));

    if (_isTyping && !_typingUid.contains(widget.uid)) {

      // return TypingDots();
      return LeftChatBubble(child: TypingDots(),);
      // return const Icon(Icons.more_horiz_rounded);
    } else {
      return const SizedBox();
    }
  }

  void _startTypingTimer(String uid) {
    _typingTimer?.cancel();

    setState(() {
      _isTyping = true;
    });

    _typingTimer = Timer(const Duration(seconds: 1), () {
      if (!mounted) return;

      setState(() {
        _isTyping = false;
        print('### _isTyping = false;');
      });
    });
  }
}


class TypingDots extends StatefulWidget {
  const TypingDots({super.key});

  @override
  State<TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<TypingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDot(double delay) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double progress = (_controller.value + delay) % 1;

        double scale = 0.5 + (progress * 0.5);

        return Transform.scale(
          scale: scale,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: CircleAvatar(
              radius: 3,
              backgroundColor: Colors.black54,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDot(0.0),
        _buildDot(0.2),
        _buildDot(0.4),
      ],
    );
  }
}