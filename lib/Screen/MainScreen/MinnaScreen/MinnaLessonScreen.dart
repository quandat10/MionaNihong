//import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:minnav2/Database/databasev5.dart';
import 'package:minnav2/Database/databasev9.dart';
import 'package:minnav2/LocalAudio.dart';
import 'package:minnav2/Model/MindaV9Db/Bunkei.dart';
import 'package:minnav2/Model/MindaV9Db/Grammar.dart';
import 'package:minnav2/Model/MindaV9Db/Kaiwa.dart';
import 'package:minnav2/Model/MindaV9Db/Mondai.dart';
import 'package:minnav2/Model/MindaV9Db/Reference.dart';
import 'package:minnav2/Model/MindaV9Db/Reibun.dart';
import 'package:minnav2/Model/MindaV9Db/kotoba.dart';
import 'package:minnav2/Model/ReadV5Db/ReshuuB.dart';

FlutterTts flutterTts;
enum TtsState { playing, stopped, paused, continued }
//AudioPlayer advancedPlayer;
//AudioCache audioCache;

TtsState ttsState = TtsState.stopped;

class MinnaLessonScreen extends StatefulWidget {
  int lesson;

  MinnaLessonScreen({this.lesson}) : super();

  @override
  _MinnaLessonScreenState createState() => _MinnaLessonScreenState();
}

class _MinnaLessonScreenState extends State<MinnaLessonScreen>
    with SingleTickerProviderStateMixin {
  var run = true;
  AnimationController _controller;

  List<Choice> choices = <Choice>[
    const Choice(title: 'Từ vựng', icon: Icons.directions_car),
    const Choice(title: "Ngữ pháp", icon: Icons.directions_bike),
    const Choice(title: 'RenShuuB', icon: Icons.directions_boat),
    const Choice(title: 'Kaiwa', icon: Icons.directions_boat),
    const Choice(title: 'Mondai', icon: Icons.directions_boat),
    const Choice(title: 'Bunkei', icon: Icons.directions_boat),
    const Choice(title: 'Reibun', icon: Icons.directions_boat),
    const Choice(title: 'Renshuu C', icon: Icons.directions_boat),
    const Choice(title: 'Tham khảo', icon: Icons.directions_boat),
  ];

  List<String> spinnerItems = [];
  int i;
  String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = 'Bài ${widget.lesson}';
    for (i = 0; i < 50; i++) {
      spinnerItems.add("Bài ${i + 1}");
    }
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    spinnerItems.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          dropdownValue,
          style: TextStyle(
              color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.w800),
        ),
        actions: <Widget>[
          DropdownButton<String>(
            //                  value: dropdownValue,
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
                widget.lesson =
                    int.parse(dropdownValue.substring(4, dropdownValue.length));
                FutureBuilder<List<Grammar>>(
                  future: DBProvider.db.getLessonIdFromGrammar(widget.lesson),
                  // ignore: missing_return
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Grammar>> snapshot) {
                    if (snapshot.hasData) {
                      return TabBarView(children: <Widget>[
                        kotobaWidget(lesson: widget.lesson),
                        _nguphap(snapshot.data),
                        RenshuuB(
                          lesson: widget.lesson,
                        ),
                        _kaiwa(widget.lesson),
                        MondaiWidget(lesson: widget.lesson),
                        _bunkei(widget.lesson),
                        _reibun(widget.lesson),
                        _renshuuc(widget.lesson),
                        _reference(widget.lesson),
                      ]);
                    } else
                      return CircularProgressIndicator();
                  },
                );
              });
            },
            items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
                onTap: () {
                  setState(() {});
                },
              );
            }).toList(),
          ),
        ],
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
              body: FutureBuilder<List<Grammar>>(
                future: DBProvider.db.getLessonIdFromGrammar(widget.lesson),
                // ignore: missing_return
                builder: (BuildContext context,
                    AsyncSnapshot<List<Grammar>> snapshot) {
                  if (snapshot.hasData) {
                    return TabBarView(children: <Widget>[
                      kotobaWidget(lesson: widget.lesson),
                      _nguphap(snapshot.data),
                      RenshuuB(
                        lesson: widget.lesson,
                      ),
                      _kaiwa(widget.lesson),
                      MondaiWidget(lesson: widget.lesson),
                      _bunkei(widget.lesson),
                      _reibun(widget.lesson),
                      _renshuuc(widget.lesson),
                      _reference(widget.lesson),
                    ]);
                  } else
                    return CircularProgressIndicator();
                },
              ))),
    ));
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

