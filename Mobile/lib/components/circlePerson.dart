import 'package:flutter/material.dart';

class PersonCircle extends StatelessWidget {
  const PersonCircle({
    Key key,
    this.image = "assets/avatar.png",
    this.size,
    this.name
  }) : super(key: key);

  final String image;
  final Size size;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [Container(
        margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
        height: 50,
        width: 50,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(
              color: Colors.orange,
              width: 2.0,
            ),
          ),         
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover
                )
              ),
            ),
          )
        ),
      ),
      Text(
        name,
        style: TextStyle(
          color: Colors.grey[900],
          fontSize: 12
        ),
      )
      ]
    );
  }
}

class AddPersonCircle extends StatelessWidget {
  const AddPersonCircle({
    Key key,
    this.size
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [Container(
        margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
        height: 50,
        width: 50,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(
              color: Colors.orange,
              width: 2.0,
            ),
          ),         
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orange
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
      ),
      Text(
        "",
        style: TextStyle(
          color: Colors.grey[900],
          fontSize: 12
        ),
      )
      ]
    );
  }
}