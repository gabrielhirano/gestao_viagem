import 'package:flutter/material.dart';
import 'package:gestao_viajem/core/layout/components/app_text.dart';
import 'package:gestao_viajem/core/layout/foundation/app_shapes.dart';
import 'package:gestao_viajem/core/theme/theme_global.dart';
import 'package:gestao_viajem/feature/home/view/screen/home_screen.dart';
import 'package:gestao_viajem/feature/payment/view/screen/corporate_card_screen.dart';
import 'package:gestao_viajem/feature/profile/view/screen/profile_screen.dart';
import 'package:gestao_viajem/feature/ticket/view/screen/tickets_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> bottomNavigatorScreens = const [
    HomeScreen(),
    TicketsScreen(),
    CorporateCardScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.white,
      appBar: AppBar(
        title: const AppText(
          text: 'Onfly',
          textStyle: AppTextStyle.headerH4,
        ),
      ),
      body: bottomNavigatorScreens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedFontSize: 0,

        backgroundColor: appColors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        // landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
        type: BottomNavigationBarType.fixed,
        items: [
          _buildBottomNavigationItem(
            selected: _currentIndex == 0,
            icon: Icon(
              Icons.home_filled,
              color: appColors.colorBrandPrimaryBlue,
            ),
          ),
          _buildBottomNavigationItem(
              selected: _currentIndex == 1,
              icon: Icon(
                Icons.airplane_ticket_outlined,
                color: appColors.colorBrandPrimaryBlue,
              )),
          _buildBottomNavigationItem(
              selected: _currentIndex == 2,
              icon: Icon(
                Icons.credit_card,
                color: appColors.colorBrandPrimaryBlue,
              )),
          _buildBottomNavigationItem(
              selected: _currentIndex == 3,
              icon: Icon(
                Icons.person,
                color: appColors.colorBrandPrimaryBlue,
              )),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationItem({
    required Widget icon,
    required bool selected,
  }) {
    return BottomNavigationBarItem(
      label: '',
      icon: Column(
        children: [
          icon,
          const SizedBox(height: 4),
          SizedBox(
            height: 4,
            child: Visibility(
              visible: selected,
              child: Container(
                width: 20,
                height: 4,
                decoration: AppShapes.decoration(
                  radius: RadiusSize.medium,
                  color: appColors.colorBrandPrimaryBlue,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
