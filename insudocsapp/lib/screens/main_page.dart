import 'package:flutter/material.dart';
import 'package:insudox_app/common_widgets/backgrounds/bigOneSmallOneBg.dart';
import 'package:insudox_app/common_appbar/common_appbar.dart';
import 'package:insudox_app/common_appbar/components/language_dropdown.dart';
import 'package:insudox_app/drawer/drawer.dart';
import 'package:insudox_app/globals.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:insudox_app/screens/chat_page/messages.dart';
import 'package:insudox_app/screens/home_page/home_page.dart';
import 'package:insudox_app/screens/requests_tab/requests_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
    this.tabIndex = 1,
  }) : super(key: key);
  final int tabIndex;

  @override
  State<MainPage> createState() => _StudentMainPageState();
}

class _StudentMainPageState extends State<MainPage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var _bottomNavIndex = 1;
  late List<StatefulWidget> bodies;
  late TabController _tabController;

  List<String> tabNames = ['Requests', 'Home', 'Chat'];

  @override
  void initState() {
    super.initState();
    _bottomNavIndex = widget.tabIndex;
    _tabController = TabController(
      animationDuration: const Duration(milliseconds: 0),
      initialIndex: widget.tabIndex,
      length: 3,
      vsync: this,
    );
    _tabController.addListener(
      () {
        if (_tabController.previousIndex != _tabController.index) {
          setState(() {});
        }
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<double> tempDimensions = [
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height
    ];
    final double screenHeight = tempDimensions[0] > tempDimensions[1]
        ? tempDimensions[0]
        : tempDimensions[1];
    final double screenWidth = tempDimensions[0] > tempDimensions[1]
        ? tempDimensions[1]
        : tempDimensions[0];

    TextStyle navigationStyle = TextStyle(
      fontFamily: "DM Sans",
      color: Colors.white,
      fontSize: screenWidth * 0.03,
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      key: scaffoldKey,
      endDrawer: CommonDrawer(),
      appBar: commonAppBar(
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        scaffoldKey: scaffoldKey,
        // title: LanguageDropDown(
        //   parentSet: setState,
        // ),
        title: Text(
          tabNames[_tabController.index],
          style: TextStyle(
            fontFamily: "DM Sans",
            color: Colors.white,
            fontSize: screenWidth * 0.05,
          ),
        ),
        profilePicture: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.fromLTRB(
          screenWidth * 0.04,
          0,
          screenWidth * 0.04,
          screenHeight * 0.01,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.01),
              child: SizedBox(
                height: screenHeight * 0.075,
                child: CustomNavigationBar(
                  selectedColor: COLOR_THEME['bottomNavigationSelected'],
                  currentIndex: _bottomNavIndex,
                  backgroundColor: COLOR_THEME['bottomNavigation']!,
                  elevation: 0,
                  borderRadius: Radius.circular(screenWidth / 20),
                  items: tabNames
                      .map(
                        (tabName) => CustomNavigationBarItem(
                          selectedTitle: Text(
                            tabName,
                            style: navigationStyle,
                          ),
                          title: Text(
                            tabName,
                            style: navigationStyle,
                          ),
                          selectedIcon: ImageIcon(
                            AssetImage(
                                "$BOTTOM_NAVIGATION_IMAGE_DIRECTORY/${tabName.toLowerCase()}.png"),
                            color: COLOR_THEME['bottomNavigationSelected'],
                          ),
                          icon: ImageIcon(
                            AssetImage(
                                "$BOTTOM_NAVIGATION_IMAGE_DIRECTORY/${tabName.toLowerCase()}.png"),
                            color: COLOR_THEME['bottomNavigationUnselected'],
                          ),
                        ),
                      )
                      .toList(),
                  onTap: (index) => setState(
                    () {
                      _bottomNavIndex = index;
                      _tabController.index = index;
                    },
                  ),
                  //other params
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          const BigOneSmallOneBG(),
          Positioned(
            top: screenHeight / 7,
            left: 0,
            width: tempDimensions[0] > tempDimensions[1]
                ? tempDimensions[1]
                : tempDimensions[0],
            height: tempDimensions[0] > tempDimensions[1]
                ? tempDimensions[0]
                : tempDimensions[1] * 0.9,
            child: TabBarView(
              // viewportFraction: 0.9,
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                // Put FIVE pages in the tab bar view
                RequestsPage(),
                HomePage(),
                HomePage(),
                // MessagesPage(),
                // NoIt
                //emsInTab(text: "0"),
                // NoItemsInTab(text: "4"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
