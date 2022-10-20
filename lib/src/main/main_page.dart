import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:insudox/globals.dart';
import 'package:insudox/services/Firebase/fireauth/fireauth.dart';
import 'package:insudox/src/common_widgets/base_components.dart';
import 'package:insudox/src/main/components/default.dart';
import 'package:insudox/src/main/components/vertical_tab_bar.dart';
import 'package:insudox/src/main/tabs/clients/clients_page.dart';
import 'package:insudox/src/main/tabs/home/home_page.dart';
import 'package:insudox/src/main/tabs/incoming_requests/incoming_requests_page.dart';
import 'package:insudox/src/main/tabs/notifications/notifications_page.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:insudox/src/main/tabs/profile/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  /// The route name for this page.
  static const routeName = '/main';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final VerticalTabController _controller = VerticalTabController();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return mainBackground(
      height: screenHeight,
      width: screenWidth,
      sideBar: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              APP_ICON,
              width: screenWidth * 0.2,
              height: screenWidth * 0.15,
            ),
            VerticalTabBar(
              initialIndex: 0,
              controller: _controller,
              labelStyle: TextStyle(
                fontFamily: 'DM Sans',
                fontSize: screenWidth * 0.0125,
              ),
              tabs: const [
                VerticalTabBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                VerticalTabBarItem(
                  icon: Icon(Icons.info_outline),
                  label: 'Clients',
                ),
                VerticalTabBarItem(
                  icon: Icon(Icons.move_to_inbox_outlined),
                  label: 'Saviours',
                ),
                VerticalTabBarItem(
                  icon: Icon(Icons.notifications_active_outlined),
                  label: 'Notifications',
                ),
                VerticalTabBarItem(
                  icon: Icon(Icons.person_outline_rounded),
                  label: 'Profile',
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () async {
                    await signOut();
                    await signOutGoogle();
                    Navigator.of(context).restorablePushNamedAndRemoveUntil(
                        '/login', (route) => false);
                    return;
                  },
                  child: ListTile(
                    leading: Icon(
                      color: GlobalColor.navigationUnselected,
                      Icons.logout_rounded,
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(
                        fontFamily: 'DM Sans',
                        color: Colors.white,
                        fontSize: screenWidth * 0.0125,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      mainView: FutureBuilder(
        future: getRole(),
        builder: (context, AsyncSnapshot<types.Role> role) {
          if (role.hasData) {
            return role.data == types.Role.saviour
                ? VerticalTabBarView(
                    controller: _controller,
                    children: [
                      HomePage(
                        role: role.data!,
                      ),
                      ClientsPage(
                        role: role.data!,
                      ),
                      IncomingRequestPage(
                        role: role.data!,
                      ),
                      NotificationsPage(),
                      ProfilePage(),
                    ],
                  )
                : role.data == types.Role.superadmin
                    ? VerticalTabBarView(
                        controller: _controller,
                        children: [
                          HomePage(
                            role: role.data!,
                          ),
                          ClientsPage(
                            role: role.data!,
                          ),
                          IncomingRequestPage(
                            role: role.data!,
                          ),
                          NotificationsPage(),
                          ProfilePage(),
                        ],
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Not Logged in',
                              style: TextStyle(
                                color: GlobalColor.black,
                                fontSize: screenWidth * 0.025,
                                fontFamily: 'DM Sans',
                              ),
                            ),
                            const CircularProgressIndicator(
                              color: GlobalColor.primary,
                            ),
                          ],
                        ),
                      );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Data is loading',
                    style: TextStyle(
                      color: GlobalColor.black,
                      fontSize: screenWidth * 0.025,
                      fontFamily: 'DM Sans',
                    ),
                  ),
                  const CircularProgressIndicator(
                    color: GlobalColor.primary,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
