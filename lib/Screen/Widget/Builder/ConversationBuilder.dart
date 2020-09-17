import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:minnav2/Database/databasev9.dart';
import 'package:minnav2/Model/MindaV9Db/Data.dart';

class ConversationnBuilder extends StatefulWidget {
  int lesson;

  ConversationnBuilder({this.lesson}) : super();

  @override
  _ConversationnBuilderState createState() => _ConversationnBuilderState();
}

class _ConversationnBuilderState extends State<ConversationnBuilder> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Data>>(
      future: DBProvider.db.getConversationByLessonId(widget.lesson),
      // ignore: missing_return
      builder: (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              // ignore: missing_return
              itemBuilder: (context, idx) {
                return FutureBuilder<List<Data>>(
                  future: DBProvider.db.getMiniConversationByLessonId(
                      snapshot.data[idx].lesson_id),
                  // ignore: missing_return, non_constant_identifier_names
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Data>> snapshot2) {
                    if (snapshot2.hasData) {
                      return Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 10.0),
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  width: 1.0, color: Colors.black12)),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot2.data.length,

                              // ignore: missing_return
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              snapshot2.data[index].name +
                                                  " : ",
                                              style: TextStyle(
                                                  color: index % 2 == 0
                                                      ? Colors.red
                                                      : Colors.blue,
                                                  fontSize: 20.0)),
                                          Flexible(
                                            child: Html(
                                                data:
                                                    snapshot2.data[index].kanji,
                                                defaultTextStyle: TextStyle(
                                                    color: index % 2 == 0
                                                        ? Colors.lightGreen
                                                        : Colors
                                                            .deepPurpleAccent,
                                                    fontSize: 20.0)),
                                          )
                                        ]),
                                    Text(
                                      snapshot2.data[index].mean,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18.0),
                                    )
                                  ],
                                );
                              }));
                    } else
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                  },
                );
              });
        } else
          return Center(
            child: CircularProgressIndicator(),
          );
      },
    );
  }
}
