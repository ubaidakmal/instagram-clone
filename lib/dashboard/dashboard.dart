import 'package:flutter/material.dart';
import 'package:insta/dashboard/homePage.dart';
import 'package:insta/dashboard/profile.dart';
import 'package:insta/utiles/colors.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int _page = 0;
  PageController _pageController = PageController();

  var homeScreenItems = const [
    HomePage(),
    Center(child: Text('Search')),
    Center(child: Text('Add')),
    Center(child: Text('Favorite')),
    ProfileScreen()
  ];

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void navigationPage(int page) {
    _pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        items: [
        BottomNavigationBarItem(
            icon: Icon(
          Icons.home,
          color: _page == 0 ? primaryColor : secondaryColor,
        ),
        label:'Home',
        ),
        BottomNavigationBarItem(
            icon: Icon(
          Icons.search,
          color: _page == 1 ? primaryColor : secondaryColor,
        ),
        label:'Search',
        backgroundColor: Colors.white
        ),
        BottomNavigationBarItem(
            icon: Icon(
          Icons.add_circle,
          color: _page == 2 ? primaryColor : secondaryColor,
        ),
        label:'Add Photo',
        ),
        BottomNavigationBarItem(
            icon: Icon(
          Icons.favorite,
          color: _page == 3 ? primaryColor : secondaryColor,
        ),
        label:'Favorite',
        ),
        BottomNavigationBarItem(
            icon: Icon(
          Icons.person,
          color: _page == 4 ? primaryColor : secondaryColor,
        ),
        label:'Profile',
        ),
      ],
      onTap: navigationPage,
      ),
    ));
  }
}

