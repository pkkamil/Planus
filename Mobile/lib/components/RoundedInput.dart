import 'package:flutter/material.dart';
import 'package:planus/components/InputContainer.dart';
import 'dart:io' show Platform;

class RoundedInput extends StatelessWidget {
  final String placeholder;
  final IconData icon; 
  final Color iconColor;
  final Color color;
  final Color textColor;
  final bool password;
  final TextEditingController controller;
  final width;
  final onChanged;
  final Function onCompleted;
  final bool isEnabled;
  final bool isNumber;

  const RoundedInput({
    Key key,
    this.placeholder,
    this.icon = Icons.person,
    this.color,
    this.textColor,
    this.iconColor,
    this.password = false,
    this.width,
    this.controller,
    this.onChanged,
    this.isEnabled=true,
    this.onCompleted,
    this.isNumber = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      width: width,
      color: color,
      child: TextField(
        enabled: isEnabled,
        controller: controller,
        obscureText: password,
        cursorColor: textColor,
        decoration: InputDecoration(
        icon: Icon(
          icon,
          color: iconColor,
        ),
        hintText: placeholder,
        border: InputBorder.none,
       ),
       onChanged: onChanged,
       //onSubmitted: onCompleted,
       onEditingComplete: onCompleted,
       keyboardType: (Platform.isAndroid==true) ? isNumber ? TextInputType.number : TextInputType.text : TextInputType.text
      )
    );
  }
}