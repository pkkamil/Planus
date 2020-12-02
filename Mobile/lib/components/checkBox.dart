import 'package:flutter/material.dart';

class FlatCheckBox extends StatefulWidget {

  final Function onTap;

  const FlatCheckBox({
    Key key,
    this.onTap
  }) : super(key: key);
  @override
  _FlatCheckBoxState createState() => _FlatCheckBoxState();
}

class _FlatCheckBoxState extends State<FlatCheckBox> {

  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
        setState(widget.onTap);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: _isSelected ? Colors.orange : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.orange, width: 1.0)
        ),
        child: Icon(
          Icons.check,
          color: _isSelected ? Colors.white : Colors.orange,
          size: 30,
        ),
      ),
    );
  }
}