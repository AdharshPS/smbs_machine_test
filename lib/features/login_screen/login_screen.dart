import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smbs_machine_test/core/costants/color_constants.dart';
import 'package:smbs_machine_test/features/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:smbs_machine_test/features/login_screen/login_services.dart';
import 'package:smbs_machine_test/features/product_list_screen/product_list_screen.dart';
import 'package:smbs_machine_test/main.dart';
import 'package:smbs_machine_test/shared/alerts/snackbar.dart';
import 'package:smbs_machine_test/shared/widgets/email_textfield.dart';
import 'package:smbs_machine_test/shared/widgets/password_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscuredPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorConstants.primary,
              ),
            ),
            EmailTextfield(emailController: emailController),
            PasswordTextfield(
              passwordController: passwordController,
              obscurePassword: obscuredPassword,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                if (_formKey.currentState!.validate()) {
                  bool status = await Provider.of<LoginServices>(
                    context,
                    listen: false,
                  ).userLogin(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
                  if (!mounted) return;
                  if (status) {
                    showSnackBar(
                      scaffoldMessenger: scaffoldMessenger,
                      content: 'Login Succesful',
                      backgroundColor: ColorConstants.successColor,
                    );
                    navigatorKey.currentState?.pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => BottomNavBarScreen(),
                      ),
                    );
                  } else {
                    showSnackBar(
                      scaffoldMessenger: scaffoldMessenger,
                      content: 'Login Failed',
                      backgroundColor: ColorConstants.errorColor,
                    );
                  }
                }
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(ColorConstants.primary),
                foregroundColor: WidgetStatePropertyAll(
                  ColorConstants.scaffoldBackground,
                ),
                fixedSize: WidgetStateProperty.all(
                  Size(MediaQuery.sizeOf(context).width * .6, 50),
                ),
              ),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
