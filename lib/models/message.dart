import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType { text, image, file }

enum ReactionType { thumbs, heart, laugh, wow, tears, fire, lol, namaste }

// enum MessageStatus { sending, sent, failed }

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

  // MessageMedia
  static const String url = 'url';
  static const String thumbnail = 'thumbnail';
  static const String fileSize = 'fileSize';
  static const String mimeType = 'mimeType';

  // EditHistory
  static const String previewText = 'previousText';
  static const String editedBy = 'editedBy';

  // Thumbnail
  static const String width = 'width';
  static const String height = 'height';
}

class Thumbnail {
  final String url;
  final int width;
  final int height;

  Thumbnail({required this.url, required this.width, required this.height});

  Map<String, dynamic> toMap() {
    return {_Field.url: url, _Field.width: width, _Field.height: height};
  }

  factory Thumbnail.fromMap(Map<String, dynamic> map) {
    return Thumbnail(
      url: map[_Field.url] ?? '',
      width: (map[_Field.width] ?? 0).toInt(),
      height: (map[_Field.height] ?? 0).toInt(),
    );
  }
}

class MessageMedia {
  final String url;
  final Thumbnail? thumbnail;
  final int? fileSize;
  final String? mimeType;

  MessageMedia({required this.url, this.thumbnail, this.fileSize, this.mimeType});

  Map<String, dynamic> toMap() {
    return {
      _Field.url: url,
      _Field.thumbnail: thumbnail?.toMap(),
      _Field.fileSize: fileSize,
      _Field.mimeType: mimeType,
    };
  }

  factory MessageMedia.fromMap(Map<String, dynamic> map) {
    final thumbnailMap = map[_Field.thumbnail] as Map<String, dynamic>?;
    return MessageMedia(
      url: map[_Field.url] ?? '',
      thumbnail: thumbnailMap != null ? Thumbnail.fromMap(thumbnailMap) : null,
      fileSize: map[_Field.fileSize]?.toInt(),
      mimeType: map[_Field.mimeType],
    );
  }
}

class EditHistory {
  final String previousText;
  final Timestamp editedAt;
  final String editedBy;

  EditHistory({required this.previousText, required this.editedAt, required this.editedBy});

  Map<String, dynamic> toMap() {
    return {_Field.previewText: previousText, _Field.editedAt: editedAt, _Field.editedBy: editedBy};
  }

  factory EditHistory.fromMap(Map<String, dynamic> map) {
    return EditHistory(
      previousText: map[_Field.previewText] ?? '',
      editedAt: map[_Field.editedAt] ?? Timestamp.now(),
      editedBy: map[_Field.editedBy] ?? '',
    );
  }
}

class ReplyTo {
  final String messageId;
  final String senderId;
  final MessageType messageType;
  final String text;

  ReplyTo({required this.messageId, required this.senderId, required this.text, required this.messageType});

  Map<String, dynamic> toMap() {
    return {
      _Field.messageId: messageId,
      _Field.senderId: senderId,
      _Field.messageType: messageType.name,
      _Field.text: text,
    };
  }

  factory ReplyTo.fromMap(Map<String, dynamic> map) {
    return ReplyTo(
      messageId: map[_Field.messageId] ?? '',
      senderId: map[_Field.senderId] ?? '',
      messageType: MessageType.values.asNameMap()[map[_Field.messageType]] ?? MessageType.text,
      text: map[_Field.text] ?? '',
    );
  }
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
}