//Ngu phap
Widget _nguphap(List<Grammar> item) {
  return Container(
    child: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: item.length,
        // ignore: missing_return
        itemBuilder: (context, index) {
          return Column(
            children: [
              Html(
                data: item[index].name,
                defaultTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800),
              ),
              Html(
                data: item[index]
                    .content
                    .replaceAll(r"$C$", "")
                    .replaceAll(r"$H$", "*")
                    .replaceAll(r"$E$ ", "-")
                    .replaceAll(r"$T$ ", "+")
                    .replaceAll(
                      r"$R$ ",
                      ".",
                    ),
                defaultTextStyle:
                    TextStyle(color: Colors.black, fontSize: 18.0),
              )
            ],
          );
        }),
  );
}

// Koboba
class kotobaWidget extends StatefulWidget {
  int lesson;

  kotobaWidget({this.lesson}) : super();

  @override
  _kotobaWidgetState createState() => _kotobaWidgetState();
}

class _kotobaWidgetState extends State<kotobaWidget> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flutterTts.stop();
  }
  @override
  Widget build(BuildContext context) {
    flutterTts = FlutterTts();
    flutterTts.setStartHandler(() {
      setState(() {
        print("playing");
        ttsState = TtsState.playing;
      });
    });
    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });
    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
    return FutureBuilder<List<Kotoba>>(
      future: DBProvider.db.getKotobaFromGrammar(widget.lesson),
      // ignore: missing_return
      builder: (BuildContext context, AsyncSnapshot<List<Kotoba>> snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data.length);
          return ListView.builder(
            padding: EdgeInsets.only(top: 20.0),
            itemCount: snapshot.data.length,
            // ignore: missing_return
            itemBuilder: (context, index) {
              Kotoba item = snapshot.data[index];
              return GestureDetector(
                onTap: () async {
                  flutterTts.setLanguage("ja");

                  flutterTts.setVolume(1000.0);

//                          String languages = await flutterTts.getLanguages;
//                          print(languages);
//                          flutterTts.setVoice("ja-jp-x-sfg#male_1-local");
                  var result = await flutterTts.speak(item.roumaji);
                  print(result);
                  if (result == 1) setState(() => ttsState = TtsState.playing);
                },
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.black12),
                        borderRadius: BorderRadius.circular(10.0)),
                    padding: EdgeInsets.all(10.0),
                    margin:
                        EdgeInsets.only(bottom: 10.0, right: 10.0, left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.hiragana,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20.0,
                                ),
                              ),
                              Text(
                                "${item.kanji} - ${item.cn_mean.toString()}",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 20.0),
                              ),
                              Text(
                                item.roumaji,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 18.0),
                              ),
                              Text(
                                item.mean,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            flutterTts.setLanguage("ja");
//                          String languages = await flutterTts.getLanguages;
//                          print(languages);
//                          flutterTts.setVoice("ja-jp-x-sfg#male_1-local");
                            flutterTts.setVolume(100);
                            var result = await flutterTts.speak(item.roumaji);
                            print(result);
                            if (result == 1)
                              setState(() => ttsState = TtsState.playing);
                          },
                          child: Icon(
                            Icons.volume_up,
                            color: Colors.black54,
                          ),
                        )
                      ],
                    )),
              );
            },
          );
        } else
          return Center(child: CircularProgressIndicator());
      },
    );
  }
}

//RenshuuB
class RenshuuB extends StatefulWidget {
  final int lesson;

  RenshuuB({this.lesson}) : super();

  @override
  _RenshuuBState createState() => _RenshuuBState();
}

