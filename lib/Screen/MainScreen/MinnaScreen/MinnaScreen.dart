import 'package:flutter/material.dart';
import 'package:minnav2/Screen/MainScreen/MinnaScreen/MinnaLessonScreen.dart';

class MinnaScreen extends StatefulWidget {
  @override
  _MinnaScreenState createState() => _MinnaScreenState();
}

class _MinnaScreenState extends State<MinnaScreen> {
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
          title: Text(
            "Minna",
            style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.w800),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          child: GridView.builder(
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 10.0, right: 10.0, left: 10.0),
              itemCount: 50,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5),
              // ignore: missing_return
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MinnaLessonScreen(lesson: index + 1)));
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
              }),
        ));
  }
}
