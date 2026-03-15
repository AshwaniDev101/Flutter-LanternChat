import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lanternchat/models/conversations/enums/conversation_type.dart';
import 'package:lanternchat/models/messages/message.dart';

class _Field {
  static const String conversationId = 'conversationId';
  static const String memberIds = 'memberIds';
  static const String lastMessagePreview = 'lastMessagePreview';
  static const String lastSenderId = 'lastSenderId';
  static const String lastMessageTime = 'lastMessageTime';
  static const String conversationType = 'conversationType';
  static const String pairID = 'pairID';
  static const String lastMessageIndex = 'lastMessageIndex';
}

class Conversation {
  final String conversationId;

  final Set<String> memberIds;
  final ConversationType conversationType;

  final String? pairID;

  final String lastMessagePreview;
  final int lastMessageIndex;
  final String lastSenderId;
  final Timestamp lastMessageTime;

  Conversation({
    required this.conversationId,
    required this.memberIds,
    required this.conversationType,
    this.pairID,
    required this.lastMessagePreview,
    required this.lastMessageIndex,
    required this.lastSenderId,
    required this.lastMessageTime,
  });

  /// Creates a new conversation summary after a message is sent
  factory Conversation.summary({
    required Conversation conversation,
    required Message message,
  }) {
    return Conversation(
      conversationId: conversation.conversationId,
      memberIds: conversation.memberIds,
      conversationType: conversation.conversationType,
      pairID: conversation.pairID,
      lastMessagePreview: message.text ?? '',
      lastMessageIndex: message.messageIndex,
      lastSenderId: message.senderId,
      lastMessageTime: message.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      _Field.conversationId: conversationId,
      _Field.memberIds: memberIds,
      _Field.conversationType: conversationType.name,
      _Field.pairID: pairID,
      _Field.lastMessagePreview: lastMessagePreview,
      _Field.lastMessageIndex: lastMessageIndex,
      _Field.lastSenderId: lastSenderId,
      _Field.lastMessageTime: lastMessageTime,
    };
  }

  factory Conversation.fromMap(Map<String, dynamic> map) {
    return Conversation(
      conversationId: map[_Field.conversationId] ?? '',
      memberIds: Set<String>.from(map[_Field.memberIds] ?? []),
      conversationType:
      ConversationType.values.asNameMap()[map[_Field.conversationType]] ??
          ConversationType.solo,
      pairID: map[_Field.pairID],
      lastMessagePreview: map[_Field.lastMessagePreview] ?? '',
      lastMessageIndex: map[_Field.lastMessageIndex] ?? 0,
      lastSenderId: map[_Field.lastSenderId] ?? '',
      lastMessageTime: map[_Field.lastMessageTime] ?? Timestamp.now(),
    );
  }

  Conversation copyWith({
    String? lastMessagePreview,
    int? lastMessageIndex,
    String? lastSenderId,
    Timestamp? lastMessageTime,
  }) {
    return Conversation(
      conversationId: conversationId,
      memberIds: memberIds,
      conversationType: conversationType,
      pairID: pairID,
      lastMessagePreview: lastMessagePreview ?? this.lastMessagePreview,
      lastMessageIndex: lastMessageIndex ?? this.lastMessageIndex,
      lastSenderId: lastSenderId ?? this.lastSenderId,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
    );
  }
}