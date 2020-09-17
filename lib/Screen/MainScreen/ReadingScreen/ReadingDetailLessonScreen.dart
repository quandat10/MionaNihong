import 'package:flutter/material.dart';
import 'package:minnav2/Screen/Widget/Builder/ReadingBuilder.dart';

class ReadingDetailLessonScreen extends StatefulWidget {
  int lesson;

  ReadingDetailLessonScreen({this.lesson}) : super();

  @override
  _ReadingDetailLessonScreenState createState() =>
      _ReadingDetailLessonScreenState();
}

class _ReadingDetailLessonScreenState extends State<ReadingDetailLessonScreen>
    with SingleTickerProviderStateMixin {
  List<String> spinnerItems = [];
  int i;
  String dropdownValue;

  var run = true;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    dropdownValue = 'Bài ${widget.lesson}';
    for (i = 0; i < 20; i++) {
      spinnerItems.add("Bài ${i + 1}");
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    spinnerItems.clear();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                DropdownButton<String>(
//                  value: dropdownValue,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.black87, fontSize: 18),
                  underline: Container(
                    height: 0,
                    color: Colors.black87,
                  ),
                  onChanged: (String data) {
                    setState(() {
                      dropdownValue = data;
                      widget.lesson = int.parse(
                          dropdownValue.substring(4, dropdownValue.length));
                      ReadingBuilder(lesson: widget.lesson);
                    });
                  },
                  items: spinnerItems
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                      onTap: () {
                        setState(() {});
                      },
                    );
                  }).toList(),
                ),
              ],
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                "Bài ${widget.lesson}",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w800),
              ),
              backgroundColor: Colors.white,
            ),
            body: ReadingBuilder(lesson: widget.lesson)));
  }
}
