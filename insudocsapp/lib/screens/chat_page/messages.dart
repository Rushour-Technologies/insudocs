import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

import 'package:insudox_app/globals.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:insudox_app/screens/chat_page/chat.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => MessagesPageState();
}

class MessagesPageState extends State<MessagesPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      key: scaffoldKey,
      body: StreamBuilder<List<types.Room>>(
        stream: FirebaseChatCore.instance.rooms(),
        initialData: const [],
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                bottom: 200,
              ),
              child: const Text('No rooms'),
            );
          }
          print(snapshot.data!);

          return Column(
            children: snapshot.data!
                .where(
              (element) =>
                  element.users.first.role == types.Role.saviour ||
                  element.users.first.role == types.Role.user,
            )
                .map((room) {
              return GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(
                        room: room,
                      ),
                    ),
                  );
                  setState(() {});
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.025,
                  ),
                  child: ListTile(
                    leading: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.005),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          room.imageUrl ?? DEFAULT_PROFILE_PICTURE,
                        ),
                      ),
                    ),
                    title: Text(
                      room.name ?? '',
                      style: TextStyle(
                        fontFamily: 'DM Sans',
                        color: COLOR_THEME['primary'],
                        fontSize: screenWidth * 0.075,
                      ),
                    ),
                    subtitle: Text(
                      room.users.last.role!.name,
                      style: TextStyle(
                        fontFamily: 'DM Sans',
                        color: COLOR_THEME['primary'],
                        fontSize: screenWidth * 0.05,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
