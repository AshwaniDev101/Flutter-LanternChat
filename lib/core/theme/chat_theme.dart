import 'package:flutter/material.dart';

@immutable
class ChatTheme extends ThemeExtension<ChatTheme> {
  // Sender
  final Color senderBubble;
  final Color senderBubbleTitle;
  final Color senderBubbleText;
  final Color senderBubbleMuteColor;
  final Color senderBubbleDeleted;

  // Receiver
  final Color receivedBubble;
  final Color receivedBubbleTitle;
  final Color receivedBubbleText;
  final Color receivedBubbleMuteColor;
  final Color receivedBubbleDeleted;

  // Background
  final Color chatBackground;

  const ChatTheme({
    // sender
    required this.senderBubble,
    required this.senderBubbleTitle,
    required this.senderBubbleText,
    required this.senderBubbleMuteColor,
    required this.senderBubbleDeleted,
    // received
    required this.receivedBubble,
    required this.receivedBubbleTitle,
    required this.receivedBubbleText,
    required this.receivedBubbleMuteColor,
    required this.receivedBubbleDeleted,
    // chatBackground
    required this.chatBackground,
  });

  @override
  ChatTheme copyWith({
    // senderBubble
    Color? senderBubble,
    Color? senderBubbleTitle,
    Color? senderBubbleText,
    Color? senderBubbleMuteColor,
    Color? senderBubbleDeleted,
    // receivedBubble
    Color? receivedBubble,
    Color? receivedBubbleTitle,
    Color? receivedBubbleText,
    Color? receivedBubbleMuteColor,
    Color? receivedBubbleDeleted,
    // chatBackground
    Color? chatBackground,
  }) {
    return ChatTheme(
      // senderBubble
      senderBubble: senderBubble ?? this.senderBubble,
      senderBubbleTitle: senderBubbleTitle ?? this.senderBubbleTitle,
      senderBubbleText: senderBubbleText ?? this.senderBubbleText,
      senderBubbleMuteColor: senderBubbleMuteColor ?? this.senderBubbleMuteColor,
      senderBubbleDeleted: senderBubbleDeleted ?? this.senderBubbleDeleted,

      // receivedBubble
      receivedBubble: receivedBubble ?? this.receivedBubble,
      receivedBubbleTitle: receivedBubbleTitle ?? this.receivedBubbleTitle,
      receivedBubbleText: receivedBubbleText ?? this.receivedBubbleText,
      receivedBubbleMuteColor: receivedBubbleMuteColor ?? this.receivedBubbleMuteColor,
      receivedBubbleDeleted: receivedBubbleDeleted ?? this.receivedBubbleDeleted,
      // chatBackground
      chatBackground: chatBackground ?? this.chatBackground,
    );
  }

  @override
  ChatTheme lerp(ThemeExtension<ChatTheme>? other, double t) {
    if (other is! ChatTheme) return this;

    return ChatTheme(
      // senderBubble
      senderBubble: Color.lerp(senderBubble, other.senderBubble, t)!,
      senderBubbleTitle: Color.lerp(senderBubbleTitle, other.senderBubbleTitle, t)!,
      senderBubbleText: Color.lerp(senderBubbleText, other.senderBubbleText, t)!,
      senderBubbleMuteColor: Color.lerp(senderBubbleMuteColor, other.senderBubbleMuteColor, t)!,
      senderBubbleDeleted: Color.lerp(senderBubbleDeleted, other.senderBubbleDeleted, t)!,

      // receivedBubble
      receivedBubble: Color.lerp(receivedBubble, other.receivedBubble, t)!,
      receivedBubbleTitle: Color.lerp(receivedBubbleTitle, other.receivedBubbleTitle, t)!,
      receivedBubbleText: Color.lerp(receivedBubbleText, other.receivedBubbleText, t)!,
      receivedBubbleMuteColor: Color.lerp(receivedBubbleMuteColor, other.receivedBubbleMuteColor, t)!,
      receivedBubbleDeleted: Color.lerp(receivedBubbleDeleted, other.receivedBubbleDeleted, t)!,

      // chatBackground
      chatBackground: Color.lerp(chatBackground, other.chatBackground, t)!,
    );
  }
}
