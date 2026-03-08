import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lanternchat/models/conversations/conversation.dart';
import 'package:lanternchat/models/conversations/enums/conversation_type.dart';

import 'edit_history.dart';
import 'enums/message_type.dart';
import 'message_media.dart';
import 'reply_to.dart';

enum ReactionType { thumbs, heart, laugh, wow, tears, fire, lol, namaste }

class _Field {
  static const String messageId = 'messageId';
  static const String senderId = 'senderId';
  static const String messageType = 'messageType';
  static const String messageMedia = 'messageMedia';

  static const String deletedFor = 'deletedFor';
  static const String seenBy = 'seenBy';

  static const String createdAt = 'createdAt';
  static const String editedAt = 'editedAt';

  static const String replyTo = 'replyTo';
  static const String reactions = 'reactions';
  static const String editHistory = 'editHistory';

  static const String text = 'text';
}

class Message {
  // Message MetaData
  final String messageId;
  final String senderId;
  final MessageType messageType;
  final MessageMedia? messageMedia;

  // Message states
  final Map<String, Timestamp> deletedFor;
  final Map<String, Timestamp> seenBy;

  // Message TimeStamps
  final Timestamp createdAt;
  final Timestamp? editedAt;

  final List<EditHistory> editHistory;
  final ReplyTo? replyTo;
  final Map<String, ReactionType> reactions;

  final String? text;

  Message({
    required this.messageId,
    required this.senderId,
    required this.messageType,
    this.messageMedia,
    required this.createdAt,
    this.editedAt,
    required this.text,
    this.deletedFor = const {},
    this.seenBy = const {},
    this.editHistory = const [],
    this.replyTo,
    this.reactions = const {},
  });

  Map<String, dynamic> toMap() {
    return {
      _Field.messageId: messageId,
      _Field.senderId: senderId,
      _Field.messageType: messageType.name,
      _Field.messageMedia: messageMedia?.toMap(),
      _Field.deletedFor: deletedFor,
      _Field.seenBy: seenBy,
      _Field.createdAt: createdAt,
      _Field.editedAt: editedAt,
      _Field.editHistory: editHistory.map((e) => e.toMap()).toList(),
      _Field.replyTo: replyTo?.toMap(),
      _Field.reactions: reactions.map((key, value) => MapEntry(key, value.name)),
      _Field.text: text,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    final mediaMap = map[_Field.messageMedia] as Map<String, dynamic>?;
    final reactionMap = map[_Field.reactions] as Map<String, dynamic>? ?? {};
    final seenByMap = map[_Field.seenBy] as Map<String, dynamic>? ?? {};
    final deletedForMap = map[_Field.deletedFor] as Map<String, dynamic>? ?? {};
    final editHistoryList = map[_Field.editHistory] as List? ?? [];

    return Message(
      messageId: map[_Field.messageId] ?? '',
      senderId: map[_Field.senderId] ?? '',
      messageType: MessageType.values.asNameMap()[map[_Field.messageType]] ?? MessageType.text,
      messageMedia: mediaMap != null ? MessageMedia.fromMap(mediaMap) : null,
      createdAt: map[_Field.createdAt] as Timestamp? ?? Timestamp.now(),
      editedAt: map[_Field.editedAt] as Timestamp?,
      text: map[_Field.text],
      deletedFor: deletedForMap.map((k, v) => MapEntry(k, v as Timestamp)),
      seenBy: seenByMap.map((k, v) => MapEntry(k, v as Timestamp)),
      editHistory: editHistoryList.whereType<Map<String, dynamic>>().map(EditHistory.fromMap).toList(),
      replyTo: map[_Field.replyTo] != null ? ReplyTo.fromMap(map[_Field.replyTo] as Map<String, dynamic>) : null,
      reactions: reactionMap.map(
        (key, value) => MapEntry(key, ReactionType.values.asNameMap()[value] ?? ReactionType.thumbs),
      ),
    );
  }

  // Map<String, dynamic> toSummary(String conversationId,) {
  //   final conv = Conversation(
  //     id: conversationId,
  //     memberIds: [senderId,],
  //     lastMessagePreview: text.toString(),
  //     lastSenderId: senderId,
  //     lastMessageTime: createdAt,
  //     type: ConversationType.solo,
  //   );
  //
  //   return conv.toMap();
  // }
}
