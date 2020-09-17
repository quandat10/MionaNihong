import 'package:flutter/material.dart';
import 'package:minnav2/Database/databasev9.dart';
import 'package:minnav2/Model/MindaV9Db/Kanji.dart';
import 'package:minnav2/Screen/Widget/PlayGround.dart';
import 'package:minnav2/misc/converter.dart';

class KanjiAdavanceDetailScreen extends StatefulWidget {
  final String nameChar;

  KanjiAdavanceDetailScreen({this.nameChar}) : super();

  @override
  _KanjiAdavanceDetailScreenState createState() =>
      _KanjiAdavanceDetailScreenState();
}

AnimationController _controller;

class _KanjiAdavanceDetailScreenState extends State<KanjiAdavanceDetailScreen>
    with SingleTickerProviderStateMixin {
  var run = true;

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    List<Choice> choices = <Choice>[
      const Choice(title: 'Cách viết', icon: Icons.directions_car),
      Choice(title: widget.nameChar, icon: Icons.directions_bike),
      const Choice(title: 'Ví dụ', icon: Icons.directions_boat),
    ];
    var char = getKanjiUnicode(widget.nameChar);
    print(char);
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "${widget.nameChar}",
          style: TextStyle(
              color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.w800),
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
                child: FutureBuilder<List<Kanji>>(
                  future: DBProvider.db.getCententWord(widget.nameChar),
                  // ignore: missing_return
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Kanji>> snapshot) {
                    if (snapshot.hasData) {
                      Kanji item = snapshot.data[0];

                      return TabBarView(children: <Widget>[
                        Playground(char: item.word),
                        Amhan(widget.nameChar, item.vi_mean, item.kunjomi,
                            item.onjomi),
                        Vidu(snapshot.data[0].note),
                      ]);
                    } else
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                  },
                ),
              ))),
    ));
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

Widget Amhan(String am, String nghia, String Kunyomi, String Onyomi) {
  return Container(
    child: ListView(
      children: [
        Container(
          padding: EdgeInsets.all(40.0),
          margin:
              EdgeInsets.only(top: 40.0, bottom: 10.0, right: 10.0, left: 10.0),
          decoration: BoxDecoration(
              color: Colors.green[300],
              borderRadius: BorderRadius.circular(10.0)),
          child: Text(
            "Nghĩa  : \t${nghia}",
            style: TextStyle(color: Colors.black, fontSize: 18.0),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          padding: EdgeInsets.all(40.0),
          margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          decoration: BoxDecoration(
              color: Colors.red[300],
              borderRadius: BorderRadius.circular(10.0)),
          child: Text(
            "Kunyomi \t  : \t${Kunyomi}",
            style: TextStyle(color: Colors.black, fontSize: 18.0),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          padding: EdgeInsets.all(40.0),
          margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          decoration: BoxDecoration(
              color: Colors.yellow[300],
              borderRadius: BorderRadius.circular(10.0)),
          child: Text(
            "Onyomi \t  : \t${Onyomi}",
            style: TextStyle(color: Colors.black, fontSize: 18.0),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          padding: EdgeInsets.all(40.0),
          margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          decoration: BoxDecoration(
              color: Colors.purple[300],
              borderRadius: BorderRadius.circular(10.0)),
          child: Text(
            "Âm hán \t  : \t${am}",
            style: TextStyle(color: Colors.black, fontSize: 18.0),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    ),
  );
}

Widget Vidu(String word) {
  var str1 = word.split("※");
  print(str1);

  String transferString = word.replaceAll("※", "\n");
  String transferString2 = transferString.replaceAll("∴", "\t\t\t\t");
  return Padding(
      padding: EdgeInsets.all(20.0),
      child: ListView.builder(
        itemCount: str1.length,
        itemBuilder: (BuildContext context, int idx) {
          var str2 = str1[idx].split("∴");

          return Container(
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.only(top: 10.0),
            decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(10.0)),
            child: Row(
              children: [
                Text(
                  str2[0],
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20.0,
                  ),
                  overflow: TextOverflow.clip,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  str2[1],
                  style: TextStyle(color: Colors.red, fontSize: 20.0),
                  overflow: TextOverflow.clip,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    str2[2],
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                    overflow: TextOverflow.clip,
                  ),
                )
              ],
            ),
          );
        },
      ));
}
