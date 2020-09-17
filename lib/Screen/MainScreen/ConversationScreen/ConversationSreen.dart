import 'package:flutter/material.dart';
import 'package:minnav2/Screen/MainScreen/ConversationScreen/ConversationLessonScreen.dart';

class ConversationScreen extends StatefulWidget {
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
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
          "Hội thoại",
          style: TextStyle(
              color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.white,
      ),
      body: GridView.builder(
          padding: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
          itemCount: 20,
          gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          // ignore: missing_return
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ConversationLessonScreen(lesson: index + 1)));
                },
                child: Container(
                  padding: EdgeInsets.only(
                      right: 5.0, left: 5.0, top: 15.0, bottom: 15.0),
                  margin: EdgeInsets.only(bottom: 5.0, right: 5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.black12),
                  child: Center(
                    child: Text((index + 1).toString()),
                  ),
                ));
          }),
    );
  }
}
