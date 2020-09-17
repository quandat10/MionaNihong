import 'package:flutter/material.dart';

class CustomRaiseButton extends StatefulWidget {
  final Object PageRoute;
  final String name;

  CustomRaiseButton({this.name, this.PageRoute}) : super();

  @override
  _CustomRaiseButtonState createState() => _CustomRaiseButtonState();
}

class _CustomRaiseButtonState extends State<CustomRaiseButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.green)),
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => widget.PageRoute));
      },
      color: Colors.green,
      textColor: Colors.white,
      child: Text(widget.name.toUpperCase(), style: TextStyle(fontSize: 14)),
    );
  }
}
