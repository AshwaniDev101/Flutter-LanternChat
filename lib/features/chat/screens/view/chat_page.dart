import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/core/helpers/id_helper.dart';
import 'package:lanternchat/features/auth/provider/presence_provider.dart';
import 'package:lanternchat/features/chat/screens/view/widgets/chat_bubble.dart';
import 'package:lanternchat/features/chat/screens/view/widgets/text_area.dart';
import 'package:lanternchat/features/chat/screens/view/widgets/typing_indicator.dart';
import 'package:lanternchat/features/contact/provider/contact_providers.dart';
import 'package:lanternchat/features/conversation/provider/conversation_provider.dart';
import 'package:lanternchat/models/conversations/conversation.dart';
import 'package:lanternchat/models/conversations/conversation_entry.dart';
import 'package:lanternchat/models/messages/seen_message.dart';
import 'package:lanternchat/shared/widgets/bubble_selectable.dart';

import '../../../../../core/util/logger.dart';
import '../../../../../models/messages/enums/message_type.dart';
import '../../../../../models/messages/message.dart';
import '../../../../../models/messages/message_tile.dart';
import '../../../../../models/users/app_user.dart';
import '../../../../../shared/widgets/circular_user_avatar.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/chat_theme.dart';
import '../../../../models/users/contact.dart';
import '../../../auth/provider/auth_provider.dart';
import '../../data/chat_service.dart';
import '../../provider/chat_provider.dart';
import '../../provider/seen_message_provider.dart';
import '../../provider/typing_provider.dart';

// Popup Option menu for the Chat page
enum ChatPagePopupMenu {
  newGroup,
  viewContact,
  search,
  mediaLinksDocs,
  muteNotifications,
  disappearingMessages,
  chatTheme,
  more,
}

// extension allows additional functionality to enums
extension on ChatPagePopupMenu {
  String get action {
    return switch (this) {
      ChatPagePopupMenu.newGroup => "New Group",
      ChatPagePopupMenu.viewContact => "View Contact",
      ChatPagePopupMenu.search => "Search",
      ChatPagePopupMenu.mediaLinksDocs => "Media, Links, and Docs",
      ChatPagePopupMenu.muteNotifications => "Mute Notifications",
      ChatPagePopupMenu.disappearingMessages => "Disappearing Messages",
      ChatPagePopupMenu.chatTheme => "Chat Theme",
      ChatPagePopupMenu.more => "More",
    };
  }
}

class ChatPage extends ConsumerStatefulWidget {
  final ConversationEntry conversationEntry;

  // i have notice this page only requires a 'conversationId' and 'Contact' info,
  // where 'conversationID' to can be null
  // if wanna add group chat support i would need 'GroupInfo'
  const ChatPage({super.key, required this.conversationEntry});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  Conversation? currentConversation;

  @override
  void initState() {
    super.initState();

    _init();
  }

  Future<void> _init() async {
    currentConversation = widget.conversationEntry.conversation;
    // if conversation is null
    if (widget.conversationEntry.conversation == null) {
      if (widget.conversationEntry.contact != null) {
        // It's possible conversation id exist, if it does, we can find it using 'pairId'
        final currentUser = ref.read(currentUserProvider);
        final pairId = IdHelper.generatePairId(currentUser.uid, widget.conversationEntry.contact!.uid);

        final conversationService = ref.read(conversationServiceProvider);
        final Conversation? conversation = await conversationService.getConversationUsingPairId(pairId: pairId);

        // if conversation is not found
        if (conversation == null) {
          debugPrint('#### Conversation was not found');
        } else {
          print("####  conversationService.getConversationUsingPairId ${conversation.conversationId}");

          // widget.conversationEntry.conversation = conversation;

          setState(() {
            currentConversation = conversation;
            _seenLister();
          });
        }
      } else {
        throw Exception("Error : Both Conversation and Contact can't be null");
      }
    } else {
      AppLogger.i("####  conversationEntry have conversation ${widget.conversationEntry.conversation!.conversationId}");

      // we have conversation its group conversation
      // if(widget.conversationEntry.conversation!.groupInfo !=null)
      //   { // It's group convo
      //
      //   }else
      //     { // It's solo
      //
      //     }

      _seenLister();
    }
  }

  String? _lastHandledMessageId;
  int? _lastKnowNumberOfMessages;

