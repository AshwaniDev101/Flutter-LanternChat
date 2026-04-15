import 'package:flutter/material.dart';

class ChatTheme extends ThemeExtension<ChatTheme> {
  final Color senderBubble;
  final Color receivedBubble;
  final Color muteColor;
  final Color chatBackground;

  ChatTheme({required this.senderBubble, required this.receivedBubble, required this.muteColor, required this.chatBackground,});

  @override
  ThemeExtension<ChatTheme> copyWith({Color? senderBubble, Color? receivedBubble, Color? muteColor, Color? chatBackground}) {
    return ChatTheme(
      senderBubble: senderBubble ?? this.senderBubble,
      receivedBubble: receivedBubble ?? this.receivedBubble,
      muteColor: muteColor ?? this.muteColor,
      chatBackground: chatBackground ?? this.chatBackground,
    );
  }

  @override
  ThemeExtension<ChatTheme> lerp(covariant ThemeExtension<ChatTheme>? other, double t) {
    if (other is! ChatTheme) return this; //

    return ChatTheme(
      senderBubble: Color.lerp(senderBubble, other.senderBubble, t)!,
      receivedBubble: Color.lerp(receivedBubble, other.receivedBubble, t)!,
      muteColor: Color.lerp(muteColor, other.muteColor, t)!,
      chatBackground: Color.lerp(chatBackground, other.chatBackground, t)!,
    );
  }
}
