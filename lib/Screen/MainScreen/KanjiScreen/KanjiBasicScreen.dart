import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:minnav2/Screen/MainScreen/KanjiScreen/KanjiLessonBasicScreen.dart';

import 'KanjiLessonAdvanceScreen.dart';

class KanjiBasicScreen extends StatefulWidget {
  @override
  _KanjiBasicScreenState createState() => _KanjiBasicScreenState();
}

class _KanjiBasicScreenState extends State<KanjiBasicScreen> {
  ScrollController _scrollController =
      new ScrollController(); // set controller on scrolling
  bool isScrollingDown = false;
  bool check = true;
  double bottomBarHeight = 75; // set bottom bar height

  String dropdownValue = 'Cơ bản';

  List<String> spinnerItems = [
    'Cơ bản',
    'Nâng cao',
  ];

  @override
  void initState() {
    super.initState();
//    myScroll();
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {});
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            DropdownButton<String>(
              value: dropdownValue,
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
                });
              },
              items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                  onTap: () {
                    setState(() {
                      check = !check;
                    });
                  },
                );
              }).toList(),
            ),
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          title: Text(
            "Kanji",
            style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.w800),
          ),
        ),
        body: check == true
            ? Container(
                child: GridView.builder(
                  padding: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
                  controller: _scrollController,
                  // ignore: missing_return
                  itemCount: 32,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => KanjiLessonBasicScreen(
                                      lesson: index + 1)));
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 5.0, right: 5.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.black12),
                          child: Center(
                            child: Text((index + 1).toString()),
                          ),
                        ));
                  },
                ),
              )
            : Padding(
                padding: EdgeInsets.only(
                    left: 10.0, top: 10.0, right: 5.0, bottom: 5.0),
                child: GridView.builder(
                  // ignore: missing_return
                  itemCount: 20,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      KanjiLessonAdvanceScreen(
                                          lesson: index + 1)));
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 5.0, right: 5.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.black12),
                          child: Center(
                            child: Text((index + 1).toString()),
                          ),
                        ));
                  },
                ),
              ));
  }
}
