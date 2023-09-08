import 'package:cache_manager/cache_manager.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:p_notify/presentation/screens/notifications/notification.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:p_notify/app/constants/app.colors.dart';
import 'package:p_notify/app/constants/app.keys.dart';
import 'package:p_notify/core/notifiers/theme.notifier.dart';
import 'package:p_notify/core/notifiers/user.notifier.dart';
import 'package:p_notify/presentation/screens/productScreen/product.screen.dart';
import 'package:p_notify/presentation/screens/profileScreens/mainProfileScreen/profile.screen.dart';
import 'package:p_notify/presentation/screens/searchScreen/search.screen.dart';

final List<SalomonBottomBarItem> bottomNavBarIcons = [
  SalomonBottomBarItem(
    icon: const Icon(Icons.home),
    title: const Text("Home"),
    selectedColor: Colors.purple,
  ),

  /// Search
  SalomonBottomBarItem(
    icon: const Icon(Icons.search),
    title: const Text("Search"),
    selectedColor: Colors.orange,
  ),

  SalomonBottomBarItem(
    icon: const Icon(Icons.notifications),
    title: const Text("Notification"),
    selectedColor: Colors.teal,
  ),

  SalomonBottomBarItem(
    icon: const Icon(EvaIcons.person),
    title: const Text("Profile"),
    selectedColor: Colors.amber,
  ),
];

final screens = [
  const ProductScreen(),
  const SearchScreen(),
  const Notifications(),
  const ProfileScreen(),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final userNotifier = Provider.of<UserNotifier>(context, listen: false);
    ReadCache.getString(key: AppKeys.userData).then(
      (token) => {
        userNotifier.getUserData(context: context, token: token),
      },
    );
    super.initState();
  }

  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;
    return Scaffold(
      backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
      body: screens[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        selectedItemColor:
            themeFlag ? AppColors.rawSienna : const Color(0xff4B7191),
        unselectedItemColor: themeFlag ? Colors.white : const Color(0xff777777),
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: bottomNavBarIcons,
      ),
    );
  }
}
