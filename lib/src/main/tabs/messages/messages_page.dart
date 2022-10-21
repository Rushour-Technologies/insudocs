import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:insudox/services/Firebase/firestore/firestore.dart';
import 'package:insudox/src/common_widgets/base_components.dart';
import 'package:insudox/globals.dart';
import 'package:insudox/src/main/components/vertical_tab_bar.dart';
import 'package:insudox/src/main/tabs/messages/chatInterface.dart';
import 'package:insudox/services/Firebase/fireauth/fireauth.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key, required this.role}) : super(key: key);
  final types.Role role;
  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final VerticalTabController _controller = VerticalTabController();
  Widget? _chatView = Container();

  void initializeChatView() {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    _chatView = Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenHeight / 20),
          color: Colors.transparent,
        ),
        child: Text(
          'Open a chat to start messaging',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'DM Sans',
            color: GlobalColor.primary,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.025,
          ),
        ),
      ),
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      initializeChatView,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    User? user = getCurrentUser();
    return mainViewAppBar(
      page: 'MESSAGES',
      width: screenWidth,
      height: screenHeight,
      name: user != null ? user.displayName ?? user.email : '',
      child: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.025),
        child: Container(
          width: screenWidth * 0.75,
          height: screenHeight * 0.75,
          decoration: BoxDecoration(
            color: GlobalColor.secondary,
            borderRadius: BorderRadius.circular(screenHeight / 20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 3,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(screenHeight / 20),
                  bottomRight: Radius.circular(screenHeight / 20),
                ),
              ),
              height: screenHeight * 0.05,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline_rounded),
                  Text(
                    'For any queries contact the admin!',
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      color: GlobalColor.background,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.0125,
                    ),
                  ),
                ],
              ),
            ),
            body: Container(
              width: screenWidth * 0.75,
              height: screenHeight * 0.75,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(screenHeight / 20),
                  topRight: Radius.circular(screenHeight / 20),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: screenWidth * 0.55,
                    height: screenHeight * 0.75,
                    color: Colors.transparent,
                    child: _chatView ??
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(screenHeight / 20),
                              color: Colors.transparent,
                            ),
                            child: Text(
                              'Open a chat to start messaging',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'DM Sans',
                                color: GlobalColor.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.025,
                              ),
                            ),
                          ),
                        ),
                  ),
                  Container(
                    width: screenWidth * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenHeight / 20),
                      color: GlobalColor.tertiary,
                    ),
                    child: StreamBuilder<List<types.Room>>(
                      stream: FirebaseChatCore.instance.rooms(),
                      initialData: const [],
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(
                              bottom: 200,
                            ),
                            child: Text(
                              'No rooms',
                              style: TextStyle(
                                fontFamily: 'DM Sans',
                                fontSize: screenWidth * 0.01,
                              ),
                            ),
                          );
                        }

                        return Column(
                          children: snapshot.data!.map((room) {
                            types.User meUser = room.users
                                .where((element) =>
                                    element.id != getCurrentUserId())
                                .toList()[0];

                            return GestureDetector(
                              onTap: () {
                                _chatView = Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      screenHeight / 20,
                                    ),
                                  ),
                                  foregroundDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      screenHeight / 20,
                                    ),
                                  ),
                                  child: ChatPage(
                                    room: room,
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
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.005),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        room.imageUrl ??
                                            DEFAULT_PROFILE_PICTURE,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    room.name ?? '',
                                    style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      color: GlobalColor.primary,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.01,
                                    ),
                                  ),
                                  subtitle: Text(
                                    meUser.role!.toShortString(),
                                    style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      color: GlobalColor.primary,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.01,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
