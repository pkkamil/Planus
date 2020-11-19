import 'package:flutter/material.dart';

class GoBackButton extends StatelessWidget {

  final String location;
  final bool pop;

  const GoBackButton({
    Key key,
    this.location = "/welcome",
    this.pop = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        left: 0,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15,vertical: 30),
          child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              onPressed:  () {
                if(pop){
                  Navigator.pop(context);
                }else{
                  Navigator.popAndPushNamed(context, location);
                }
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