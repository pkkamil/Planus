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
      child: InkWell(
        onTap: () {
          print(flat_name);
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
              //flat_name.toUpperCase(),
              flat_name.toString(),
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