import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:minnav2/Database/databasev5.dart';
import 'package:minnav2/Model/ReadV5Db/ReadingModel.dart';
import 'package:minnav2/Model/ReadV5Db/Vocab.dart';

class ReadingBuilder extends StatefulWidget {
  int lesson;

  ReadingBuilder({this.lesson}) : super();

  @override
  _ReadingBuilderState createState() => _ReadingBuilderState();
}

class _ReadingBuilderState extends State<ReadingBuilder> {
  List<Choice> choices = <Choice>[
    const Choice(title: 'Bài Đọc', icon: Icons.directions_car),
    const Choice(title: "Bài Dịch", icon: Icons.directions_bike),
    const Choice(title: 'Từ Mới', icon: Icons.directions_boat),
    const Choice(title: 'Ngữ Pháp', icon: Icons.directions_boat),
    const Choice(title: 'Hướng Dẫn', icon: Icons.directions_boat),
  ];
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    choices.clear();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: choices.length,
        child: Scaffold(
            appBar: TabBar(
              labelColor: Colors.black,
              isScrollable: true,
              tabs: choices.map((Choice choice) {
                return Tab(
                  text: choice.title,
                );
              }).toList(),
            ),
            body: FutureBuilder<List<ReadingModel>>(
              future: DBProvider2.db.getAllIDReading(widget.lesson),
              // ignore: missing_return
              builder: (BuildContext context,
                  AsyncSnapshot<List<ReadingModel>> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    padding: EdgeInsets.all(10.0),
                    child: TabBarView(children: <Widget>[
                      _baidoc(snapshot.data),
                      _baidich(snapshot.data),
                      _tumoi(widget.lesson),
                      _nguphap(snapshot.data),
                      _huongdan(snapshot.data),
                    ]),
                  );
                } else
                  return CircularProgressIndicator();
              },
            )));
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

Widget _tumoi(int lesson) {
  return FutureBuilder<List<Vocab>>(
    future: DBProvider2.db.getAllContentByLesson(lesson),
    // ignore: missing_return
    builder: (BuildContext context, AsyncSnapshot<List<Vocab>> snapshot) {
      if (snapshot.hasData) {
        return ListView.builder(
          itemCount: snapshot.data.length,
          // ignore: missing_return
          itemBuilder: (context, index) {
            Vocab item = snapshot.data[index];
            return Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        item.id.toString() + ". ",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        item.hiragana,
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0),
                      ),
                    ],
                  ),
                  Text(
                    item.kanji,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    item.cn_mean,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    item.mean,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            );
          },
        );
      } else
        return Center(
          child: CircularProgressIndicator(),
        );
    },
  );
}

Widget _baidoc(List<ReadingModel> item) {
  return Container(
    child: ListView(
      children: [
        Html(
          data: item[0].baidoc.trim(),
        )
      ],
    ),
  );
}

Widget _baidich(List<ReadingModel> item) {
  return Container(
    child: ListView(
      children: [
        Html(
          data: item[0].baidich.trim(),
        )
      ],
    ),
  );
}

Widget _nguphap(List<ReadingModel> item) {
  return Container(
    child: ListView(
      children: [
        Html(
          data: item[0].nguphap.trim(),
        )
      ],
    ),
  );
}

Widget _huongdan(List<ReadingModel> item) {
  return Container(
    child: ListView(
      children: [
        Html(
          data: item[0].huongdan.trim(),
        )
      ],
    ),
  );
}