class _RenshuuBState extends State<RenshuuB> {
  int check = 0;
  int check2 = 0;
  List<bool> flat = List.filled(20, false);
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flat.clear();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ReshuuB>>(
        future: DBProvider2.db.getImageByLessonIdFromRenshuuB(widget.lesson),
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot<List<ReshuuB>> snapshot) {
          if (snapshot.hasData) {
            List<bool> isVisible = List.filled(snapshot.data.length, false);
            List<bool> isVisible2 = List.filled(snapshot.data.length, false);
            isVisible[check] = true;
            flat[check2] == false
                ? isVisible2[check2] = isVisible2[check2]
                : isVisible2[check2] = !isVisible2[check2];

//            print(isVisible);
//            print(isVisible2);
            return ListView.builder(
                itemCount: snapshot.data.length,
                // ignore: missing_return
                itemBuilder: (context, index) {
                  var idx1 = snapshot.data[index].question
                      .indexOf("assets/images/renshuub/");
                  var idx2 = snapshot.data[index].question.indexOf(".jpg");
                  var str = (idx1 < 0 && idx2 < 0)
                      ? 0
                      : snapshot.data[index].question.substring(idx1, idx2);
                  print(str);
                  return Container(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: [
                        AnimatedSwitcher(
                          child: isVisible[index]
                              ? Container(
                                  margin: EdgeInsets.only(
                                      bottom: 10.0, left: 10.0, right: 10.0),
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Câu ${snapshot.data[index].id.toString()} : ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(height: 10.0),
                                      (str != 0)
                                          ? Image.asset("${str}.jpg")
                                          : Container(),
                                      Html(
                                        data: snapshot.data[index].question
                                            .trim(),
                                      ),
                                      AnimatedSwitcher(
                                        child: isVisible2[index]
                                            ? Container(
                                                child: Html(
                                                data: snapshot
                                                    .data[index].content
                                                    .trim(),
                                              ))
                                            : RaisedButton(
                                                shape:
                                                    new RoundedRectangleBorder(
                                                        side: BorderSide(
                                                            color: Colors.blue,
                                                            width: 1,
                                                            style: BorderStyle
                                                                .solid),
                                                        borderRadius:
                                                            new BorderRadius
                                                                    .circular(
                                                                30.0)),
                                                onPressed: () {
                                                  setState(() {
                                                    isVisible2[index] =
                                                        !isVisible2[index];
                                                    print(isVisible[index]
                                                        .toString());
                                                    check2 = index;
                                                    flat[index] = !flat[index];
                                                  });
                                                },
                                                child: Text(
                                                  "Kết quả",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                        duration: Duration(seconds: 0),
                                      )
                                    ],
                                  ))
                              : GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isVisible[index] = !isVisible[index];
                                      print(isVisible[index].toString());
                                      check = index;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top: 10.0,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        bottom: 10.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        color: Colors.black12),
                                    child: Text(
                                      "Câu ${snapshot.data[index].id.toString()}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )),
                          duration: Duration(seconds: 0),
                        ),
                      ],
                    ),
                  );
                });
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        });
  }
}

// Kaiwa
Widget _kaiwa(int lesson) {
  return FutureBuilder<List<Kaiwa>>(
    future: DBProvider.db.getLessonIdFromKaiwa(lesson),
    // ignore: missing_return
    builder: (BuildContext context, AsyncSnapshot<List<Kaiwa>> snapshot) {
      if (snapshot.hasData) {
        return ListView.builder(
            padding: EdgeInsets.only(top: 20.0),
            itemCount: snapshot.data.length,
            // ignore: missing_return
            itemBuilder: (context, index) {
              Kaiwa item = snapshot.data[index];

              return Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  children: [
                    Text(item.character),
                    SizedBox(
                      width: 15.0,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.kaiwa != null ? item.kaiwa : " ",
                            style:
                                TextStyle(color: Colors.blue, fontSize: 18.0),
                          ),
                          Text(
                            item.c_roumaji != null ? item.c_roumaji : " ",
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Text(
                            item.vi_mean != null ? item.vi_mean : " ",
                            overflow: TextOverflow.clip,
                            style:
                                TextStyle(color: Colors.green, fontSize: 18.0),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            });
        // ignore: unnecessary_statements
      } else
        return Center(
          child: CircularProgressIndicator(),
        );
    },
  );
}

//Mondai
class MondaiWidget extends StatefulWidget {
  int lesson;

  MondaiWidget({this.lesson}) : super();

  @override
  _MondaiWidgetState createState() => _MondaiWidgetState();
}

class _MondaiWidgetState extends State<MondaiWidget> {
  int check = 0;
  List<bool> flat = List.filled(10, false);
  List<bool> isVisible = List.filled(10, false);
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flat.clear();
    isVisible.clear();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Mondai>>(
      future: DBProvider.db.getLessonIdFromMondai(widget.lesson),
      // ignore: missing_return
      builder: (BuildContext context, AsyncSnapshot<List<Mondai>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              padding: EdgeInsets.only(top: 20.0),
              itemCount: snapshot.data.length,
              // ignore: missing_return
              itemBuilder: (context, index) {
                Mondai item = snapshot.data[index];
//                print(isVisible[index]);
//                print(item.audio);
                return Container(
                    margin:
                        EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: (item.audio != null)
                        ? Column(
                            children: [
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "Câu ${index + 1}",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w800),
                              ),
                              LocalAudio(
                                  url: "audio/${item.audio}", index: index),
                              Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: AnimatedSwitcher(
                                    child: isVisible[index]
                                        ? Container(
                                            child: Html(
                                            data: item.content,
                                          ))
                                        : RaisedButton(
                                            shape: new RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: Colors.blue,
                                                    width: 1,
                                                    style: BorderStyle.solid),
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        30.0)),
                                            onPressed: () {
                                              setState(() {
                                                isVisible[index] =
                                                    !isVisible[index];
                                              });
                                            },
                                            child: Text(
                                              "Kết quả",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                    duration: Duration(seconds: 0),
                                  ))
                            ],
                          )
                        : Container(
                            width: 0,
                            height: 0,
                          ));
              });
          // ignore: unnecessary_statements
        } else
          return Center(
            child: CircularProgressIndicator(),
          );
      },
    );
  }
}

