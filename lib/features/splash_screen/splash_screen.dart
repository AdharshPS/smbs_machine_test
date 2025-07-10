import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smbs_machine_test/core/costants/color_constants.dart';
import 'package:smbs_machine_test/features/login_screen/login_screen.dart';
import 'package:smbs_machine_test/features/product_list_screen/product_list_screen.dart';
import 'package:smbs_machine_test/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      Future.delayed(Duration(milliseconds: 1500)).then(
        (value) => navigatorKey.currentState?.pushReplacement(
          MaterialPageRoute(
            builder:
                (context) =>
                    token == null ? LoginScreen() : ProductListScreen(),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Products',
          style: TextStyle(
            color: ColorConstants.primary,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
