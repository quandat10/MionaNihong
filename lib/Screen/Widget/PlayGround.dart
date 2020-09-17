import 'package:flutter/material.dart';
import 'package:minnav2/fklib/drawing_widget.dart';
import 'package:minnav2/misc/converter.dart';

class Playground extends StatefulWidget {
  String char;

  Playground({this.char}) : super();

  @override
  _PlaygroundState createState() {
    return _PlaygroundState();
  }
}

class _PlaygroundState extends State<Playground>
    with SingleTickerProviderStateMixin {
  var run = true;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.stop();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var char = getKanjiUnicode(widget.char);
    print(char);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 400,
            height: 400,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(6),
            color: Colors.black12,
            child: KanjiViewer.svg("assets/db/kanji/${char}.svg",
                controller: _controller,
                scaleToViewport: true,
                duration: new Duration(seconds: 10)),
          ),
          RaisedButton(
              child: Text('Vẽ'),
              onPressed: () {
                _controller.reset();
                _controller.forward();
              })
        ],
      ),
    );
  }
}
