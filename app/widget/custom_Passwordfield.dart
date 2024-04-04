import 'package:flutter/material.dart';
import 'package:get/get.dart';
  
class CustomPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final Function? onPressed;
 
  CustomPasswordField({
    required this.controller,
    this.obscureText = true,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        controller: controller,
        
        decoration: InputDecoration(
          labelText: 'Password',
          border: OutlineInputBorder(),
          suffixIcon: GestureDetector(
            onTap: onPressed!()  ,
            child: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off,
            ),
          ),
        ),
        obscureText: obscureText,
      ),
    );
  }
}
