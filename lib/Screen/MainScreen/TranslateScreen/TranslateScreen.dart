import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:minnav2/Screen/Widget/Builder/TranslateBuilder.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

FlutterTts flutterTts;
enum TtsState { playing, stopped, paused, continued }

TtsState ttsState = TtsState.stopped;

class TranslateScreen extends StatefulWidget {
  final String word;

  TranslateScreen({this.word}) : super();

  @override
  _TranslateScreenState createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  //declare
  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = "";
  double _confidence = 1.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _speech = stt.SpeechToText();
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _speech.stop();
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/translation.svg",
              height: MediaQuery.of(context).size.width * 0.1,
              width: MediaQuery.of(context).size.width * 0.1,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              "Dịch văn bản ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
        backgroundColor: Colors.grey[200],
      ),
      backgroundColor: Colors.grey[200],
      body: TranslateBuilder(),
    );
  }
}
