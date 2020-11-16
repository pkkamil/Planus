import 'package:flutter/material.dart';

class GoBackButton extends StatelessWidget {

  final isLeft;
  const GoBackButton({
    Key key,
    this.isLeft = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
        top: 0,
        left: isLeft ? 0 : size.width,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15,vertical: 30),
          child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              onPressed:  () {
                Navigator.pushReplacementNamed(context, '/welcome');
              },
              color: Colors.orange,
              child: Text(
                "Wróć".toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              )
          ),
        )
      ) 
    );
  }
}