import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:minnav2/Database/databasev9.dart';
import 'package:minnav2/Model/MindaV9Db/Ikanji.dart';
import 'package:minnav2/Screen/MainScreen/KanjiScreen/KanjiBasicDetailScreen.dart';
import 'package:minnav2/Screen/MainScreen/MinnaScreen/MinnaLessonScreen.dart';

FlutterTts flutterTts;

class KanjiBasicBuilder extends StatefulWidget {
  int lesson;

  KanjiBasicBuilder({this.lesson}) : super();

  @override
  _KanjiBasicBuilderState createState() => _KanjiBasicBuilderState();
}

class _KanjiBasicBuilderState extends State<KanjiBasicBuilder> {
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
    return FutureBuilder<List<Ikanji>>(
      future: DBProvider.db.getAllContentByLesson(widget.lesson),
      // ignore: missing_return
      builder: (BuildContext context, AsyncSnapshot<List<Ikanji>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            // ignore: missing_return
            itemBuilder: (context, index) {
              Ikanji item = snapshot.data[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => KanjiBasicDetailScreen(
                            word: item.word,
                            lesson: item.id,
                          )));
                },
                child: Container(
                  padding: EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
                  margin: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Row(
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //id
                            Text(
                              item.id.toString(),
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.black),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),

                            Text(
                              item.word.toString(),
                              style:
                                  TextStyle(fontSize: 25.0, color: Colors.red),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),

                            Text(
                              item.cn_mean.toString(),
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            InkWell(
                              onTap: () async {
                                flutterTts.setLanguage("ja");
//                          String languages = await flutterTts.getLanguages;
//                          print(languages);
//                          flutterTts.setVoice("ja-jp-x-sfg#male_1-local");
                                var result = await flutterTts.speak(item.word);
                                print(result);
                                if (result == 1)
                                  setState(() {
                                    ttsState = TtsState.playing;
                                  });
                              },
                              child: Icon(
                                Icons.volume_up,
                                color: Colors.black54,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 50.0,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: 'On:',
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.black)),
                                TextSpan(
                                    text: ' ${item.onjomi}!',
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 18.0)),
                              ]),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            RichText(
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: 'Kun:',
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.black)),
                                TextSpan(
                                  text: ' ${item.kunjomi}!',
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ]),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Image.asset(
                                "assets/db/imgs/ikanji/${item.image}.jpg"),
                            SizedBox(
                              height: 10.0,
                            ),
                            Html(
                                data: item.remember,
                                defaultTextStyle: TextStyle(
                                    color: Colors.black, fontSize: 18.0)),
                            SizedBox(
                              height: 10.0,
                            ),
                            Html(
                                data: item.remember_jp,
                                defaultTextStyle: TextStyle(
                                    color: Colors.black, fontSize: 18.0))
                          ],
                        ),
                      )
                    ],
                  ),
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
}