  void _seenLister() {
    // TODO: Replace per-message seenBy updates with a conversation-level lastSeen pointer.

    final chatService = ref.read(chatServiceProvider);
    final seenMessageService = ref.read(seenMessageServiceProvider);
    final currentUser = ref.read(currentUserProvider);

    ref.listenManual(seenMessageMergeSteamProvider(currentConversation?.conversationId), (previous, next) {
      next.whenData((messages) {
        if (messages.isEmpty || currentConversation == null) return;

        // structural guard
        if (_lastKnowNumberOfMessages == messages.length) return;
        _lastKnowNumberOfMessages = messages.length;

        final lastMessage = messages.last.message;

        // message guard, Prevent reprocessing same message
        if (_lastHandledMessageId == lastMessage.messageId) return;
        _lastHandledMessageId = lastMessage.messageId;

        // final chatService = ref.read(chatServiceProvider);
        // final currentUser = ref.read(currentUserProvider);

        if (lastMessage.senderId == currentUser.uid) return;
        if (lastMessage.seenBy.containsKey(currentUser.uid)) return;

        seenMessageService.setMessageSeen(
          conversationId: currentConversation!.conversationId,
          seemMessage: SeenMessage(
            lastSeenMessageId: lastMessage.messageId,
            lastSeenIndex: 0,
            uid: currentUser.uid,
            seenAt: Timestamp.now(),
          ),
        );
        chatService.setMessageSeen(currentConversation!.conversationId, lastMessage.messageId, currentUser.uid);
      });
    });
  }

  bool _isSelectionMode = false;
  int _selectionCount = 0;

  final Set<String> _selectedMessagesIds = {};