//Bunkei
Widget _bunkei(int lesson) {
  return FutureBuilder<List<Bunkei>>(
      future: DBProvider.db.getLessonIdFromBunkei(lesson),
      // ignore: missing_return
      builder: (BuildContext context, AsyncSnapshot<List<Bunkei>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              // ignore: missing_return
              itemBuilder: (context, index) {
                Bunkei item = snapshot.data[index];
                return Container(
                  margin:
                      EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.black12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.bunkei,
                        style: TextStyle(color: Colors.blue, fontSize: 20.0),
                      ),
                      Text(
                        item.roumaji,
                        style: TextStyle(color: Colors.black87, fontSize: 20.0),
                      ),
                      Text(
                        item.vi_mean,
                        style: TextStyle(color: Colors.green, fontSize: 20.0),
                      ),
                    ],
                  ),
                );
              });
        } else
          return Center(
            child: CircularProgressIndicator(),
          );
      });
}

//Reibun
Widget _reibun(int lesson) {
  return FutureBuilder<List<Reibun>>(
      future: DBProvider.db.getLessonIdFromReibun(lesson),
      // ignore: missing_return
      builder: (BuildContext context, AsyncSnapshot<List<Reibun>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              // ignore: missing_return
              itemBuilder: (context, index) {
                Reibun item = snapshot.data[index];
                return Container(
                  margin:
                      EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.black12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.reibun,
                        style: TextStyle(color: Colors.blue, fontSize: 20.0),
                      ),
                      Text(
                        item.roumaji,
                        style: TextStyle(color: Colors.black87, fontSize: 20.0),
                      ),
                      Text(
                        item.vi_mean,
                        style: TextStyle(color: Colors.green, fontSize: 20.0),
                      ),
                    ],
                  ),
                );
              });
        } else
          return Center(
            child: CircularProgressIndicator(),
          );
      });
}

//RenshuuC
Widget _renshuuc(int lesson) {
  return FutureBuilder<List<ReshuuB>>(
      future: DBProvider.db.getLessonIdFromRenshuuC(lesson),
      // ignore: missing_return
      builder: (BuildContext context, AsyncSnapshot<List<ReshuuB>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              // ignore: missing_return
              itemBuilder: (context, index) {
                ReshuuB item = snapshot.data[index];
                return Container(
                  margin:
                      EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.black12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bài thực hành ${index + 1}",
                        style: TextStyle(color: Colors.black87, fontSize: 20.0),
                      ),
                      Html(
                        data: item.content,
                        defaultTextStyle:
                            TextStyle(color: Colors.blue, fontSize: 18.0),
                      ),
                      Html(
                        data: item.question,
                        defaultTextStyle:
                            TextStyle(color: Colors.green, fontSize: 18.0),
                      )
                    ],
                  ),
                );
              });
        } else
          return Center(
            child: CircularProgressIndicator(),
          );
      });
}

//Reference
Widget _reference(int lesson) {
  return FutureBuilder<List<Reference>>(
      future: DBProvider.db.getLessonIdFromRReference(lesson),
      // ignore: missing_return
      builder: (BuildContext context, AsyncSnapshot<List<Reference>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              // ignore: missing_return
              itemBuilder: (context, index) {
                Reference item = snapshot.data[index];
                return Container(
                  margin:
                      EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.black12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.japanese != null ? item.japanese : " ",
                        style: TextStyle(color: Colors.blue, fontSize: 20.0),
                      ),
                      Text(
                        item.roumaji != null ? item.roumaji : " ",
                        style: TextStyle(color: Colors.black87, fontSize: 20.0),
                      ),
                      Text(
                        item.vietnamese != null ? item.vietnamese : " ",
                        style: TextStyle(color: Colors.green, fontSize: 20.0),
                      ),
                    ],
                  ),
                );
              });
        } else
          return Center(
            child: CircularProgressIndicator(),
          );
      });
}
