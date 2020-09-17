import 'package:flutter/material.dart';
import 'package:minnav2/Screen/MainScreen/KanjiScreen/KanjiAdavanceDetailScreen.dart';
import 'package:minnav2/Screen/MainScreen/SplashScreen.dart';
import 'package:minnav2/LocalAudio.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );}
}
