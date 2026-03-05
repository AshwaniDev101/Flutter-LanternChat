

import 'message.dart';

enum ConversationsType
{
  group,
  solo
}

class Conversations {


  final String conversationsTypeId;
  final ConversationsType conversationsType;

  final String hostId;
  final String createdAt;
  final String lastUpdate;

  final Message lastMessage;


  Conversations(this.uid, this.lastMessage, this.lastUpdate);
}