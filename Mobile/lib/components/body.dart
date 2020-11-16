import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  final AssetImage image;
  final height;

  const Background({
    Key key,
    this.child,
    this.image,
    this.height

  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(Colors.orange.withOpacity(0.5), BlendMode.softLight),
          image: image,
          fit: BoxFit.cover
        )
      ),
      child: Center(
        child: child,
      ),
    );
  }
}