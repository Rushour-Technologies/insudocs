import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insudox/src/common_widgets/base_components.dart';
import 'package:insudox/globals.dart';
import 'package:insudox/src/main/components/vertical_tab_bar.dart';
import 'package:insudox/src/main/tabs/clients/clients_page.dart';
import 'package:insudox/src/main/tabs/home/home_page.dart';
import 'package:insudox/src/main/tabs/incoming_requests/incoming_requests_page.dart';
import 'package:insudox/src/main/tabs/messages/messages_page.dart';
import 'package:insudox/src/main/tabs/notifications/notifications_page.dart';
import 'package:insudox/src/main/tabs/profile/profile_page.dart';

import 'package:insudox/services/Firebase/fireauth/fireauth.dart';

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
      mainView: VerticalTabBarView(
        controller: _controller,
        children: const [
          HomePage(),
          ClientsPage(),
          IncomingRequestPage(
            title: 'SAVIOURS',
          ),
          NotificationsPage(),
          ProfilePage(),
        ],
      ),
    );
  }
}
