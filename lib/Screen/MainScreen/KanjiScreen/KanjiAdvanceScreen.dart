import 'package:flutter/material.dart';
import 'package:minnav2/Screen/MainScreen/KanjiScreen/KanjiLessonAdvanceScreen.dart';

class KanjiAdvanceScreen extends StatefulWidget {
  @override
  _KanjiAdvanceScreenState createState() => _KanjiAdvanceScreenState();
}

class _KanjiAdvanceScreenState extends State<KanjiAdvanceScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Bài Học",
            style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.w800),
          ),
        ),
        body: Padding(
          padding:
              EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0, bottom: 10.0),
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
                                KanjiLessonAdvanceScreen(lesson: index + 1)));
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        right: 5.0, left: 5.0, top: 15.0, bottom: 15.0),
                    margin: EdgeInsets.only(bottom: 10.0, right: 5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.lightGreen),
                    child: Center(
                      child: Text((index + 1).toString()),
                    ),
                  ));
            },
          ),
        ));
  }
}
