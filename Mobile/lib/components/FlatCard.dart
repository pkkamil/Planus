import 'package:flutter/material.dart';

class FlatCard extends StatelessWidget {
  const FlatCard({
    Key key,
    this.flat_name,
    this.image,
    this.size,
    this.fontSize = 18.0,
    this.marginL= 20.0,
    this.marginT= 20.0,
    this.marginR= 20.0,
    this.marginB= 20.0
  }) : super(key: key);

  final flat_name;
  final size;
  final String image;
  final fontSize;
  final marginL,marginT,marginR,marginB;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(marginL, marginT, marginR, marginB),
      decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
        color: Colors.grey.withOpacity(0.4),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3),
      ),
      ]
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/home');
        },
          child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
            image:DecorationImage(
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
              image: AssetImage(image)
            )
          ),
          child: Center(
            child: Text(
              flat_name.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.orange[400],
              ),
            ),
          ),
          )
        ),
      ),
    );
  }
}