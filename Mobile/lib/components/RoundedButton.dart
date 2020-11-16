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

  const RoundedButton({
    this.text,
    this.onPress,
    this.color = Colors.blue,
    this.textColor = Colors.black,
    this.width,
    this.fontsize = 20.0,
    this.vertical = 20.0,
    this.horizontal = 40.0,
    this.radius = 30.0,
    this.marginV = 10.0,
    this.marginH = 0.0,
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: marginV, horizontal: marginH),
      width: width,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
            child: FlatButton(
            padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
            onPressed: onPress,
            color: color,
            child: Text(
              text.toUpperCase(),
              style: TextStyle(
                color: textColor,
                fontSize: fontsize,
              ),
            )
        ),
      ),
    );
  }
}