  @override
  Widget build(BuildContext context) {
    final ChatService chatService = ref.read(chatServiceProvider);
    final AppUser currentUser = ref.watch(currentUserProvider);

    // Old chatting Stream
    // final chatStream = ref.watch(chatStreamProvider(newConversation?.conversationId));
    final AsyncValue<List<MessageTile>> chatStream = ref.watch(
      seenMessageMergeSteamProvider(currentConversation?.conversationId),
    );

    final typingService = ref.read(typingServiceProvider);

    final chatTheme = Theme.of(context).extension<ChatTheme>()!;

    return Scaffold(
      appBar: _isSelectionMode
          ? AppBar(
              leadingWidth: 100,
              backgroundColor: AppColors.selectedTileTickColor,
              leading: Row(
                children: [
                  SizedBox(width: 8),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _selectionModeReset();

                        AppLogger.i('_selectedConversations {} $_selectedMessagesIds');
                      });
                    },
                    icon: Icon(Icons.arrow_back_rounded),
                  ),
                  SizedBox(width: 12),
                  Text(_selectionCount.toString(), style: TextStyle(fontSize: 18)),
                ],
              ),

              actions: [
                // IconButton(
                //   onPressed: () {
                //     _selectionModeReset();
                //   },
                //   icon: Icon(Icons.push_pin_outlined),
                // ),
                IconButton(
                  onPressed: () {
                    final conv = widget.conversationEntry.conversation;
                    if (conv != null) {
                      chatService.removeMessageList(
                        conversationId: widget.conversationEntry.conversation!.conversationId,
                        selectedMessagesIds: _selectedMessagesIds,
                      );
                    }

                    setState(() {
                      _selectionModeReset();
                    });
                  },
                  icon: Icon(Icons.delete_outline_outlined),
                ),
              ],
            )
          : _appBar(context),
      backgroundColor: chatTheme.chatBackground,
      body: Column(
        children: [
          Expanded(
            child: chatStream.when(
              data: (List<MessageTile> messageTiles) {
                // WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
                return ListView.separated(
                  reverse: true,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                  itemCount: messageTiles.length,
                  padding: EdgeInsets.all(16),

                  itemBuilder: (context, index) {
                    //// When reverse: true, index 0 = newest message
                    final messageTile = messageTiles[messageTiles.length - 1 - index];

                    //Updating last seen message every time new message comes

                    // AppLogger.i(
                    //   '[chat_page] $index ${messageTiles[index].message.text} ${messageTiles[index].message.messageId}  ${messageTiles[index].message.seenBy.values.toString()}',
                    // );

                    // final isSeenByOtherUser = messageTile.message.seenBy.containsKey(
                    //   widget.conversationEntry.contact.uid,
                    // );

                    final isSelected = _selectedMessagesIds.contains(messageTile.message.messageId);

                    return Column(
                      children: [
                        if (currentConversation != null)
                          BubbleSelectable(
                            selected: isSelected,

                            onLongPressStart: (details) {
                              if (messageTile.message.senderId != currentUser.uid) return;

                              setState(() {
                                _isSelectionMode = true;
                                _selectedMessagesIds.add(messageTile.message.messageId);
                                _selectionCount = _selectedMessagesIds.length;
                              });
                              AppLogger.i("long press is working ");
                            },

                            onTap: () {
                              if (messageTile.message.senderId != currentUser.uid) return;
                              if (_isSelectionMode) {
                                setState(() {
                                  if (_selectedMessagesIds.contains(messageTile.message.messageId)) {
                                    _selectedMessagesIds.remove(messageTile.message.messageId);
                                  } else {
                                    _selectedMessagesIds.add(messageTile.message.messageId);
                                  }

                                  _selectionCount = _selectedMessagesIds.length;
                                  _isSelectionMode = _selectedMessagesIds.isNotEmpty;
                                });
                              }
                            },

                            child: ChatBubble(
                              conversationType: currentConversation!.conversationType,
                              message: messageTile.message,
                            ),
                          ),
                      ],
                    );
                  },
                );
              },
              error: (e, t) {
                print("Error $e, $t");
                return Center(child: Text("Error $e"));
              },
              loading: () {
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),

          if (currentConversation != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TypingIndicator(conversationId: currentConversation!.conversationId, uid: currentUser.uid),
            ),

          TextArea(
            onSend: (String text) async {
              final message = Message(
                senderId: currentUser.uid,
                messageType: MessageType.text,
                createdAt: Timestamp.now(),
                text: text,
              );

              if (currentConversation != null) {
                chatService.sendMessageTo(conversationId: currentConversation!.conversationId, message: message);
              } else if (widget.conversationEntry.contact != null) {
                // create conversationId and send message
                final conversation = await chatService.sendMessageToNewConversation(
                  message: message,
                  senderUid: currentUser.uid,
                  receiverUid: widget.conversationEntry.contact!.uid,
                );

                setState(() {
                  currentConversation = conversation;
                });
              }
            },

            onTyping: (text) {
              if (currentConversation != null) {
                typingService.sendData(conversationId: currentConversation!.conversationId, uid: currentUser.uid);
              }
            },
          ),
        ],
      ),
    );
  }

  // Page App bar
  AppBar _appBar(BuildContext context) {
    return AppBar(
      // leadingWidth: 40, // reduces default 56 width
      titleSpacing: 4, // removes extra gap before title
      title: Row(
        children: [
          CircularUserAvatar(imageUrl: _getImageUrl(), radius: 20),
          SizedBox(width: 8),
          Text(
            _getName(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
            softWrap: false,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),

      actions: [
        // IconButton(onPressed: () {}, icon: Icon(Icons.videocam_outlined)),
        // IconButton(onPressed: () {}, icon: Icon(Icons.call_outlined)),
        PopupMenuButton(
          itemBuilder: (context) {
            return ChatPagePopupMenu.values.map((value) {
              return PopupMenuItem(value: value, child: Text(value.action));
            }).toList();
          },
        ),
      ],
    );
  }

  void _selectionModeReset() {
    _isSelectionMode = false;
    _selectedMessagesIds.clear();
    _selectionCount = 0;
  }

  String _getImageUrl() {
    final conversationEntry = widget.conversationEntry;

    if (conversationEntry.conversation != null && conversationEntry.conversation!.groupInfo != null) {
      return conversationEntry.conversation!.groupInfo!.imageUrl;
    } else if (conversationEntry.contact != null) {
      return conversationEntry.contact!.photoURL;
    } else {
      return 'https://ui-avatars.com/api/?name=X';
    }
  }

  String _getName() {
    final conversationEntry = widget.conversationEntry;

    if (conversationEntry.conversation != null && conversationEntry.conversation!.groupInfo != null) {
      return conversationEntry.conversation!.groupInfo!.title;
    } else if (conversationEntry.contact != null) {
      return conversationEntry.contact!.name;
    } else {
      return 'O_O user';
    }
  }
}
