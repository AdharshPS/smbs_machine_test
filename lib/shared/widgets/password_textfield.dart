import 'package:flutter/material.dart';
import 'package:smbs_machine_test/core/costants/icon_constants.dart';

class PasswordTextfield extends StatefulWidget {
  PasswordTextfield({
    super.key,
    required this.passwordController,
    required this.obscurePassword,
  });
  final TextEditingController passwordController;
  bool obscurePassword;

  @override
  State<PasswordTextfield> createState() => _PasswordTextfieldState();
}

class _PasswordTextfieldState extends State<PasswordTextfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: widget.passwordController,
        obscureText: widget.obscurePassword,

        decoration: InputDecoration(
          hint: Text(AutofillHints.password),
          border: OutlineInputBorder(),
          prefixIcon: IconConstants.passwordIcon,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                widget.obscurePassword = !widget.obscurePassword;
              });
            },
            icon:
                widget.obscurePassword
                    ? IconConstants.passwordVisible
                    : IconConstants.passwordVisibleOff,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Password is required';
          }
          if (value.length < 6) {
            return 'Password length should be atleast 6 characters';
          }
          return null;
        },
      ),
    );
  }
}
