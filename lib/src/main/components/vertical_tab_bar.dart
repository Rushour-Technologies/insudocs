import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insudox/globals.dart';
import 'package:insudox/src/main/components/default.dart';

class VerticalTabBar extends StatefulWidget {
  const VerticalTabBar({
    Key? key,
    required this.tabs,
    required this.initialIndex,
    required this.controller,
    this.labelStyle,
    this.selectedColor,
    this.unselectedColor,
  }) : super(key: key);
  final List<VerticalTabBarItem> tabs;
  final Color? selectedColor;
  final TextStyle? labelStyle;
  final Color? unselectedColor;
  final int initialIndex;
  final VerticalTabController controller;

  @override
  State<VerticalTabBar> createState() => _VerticalTabBarState();
}

class _VerticalTabBarState extends State<VerticalTabBar> {
  late int _currentIndex;
  late VerticalTabBarItem tab;
  final List<bool> isOnColor = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.tabs.length; i++) {
      isOnColor.add(i == widget.initialIndex);
    }
    _currentIndex = widget.initialIndex;

    widget.controller.setIndex = _currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    setPageTitle(widget.tabs[_currentIndex].label, context);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: widget.tabs.asMap().keys.map(
        ((index) {
          tab = widget.tabs.elementAt(index);
          return GestureDetector(
            onTap: () {
              if (_currentIndex == index) {
                return;
              }

              isOnColor[index] = true;

              if (_currentIndex != -1) {
                isOnColor[_currentIndex] = false;
              }

              _currentIndex = index;
              setPageTitle(widget.tabs[_currentIndex].label, context);

              widget.controller.setIndex = _currentIndex;
              if (tab.extraFunction != null) {
                tab.extraFunction!();
              }
              setState(() {});
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(screenWidth / 150),
                color: isOnColor[index]
                    ? GlobalColor.navigationSelected.withOpacity(0.35)
                    : Colors.transparent,
              ),
              child: ListTile(
                iconColor: GlobalColor.navigationUnselected,
                tileColor: GlobalColor.navigationUnselected,
                textColor: GlobalColor.navigationUnselected,
                selected: isOnColor[index],
                selectedColor: GlobalColor.navigationSelected,
                selectedTileColor: GlobalColor.navigationSelected,
                leading: tab.icon,
                title: Text(
                  tab.label,
                  style: widget.labelStyle ??
                      TextStyle(
                        fontFamily: 'DM Sans',
                        fontSize: screenWidth * 0.01,
                      ),
                ),
              ),
            ),
          );
        }),
      ).toList(),
    );
  }
}

class VerticalTabBarItem {
  const VerticalTabBarItem({
    required this.icon,
    required this.label,
    this.labelStyle,
    this.extraFunction,
  });
  final Widget icon;
  final String label;
  final TextStyle? labelStyle;
  final Function? extraFunction;
}

class VerticalTabController extends ChangeNotifier {
  int _index = 0;

  /// Index getter
  int get index => _index;

  /// Index setter
  set setIndex(indexValue) {
    _index = indexValue;
    notifyListeners();
  }
}

class VerticalTabBarView extends StatefulWidget {
  const VerticalTabBarView({
    Key? key,
    required this.controller,
    required this.children,
  }) : super(key: key);
  final VerticalTabController controller;
  final List<Widget> children;

  @override
  State<VerticalTabBarView> createState() => _VerticalTabBarViewState();
}

class _VerticalTabBarViewState extends State<VerticalTabBarView> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      _index = widget.controller.index;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.children[_index];
  }
}
