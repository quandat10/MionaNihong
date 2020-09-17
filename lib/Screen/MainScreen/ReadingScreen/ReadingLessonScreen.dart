import 'package:flutter/material.dart';
import 'package:minnav2/Screen/MainScreen/ReadingScreen/ReadingDetailLessonScreen.dart';

class ReadingLessonScreen extends StatefulWidget {
  @override
  _ReadingLessonScreenState createState() => _ReadingLessonScreenState();
}

class _ReadingLessonScreenState extends State<ReadingLessonScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          title: Text(
            "Luyện đọc",
            style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.w800),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(0.0),
          child: GridView.builder(
            padding: EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),

            itemCount: 50,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4),
            // ignore: missing_return
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ReadingDetailLessonScreen(
                              lesson: index + 1,
                            )));
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 5.0, right: 2.5, left: 2.5),
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
