import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:flutter_app/app/ui/screens/user_page/search_screen.dart';
import 'package:flutter_app/app/ui/screens/user_page/transaction_page.dart';
import 'package:flutter_app/app/ui/screens/user_page/user_home_screen.dart';
import 'package:flutter_app/app/ui/screens/user_page/wishlist_page.dart';
import 'package:flutter_app/app/ui/screens/user_section.dart/user_section.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavigationSection extends StatefulWidget {
  @override
  _NavigationSectionState createState() => _NavigationSectionState();
}

class _NavigationSectionState extends State<NavigationSection> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String _fcmToken;
  int _currentIndex = 0;
  final List<Widget> _children = [
    UserHomeScreen(),
    SearchScreen(),
    TransactionPage(),
    WishlistPage(),
    UserSection(),
  ];

  generateToken() async {
    _fcmToken = await _firebaseMessaging.getToken();
    print("FCM Token : $_fcmToken");
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    generateToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: SizedBox(
        height: 56,
        child: BottomNavigationBar(
          elevation: 9,
          iconSize: 23,
          type: BottomNavigationBarType.fixed,
          selectedIconTheme: IconThemeData(color: Colors.indigo[300]),
          unselectedIconTheme: IconThemeData(color: Colors.grey[400]),
          selectedFontSize: 15,
          unselectedFontSize: 14,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(
                  _currentIndex == 0 ? Icons.home : Icons.home_outlined,
                  size: 25),
              title: new Text(
                'Home',
                style: AppModule.smallText.copyWith(
                  color: _currentIndex == 0 ? Colors.indigo : Colors.grey,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: new Icon(
                  _currentIndex == 1
                      ? Icons.search
                      : Icons.manage_search_rounded,
                  size: 25),
              title: new Text(
                'Search Product',
                style: AppModule.smallText.copyWith(
                  color: _currentIndex == 1 ? Colors.indigo : Colors.grey,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: new FaIcon(
                  _currentIndex == 2
                      ? FontAwesomeIcons.solidFileAlt
                      : FontAwesomeIcons.fileAlt,
                  size: 22),
              title: new Text(
                'Transaksi',
                style: AppModule.smallText.copyWith(
                  color: _currentIndex == 2 ? Colors.indigo : Colors.grey,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  _currentIndex == 3
                      ? Icons.favorite_rounded
                      : Icons.favorite_outline_rounded,
                  size: 24),
              title: Text(
                'Wishlist',
                style: AppModule.smallText.copyWith(
                  color: _currentIndex == 3 ? Colors.indigo : Colors.grey,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  _currentIndex == 4
                      ? Icons.person_rounded
                      : Icons.person_outline_rounded,
                  size: 24),
              title: Text(
                'Account',
                style: AppModule.smallText.copyWith(
                  color: _currentIndex == 4 ? Colors.indigo : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
