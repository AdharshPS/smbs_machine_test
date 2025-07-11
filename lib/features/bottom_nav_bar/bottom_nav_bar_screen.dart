import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smbs_machine_test/core/costants/color_constants.dart';
import 'package:smbs_machine_test/core/costants/icon_constants.dart';
import 'package:smbs_machine_test/features/bought_items/bought_items_screen.dart';
import 'package:smbs_machine_test/features/login_screen/login_screen.dart';
import 'package:smbs_machine_test/features/product_list_screen/product_list_screen.dart';
import 'package:smbs_machine_test/main.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    if (index == 2) {
      showDialog(
        context: navigatorKey.currentContext!,
        builder:
            (context) => AlertDialog(
              title: Text('Logout'),
              content: Text('Do you want to logout'),
              actions: [
                TextButton(
                  onPressed: () {
                    navigatorKey.currentState?.pop();
                  },
                  child: Text('cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.remove('token');
                    navigatorKey.currentState?.pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false,
                    );
                  },
                  child: Text('Logout'),
                ),
              ],
            ),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  List<Widget> screens = [ProductListScreen(), BoughtItemsScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0
              ? 'Product List'
              : _selectedIndex == 1
              ? 'Ordered List'
              : '',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: ColorConstants.secondary,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorConstants.primary,
        selectedItemColor: ColorConstants.secondary,
        unselectedItemColor: ColorConstants.scaffoldBackground,
        items: [
          BottomNavigationBarItem(icon: IconConstants.listIcon, label: 'Items'),
          BottomNavigationBarItem(
            icon: IconConstants.orderIcon,
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: IconConstants.logoutIcon,
            label: 'Logout',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: screens[_selectedIndex],
    );
  }
}
