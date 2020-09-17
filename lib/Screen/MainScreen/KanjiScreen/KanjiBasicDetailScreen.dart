import 'package:flutter/material.dart';
import 'package:minnav2/Database/databasev9.dart';
import 'package:minnav2/Model/MindaV9Db/Ikanji.dart';
import 'package:minnav2/Screen/Widget/PlayGround.dart';

class KanjiBasicDetailScreen extends StatefulWidget {
  String word;
  int lesson;

  KanjiBasicDetailScreen({this.word, this.lesson}) : super();

  @override
  _KanjiBasicDetailScreenState createState() => _KanjiBasicDetailScreenState();
}

class _KanjiBasicDetailScreenState extends State<KanjiBasicDetailScreen> {
  List<Choice> choices = <Choice>[
    const Choice(title: 'Cách viết', icon: Icons.directions_car),
    const Choice(title: 'Ví dụ', icon: Icons.directions_boat),
  ];
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    choices.clear();

  }
  @override
  Widget build(BuildContext context) {
    print("tu " + widget.word);
    print("bai " + widget.lesson.toString());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Chi tiết",
          style: TextStyle(
              color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.white,
      ),
      body: DefaultTabController(
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
              body: Container(
                child: FutureBuilder<List<Ikanji>>(
                  future: DBProvider.db.getNoteById(widget.lesson),
                  // ignore: missing_return
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Ikanji>> snapshot) {
                    if (snapshot.hasData) {
                      Ikanji item = snapshot.data[0];

                      return TabBarView(children: <Widget>[
                        Playground(char: item.word),
                        _vidu(snapshot.data)
                      ]);
                    } else
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                  },
                ),
              ))),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

Widget _vidu(List<Ikanji> item) {
  String data =
      item[0].note.replaceAll("∴", "\t\t\t\t\t").replaceAll("※", "\n");
  return ListView(
    children: [
      Text(
        data,
      )
    ],
  );
}
