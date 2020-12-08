import 'package:flutter/material.dart';

class PersonCircle extends StatelessWidget {
  const PersonCircle({
    Key key,
    this.image = "assets/avatar.png",
    this.size,
    this.name,
    this.onTap
  }) : super(key: key);

  final String image;
  final Size size;
  final String name;
  final Function onTap;

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
          child: GestureDetector(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.orange
                ),
                alignment: Alignment.center,
                child: Text(
                  name[0].toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24
                  ),
                ),
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
    this.onTap,
    this.size
  }) : super(key: key);

  final Size size;
  final Function onTap;

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
          child: GestureDetector(
            onTap: onTap,
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