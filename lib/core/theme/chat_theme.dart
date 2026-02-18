import 'package:flutter/material.dart';

class ChatTheme extends ThemeExtension<ChatTheme> {
  final Color senderBubble;
  final Color receivedBubble;
  final Color muteColor;

  ChatTheme({required this.senderBubble, required this.receivedBubble, required this.muteColor});

  @override
  ThemeExtension<ChatTheme> copyWith({Color? senderBubble, Color? receivedBubble, Color? muteColor}) {
    return ChatTheme(
      senderBubble: senderBubble ?? this.senderBubble,
      receivedBubble: receivedBubble ?? this.receivedBubble,
      muteColor: muteColor ?? this.muteColor,
    );
  }

  @override
  ThemeExtension<ChatTheme> lerp(covariant ThemeExtension<ChatTheme>? other, double t) {
    if (other is! ChatTheme) return this; //

    return ChatTheme(
      senderBubble: Color.lerp(senderBubble, other.senderBubble, t)!,
      receivedBubble: Color.lerp(receivedBubble, other.receivedBubble, t)!,
      muteColor: Color.lerp(muteColor, other.muteColor, t)!,
    );
  }
}
