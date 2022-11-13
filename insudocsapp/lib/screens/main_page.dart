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
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late final PageController _pageController = PageController(
    initialPage: widget.tabIndex,
  );

  bool isMounted = false;

  List<String> tabNames = ['Requests', 'Home', 'Chat'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      isMounted = true;
      // setState(() {});
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
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
          isMounted ? tabNames[_pageController.page!.round()] : "",
          style: TextStyle(
            fontFamily: "DM Sans",
            color: Colors.white,
            fontSize: screenWidth * 0.05,
          ),
        ),
        profilePicture: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: isMounted ? _pageController.page!.round() : 1,
          backgroundColor: COLOR_THEME['bottomNavigation']!,
          selectedLabelStyle: navigationStyle,
          unselectedLabelStyle: navigationStyle,
          elevation: 0,
          items: tabNames
              .map(
                (tabName) => BottomNavigationBarItem(
                  label: tabName,
                  activeIcon: ImageIcon(
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
          onTap: (index) {
            print("adsadasd");
            _pageController.jumpToPage(index);
            print("${_pageController.page} , $index");

            setState(
              () {},
            );
          }
          //other params
          ),
      body: PageView(
        // viewportFraction: 0.9,
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // Put FIVE pages in the tab bar view
          RequestsPage(),
          HomePage(),
          MessagesPage(),
          // NoIt
          //emsInTab(text: "0"),
          // NoItemsInTab(text: "4"),
        ],
      ),
    );
  }
}
