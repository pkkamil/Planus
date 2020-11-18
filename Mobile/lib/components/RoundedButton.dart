import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function onPress;
  final Color color, textColor;
  final width;
  final fontsize;
  final vertical;
  final horizontal;
  final radius;
  final marginV;
  final marginH;
  final bool isShadow;

  const RoundedButton({
    this.text,
    this.onPress,
    this.color = Colors.orange,
    this.textColor = Colors.white,
    this.width,
    this.fontsize = 20.0,
    this.vertical = 20.0,
    this.horizontal = 40.0,
    this.radius = 30.0,
    this.marginV = 10.0,
    this.marginH = 0.0,
    this.isShadow = true,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: marginV, horizontal: marginH),
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
        color: Colors.orange,
        width: 2.0,
        ),
        borderRadius: BorderRadius.circular(radius),
        color: color,
        boxShadow: [
          if(isShadow) BoxShadow(
          color: color.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3),
          ),
        ],

      ),
      child:FlatButton(
          padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
          onPressed: onPress,
          child: Text(
            text.toUpperCase(),
            style: TextStyle(
              color: textColor,
              fontSize: fontsize,
            ),
          )
        ),
    );
  }
}