import 'dart:html';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:insudox/globals.dart';
import 'package:insudox/services/Firebase/firestore/firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.room,
  });

  final types.Room room;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isAttachmentUploading = false;
  bool isNegative = false;
  String personUid = "";

  @override
  void initState() {
    super.initState();
    personUid = (widget.room.users
        .where((element) =>
            element.role == types.Role.user ||
            element.role == types.Role.saviour)
        .toList()[0]
        .id);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              String url = await FirebaseStorage.instance
                  .ref('reports/$personUid.pdf')
                  .getDownloadURL();
              launchUrl(Uri.parse(url));
            },
            icon: Icon(Icons.download),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(screenHeight / 20),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: GlobalColor.drawerBg,
        title: Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.025),
          child: Text(
            (widget.room.name ?? 'Chat'),
            style: TextStyle(
              fontFamily: 'DM Sans',
              color: isNegative ? Colors.red : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.01,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenHeight / 20),
          color: Colors.white,
        ),
        child: StreamBuilder<types.Room>(
          initialData: widget.room,
          stream: FirebaseChatCore.instance.room(widget.room.id),
          builder: (context, snapshot) => StreamBuilder<List<types.Message>>(
            initialData: const [],
            stream: FirebaseChatCore.instance.messages(snapshot.data!),
            builder: (context, snapshot) => Chat(
              showUserAvatars: true,
              theme: DefaultChatTheme(
                primaryColor: GlobalColor.primary,
                backgroundColor: GlobalColor.backgroundComponents[2],
                inputTextColor: Colors.black,
                inputBackgroundColor: Colors.grey.shade200,
              ),
              isAttachmentUploading: _isAttachmentUploading,
              messages: snapshot.data ?? [],
              onSendPressed: _handleSendPressed,
              user: types.User(
                id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleSendPressed(types.PartialText message) {
    FirebaseChatCore.instance.sendMessage(
      message,
      widget.room.id,
    );
  }
}
