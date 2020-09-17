import 'package:flutter/material.dart';
import 'package:minnav2/Database/databasev9.dart';
import 'package:minnav2/Model/MindaV9Db/Kanji.dart';
import 'package:minnav2/Screen/MainScreen/KanjiScreen/KanjiAdavanceDetailScreen.dart';

class KanjiAdvanceBuilder extends StatefulWidget {
  int lesson;

  KanjiAdvanceBuilder({this.lesson}) : super();

  @override
  _KanjiAdvanceBuilderState createState() => _KanjiAdvanceBuilderState();
}

class _KanjiAdvanceBuilderState extends State<KanjiAdvanceBuilder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Kanji>>(
      future: DBProvider.db.getAllKanjiAdvance((widget.lesson - 1) * 100),
      // ignore: missing_return
      builder: (BuildContext context, AsyncSnapshot<List<Kanji>> snapshot) {
        print(snapshot.data);
        if (snapshot.hasData) {
          return GridView.builder(
              itemCount: snapshot.data.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              // ignore: missing_return
              itemBuilder: (BuildContext context, int index) {
                Kanji item = snapshot.data[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => KanjiAdavanceDetailScreen(
                              nameChar: item.word,
                            )));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.black12),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item.word,
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 24.0,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            item.cn_mean,
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),
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
