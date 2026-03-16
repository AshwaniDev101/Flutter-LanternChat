import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/typing_provider.dart';
import 'chat_bubble.dart';

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


    bool firstEvent = true; // this is to prevent _startTypingTimer from triggering when listening is mounted for the very first time
    ref.listenManual(
      typingStreamProvider(widget.conversationId),
      (previous, next) {
        next.whenData((event) {
          if (firstEvent) {
            firstEvent = false;
            return;
          }

          final raw = event.snapshot.value;
          if (raw == null) return;

          print('#### Listen mounted');

          final typingMap = Map<String, dynamic>.from(raw as Map);
          _typingUid = typingMap[_ServiceConstants.uid] as String;
          _startTypingTimer();
        });
      },
      fireImmediately: false, // important → behaves like initial watch
    );
  }

  @override
  Widget build(BuildContext context) {
    // final participantStream = ref.watch(participantStreamProvider(contact.conversationId));

    if (_isTyping && !_typingUid.contains(widget.uid)) {
      // return TypingDots();
      return LeftChatBubble(child: TypingDots());
      // return const Icon(Icons.more_horiz_rounded);
    } else {
      return const SizedBox();
    }
  }

  void _startTypingTimer() {
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

// SingleTickerProviderStateMixin allows this widget to provide a "ticker"
// A ticker sends frame updates (about 60fps) to drive animations
class _TypingDotsState extends State<TypingDots> with SingleTickerProviderStateMixin {

  // controls the progress of the animation (0 to 1)
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(
            // vsync prevents animations from running when the screen is not visible, it can saves battery and CPU
            vsync: this,

            // Duration of one full animation cycle
            // After 900ms it goes from 0 → 1
            duration: const Duration(milliseconds: 900),
          )
          // "..repeat()" makes the animation loop forever
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Builds a single animated dot
  // "delay" offsets the animation so dots don't move at the same time
  Widget _buildDot(double delay) {
    // AnimatedBuilder rebuilds whenever the animation value changes
    return AnimatedBuilder(
      // Listen to the animation controller
      animation: _controller,

      // Builder runs every animation frame
      builder: (context, child) {
        // _controller.value goes from 0 → 1 repeatedly
        // Adding delay offsets each dot slightly
        // %1 keeps value between 0 and 1
        double progress = (_controller.value + delay) % 1;

        // Convert progress into a scaling value
        // Dot size will go from 0.5 → 1.0
        double scale = 0.5 + (progress * 0.5);

        // Transform.scale changes the size of the dot
        return Transform.scale(
          // Scale factor for animation
          scale: scale,

          // The visual dot itself
          child: const Padding(
            // Small spacing between dots
            padding: EdgeInsets.symmetric(horizontal: 2),

            child: CircleAvatar(
              radius: 2, // Dot radius
              backgroundColor: Colors.black54, // Dot color
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Row arranges the dots horizontally
    return Row(
      // Prevent the row from expanding to full width
      mainAxisSize: MainAxisSize.min,

      children: [
        // First dot (no delay)
        _buildDot(0.0),

        // Second dot slightly delayed
        _buildDot(0.2),

        // Third dot delayed even more
        _buildDot(0.4),

        // 3 are good for now
        // _buildDot(0.4),
      ],
    );
  }
}
