import 'package:flutter/material.dart';
import 'package:smbs_machine_test/core/costants/color_constants.dart';
import 'package:provider/provider.dart';
import 'package:smbs_machine_test/features/login_screen/login_services.dart';
import 'package:smbs_machine_test/features/product_details_screen/buy_product_service.dart';
import 'package:smbs_machine_test/features/product_list_screen/product_services.dart';
import 'package:smbs_machine_test/features/splash_screen/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginServices()),
        ChangeNotifierProvider(create: (context) => ProductServices()),
        ChangeNotifierProvider(create: (context) => BuyProductService()),
      ],
      child: MainScreen(),
    ),
  );
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorConstants.scaffoldBackground,
        appBarTheme: AppBarTheme(
          backgroundColor: ColorConstants.scaffoldBackground,
        ),
      ),
      home: SplashScreen(),
    );
  }
}
