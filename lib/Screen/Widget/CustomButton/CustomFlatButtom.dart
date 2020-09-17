import 'package:flutter/material.dart';

class CustomFlatButtom extends StatefulWidget {
  final String name;
  final Object PageRoute;

  CustomFlatButtom({this.name, this.PageRoute}) : super();

  @override
  _CustomFlatButtomState createState() => _CustomFlatButtomState();
}

class _CustomFlatButtomState extends State<CustomFlatButtom> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.green)),
      color: Colors.white,
      textColor: Colors.green,
      padding: EdgeInsets.all(8.0),
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => widget.PageRoute));
      },
      child: Text(
        widget.name.toUpperCase(),
        style: TextStyle(
          fontSize: 14.0,
        ),
      ),
    );
  }
}
