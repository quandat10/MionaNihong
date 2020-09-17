

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';


//bool check = true;
//int state = 0;
class LocalAudio extends StatefulWidget {
  int index ;
  String url;
  int lesson;
  LocalAudio({this.url,this.index}):super();
  @override
  _LocalAudio createState() =>  _LocalAudio();
}
class _LocalAudio extends State<LocalAudio> with WidgetsBindingObserver {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  AudioPlayer advancedPlayer;
  AudioCache audioCache;

  @override
  void initState() {
    super.initState();
    initPlayer();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioCache.disableLog();
    advancedPlayer.stop();
    advancedPlayer.dispose();

  }
  void initPlayer() {
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);

    advancedPlayer.durationHandler = (d) => setState(() {
      _duration = d;
    });

    advancedPlayer.positionHandler = (p) => setState(() {
      _position = p;
    });
  }

  String localFilePath;


  Widget _btn(IconData iconData, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Icon(iconData),
    );
  }

  Widget slider() {
    return Slider(
        activeColor: Colors.black,
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            seekToSecond(value.toInt());
            value = value;
          });
        });
  }


  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);

    advancedPlayer.seek(newDuration);
  }

  List<bool> check = List.filled(10, true);
  List<int> state =  List.filled(10, 0);
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        slider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _btn(check[widget.index] == true ? Icons.play_arrow : Icons.pause, () async {
              setState(() {
                check[widget.index] = !check[widget.index];
                print("check : ${check}");
                print("state : ${state}");
              });
              if (state[widget.index] == 0){
                print("start");
                audioCache.play(widget.url);
              }else{
                print("resume");
                if(check[widget.index] == true) advancedPlayer.pause();
                else advancedPlayer.resume();
              }
              state[widget.index] = 1;

            }),

            _btn(Icons.stop, () {
              check[widget.index] = !check[widget.index];
              advancedPlayer.stop();
            }),

          ],
        ),

      ],
    );
  }
}