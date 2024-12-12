import 'package:athlete_aware/utils/colors.dart';
import 'package:athlete_aware/utils/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MobileScreenLayout extends StatefulWidget {
  final int initialPage;

  const MobileScreenLayout({super.key, this.initialPage = 0});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  late int _page;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    _page = widget.initialPage;  // Set the initial page from the widget's constructor
    pageController = PageController(initialPage: _page);  // Set the initial page for the PageController
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _page == 0 ? primaryColor : secondaryColor,
            ),
            label: 'Home',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.file_copy,
              size: 21,
              color: _page == 1 ? primaryColor : secondaryColor,
            ),
            label: 'News',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.forum,
              size: 22,
              color: _page == 2 ? primaryColor : secondaryColor,
            ),
            label: 'Forum',
            backgroundColor: primaryColor,
          ),
           BottomNavigationBarItem(
            icon: Icon(
              Icons.plumbing,
              color: _page == 3 ? primaryColor : secondaryColor,
            ),
            label: 'Tools',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _page == 4 ? primaryColor : secondaryColor,
            ),
            label: 'Yuvasaathi',
            backgroundColor: primaryColor,
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
