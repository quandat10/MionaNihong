import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:minnav2/Screen/Widget/Builder/KanjiAdvanceBuilder.dart';

FlutterTts flutterTts;

class KanjiLessonAdvanceScreen extends StatefulWidget {
  int lesson;

  KanjiLessonAdvanceScreen({this.lesson}) : super();

  @override
  _KanjiLessonAdvanceScreenState createState() =>
      _KanjiLessonAdvanceScreenState();
}

class _KanjiLessonAdvanceScreenState extends State<KanjiLessonAdvanceScreen> {
  List<String> spinnerItems = [];
  int i;
  String dropdownValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownValue = 'Bài ${widget.lesson}';
    for (i = 0; i < 20; i++) {
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
                  KanjiAdvanceBuilder(
                    lesson: widget.lesson,
                  );
                });
              },
              items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                  onTap: () {},
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
        backgroundColor: Colors.white,
        body: KanjiAdvanceBuilder(
          lesson: widget.lesson,
        ));
  }
}
