import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:minnav2/Screen/Widget/Builder/KanjiBasicBuilder.dart';

FlutterTts flutterTts;

class KanjiLessonBasicScreen extends StatefulWidget {
  int lesson;

  KanjiLessonBasicScreen({this.lesson}) : super();

  @override
  _KanjiLessonBasicScreenState createState() => _KanjiLessonBasicScreenState();
}

class _KanjiLessonBasicScreenState extends State<KanjiLessonBasicScreen> {
  List<String> spinnerItems = [];
  int i;
  String dropdownValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownValue = 'Bài ${widget.lesson}';
    for (i = 0; i < 32; i++) {
      spinnerItems.add("Bài ${i + 1}");
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    spinnerItems.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  KanjiBasicBuilder(
                    lesson: widget.lesson,
                  );
                });
              },
              items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
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
            dropdownValue,
            style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.w800),
          ),
          backgroundColor: Colors.white,
        ),
        body: KanjiBasicBuilder(
          lesson: widget.lesson,
        ));
  }
}
