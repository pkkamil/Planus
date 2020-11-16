import 'package:flutter/material.dart';
import 'package:planus/components/InputContainer.dart';

class RoundedInput extends StatelessWidget {
  final String placeholder;
  final IconData icon; 
  final Color iconColor;
  final Color color;
  final Color textColor;
  final bool password;
  final TextEditingController controller;
  final width;

  const RoundedInput({
    Key key,
    this.placeholder,
    this.icon = Icons.person,
    this.color,
    this.textColor,
    this.iconColor,
    this.password = false,
    this.width,
    this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      width: width,
      color: color,
      child: TextField(
        controller: controller,
        obscureText: password,
        cursorColor: textColor,
        decoration: InputDecoration(
        icon: Icon(
          icon,
          color: iconColor,
        ),
        hintText: placeholder,
        border: InputBorder.none
       ),
      )
    );
  }
}