import 'package:flutter/material.dart';
import 'package:planus/screens/choice/choice_screen.dart';

class AddFlatCard extends StatelessWidget {
  const AddFlatCard({
    Key key,
    this.size,
    this.fontSize = 128.0,
    this.marginL= 20.0,
    this.marginT= 20.0,
    this.marginR= 20.0,
    this.marginB= 20.0,
    this.user_id,
  }) : super(key: key);

  final size;
  final user_id;
  final fontSize;
  final marginL,marginT,marginR,marginB;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //Idz do dodawania mieszkania
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) => Choice(user_id)));
      },
        child: Container(
          width: size,
          height: size,
          margin: EdgeInsets.fromLTRB(marginL, marginT, marginR, marginB),
            child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orange
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: fontSize,
                )
              ),
            ),
          ),
        )
      );
    }
}