import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:minnav2/Database/databasev9.dart';
import 'package:minnav2/Model/MindaV9Db/Kana.dart';

class AlphabetScreen extends StatefulWidget {
  @override
  _AlphabetScreenState createState() => _AlphabetScreenState();
}

AudioCache audioCache;
AudioPlayer advancedPlayer;

class _AlphabetScreenState extends State<AlphabetScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioCache.disableLog();
    advancedPlayer.dispose();
    choices.clear();
  }
  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() {
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);

    advancedPlayer.durationHandler = (d) => setState(() {
        });

    advancedPlayer.positionHandler = (p) => setState(() {
        });
  }
  List<Choice> choices = <Choice>[
    const Choice(title: 'Hiragana', icon: Icons.directions_car),
    const Choice(title: "Katakana", icon: Icons.directions_bike),
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Bảng chữ cái",
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
              body: FutureBuilder<List<Kana>>(
                future: DBProvider.db.getGroupFromKana(0),
                // ignore: missing_return
                builder:
                    (BuildContext context, AsyncSnapshot<List<Kana>> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      padding: EdgeInsets.all(10.0),
                      child: TabBarView(children: <Widget>[
                        _hiragana(snapshot.data),
                        _katakana(snapshot.data),
                      ]),
                    );
                  } else
                    return Center(child: new CircularProgressIndicator());
                },
              ))),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

Widget _hiragana(List<Kana> item) {
  return GridView.builder(
      itemCount: item.length,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
      // ignore: missing_return
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            print(item[index].romaji);
            audioCache.play("db/alphabet/${item[index].romaji}.mp3");
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0),
                color: Colors.transparent),
            margin: EdgeInsets.only(bottom: 3.0, right: 3.0, left: 3.0),
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  item[index].hira,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
                ),
                Flexible(
                  child: Text(item[index].romaji),
                )
              ],
            ),
          ),
        );
      });
}

Widget _katakana(List<Kana> item) {
  return GridView.builder(
      itemCount: item.length,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
      // ignore: missing_return
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            print(item[index].romaji);
            audioCache.play("db/alphabet/${item[index].romaji}.mp3");
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0),
                color: Colors.transparent),
            margin: EdgeInsets.only(bottom: 3.0, right: 3.0, left: 3.0),
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  item[index].kata,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
                ),
                Flexible(
                  child: Text(item[index].romaji),
                )
              ],
            ),
          ),
        );
      });
}
