import 'package:flutter/material.dart';
import 'package:smbs_machine_test/core/costants/icon_constants.dart';

class EmailTextfield extends StatefulWidget {
  const EmailTextfield({super.key, required this.emailController});
  final TextEditingController emailController;

  @override
  State<EmailTextfield> createState() => _EmailTextfieldState();
}

class _EmailTextfieldState extends State<EmailTextfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: widget.emailController,
        decoration: InputDecoration(
          hint: Text(AutofillHints.email),
          border: OutlineInputBorder(),
          prefixIcon: IconConstants.emailIcon,
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Email is required';
          }
          final emailRegex = RegExp(
            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
          );
          if (!emailRegex.hasMatch(value)) {
            return 'Invalid email address';
          }
          return null;
        },
      ),
    );
  }
}
