import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobi_health/svg_assets.dart' as svg_assets;

class AppButtomNavigation extends StatefulWidget {
  final PageController pageController;

  const AppButtomNavigation({super.key, required this.pageController});

  @override
  State<AppButtomNavigation> createState() => _AppButtomNavigationState();
}

class _AppButtomNavigationState extends State<AppButtomNavigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.pageController.jumpToPage(index);
  }

  ColorFilter getCurrentIndexColorFilter(index){
    return  ColorFilter.mode(_selectedIndex == index ? const Color(0xFF371B34) : const Color(0xFFCDD0E3), BlendMode.srcIn);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              svg_assets.homeIcon,
              colorFilter: getCurrentIndexColorFilter(0),
              ),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon:SvgPicture.asset(
              svg_assets.customerSupportIcon,
              colorFilter: getCurrentIndexColorFilter(1),
              ),
            label: 'custom support',
          ),
          BottomNavigationBarItem(
            icon:SvgPicture.asset(
              svg_assets.bookIcon,
              colorFilter: getCurrentIndexColorFilter(2),
              ),
            label: 'read',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              svg_assets.deviceIcon,
              colorFilter: getCurrentIndexColorFilter(3),
              ),
            label: 'device',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      );
  }
}