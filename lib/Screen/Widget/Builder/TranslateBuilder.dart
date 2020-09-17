import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:minnav2/Model/CallApi/SentencesModel.dart';
import 'package:minnav2/Model/CallApi/TranslateResponse.dart';
import 'package:minnav2/Screen/MainScreen/TranslateScreen/TranslateScreen.dart';

String word = " ";
String word2 = " ";

class TranslateBuilder extends StatefulWidget {
  @override
  _TranslateBuilderState createState() => _TranslateBuilderState();
}

class _TranslateBuilderState extends State<TranslateBuilder> {
  FocusNode _focusNode;
  String INPUTCONTENT = "Nhập đoạn văn ... ";
  List<String> translate = ["vi-ja", "ja-vi"];
  bool check = true;

  bool check2 = false;

  TextEditingController _inputcontroller;
  String dropdownValue = "vi-ja";
  String vi = "", ja = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _inputcontroller = TextEditingController();
  }

  void dispose() {
    super.dispose();
    _inputcontroller.dispose();
    _focusNode = FocusNode();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String SERVER_TRANSLATE =
        "http://bkitsoftware.com/a.php?sl=vi&tl=ja&text=${_inputcontroller.text}";
    String SERVER_JA_VI =
        "http://bkitsoftware.com/a.php?sl=ja&tl=vi&text=${_inputcontroller.text}";
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          margin:
              EdgeInsets.only(right: 15.0, left: 15.0, top: 15.0, bottom: 15.0),
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          RaisedButton(
                            color: check == false ? Colors.white : Colors.blue,
                            shape: new RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.blue,
                                    width: 1,
                                    style: BorderStyle.solid),
                                borderRadius: new BorderRadius.circular(30.0)),
                            onPressed: () {
                              setState(() {
                                check = !check;
                                dropdownValue = translate[0];
                              });
                            },
                            child: Text(
                              translate[0],
                              style: TextStyle(
                                  color: check == false
                                      ? Colors.black87
                                      : Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          RaisedButton(
                            color: check == false ? Colors.blue : Colors.white,
                            shape: new RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.blue,
                                    width: 1,
                                    style: BorderStyle.solid),
                                borderRadius: new BorderRadius.circular(30.0)),
                            onPressed: () {
                              setState(() {
                                check = !check;
                                dropdownValue = translate[1];
                              });
                            },
                            child: Text(
                              translate[1],
                              style: TextStyle(
                                  color: check == false
                                      ? Colors.white
                                      : Colors.black87,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                          });
                        },
                        child: Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(200),
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [Colors.blue, Colors.red]),
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/language.svg",
                              height: MediaQuery.of(context).size.width * 0.06,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    check == true ? "Tiếng Việt" : "Tiếng Nhật",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    child: TextField(
                      focusNode: _focusNode,
                      textInputAction: TextInputAction.done,
                      controller: _inputcontroller,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: INPUTCONTENT,
                      ),
                      onSubmitted: (value) {
                        if (value == '') {
                          _focusNode.requestFocus();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    check == false ? "Tiếng Việt" : "Tiếng Nhật",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
//                          border: Border.all(color: Colors.black12)
                      ),
                      child: _inputcontroller.text.isNotEmpty
                          ? (dropdownValue == "vi-ja"
                              ? FutureBuilder<List<Sentences>>(
                                  future: fetchTranslateResponse(
                                      http.Client(), SERVER_TRANSLATE),
                                  // ignore: missing_return
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<Sentences>> snapshot) {
                                    if (snapshot.hasData) {
                                      ja = snapshot.data[0].trans;
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data[0].trans,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 18.0),
                                          ),
                                          Text(
                                            snapshot.data[1].translit,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 18.0),
                                          ),
                                        ],
                                      );
                                    } else
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                  },
                                )
                              : FutureBuilder<List<JatoVi>>(
                                  future: fetchTransJatoVi(
                                      http.Client(), SERVER_JA_VI),
                                  // ignore: missing_return
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<JatoVi>> snapshot) {
                                    if (snapshot.hasData) {
                                      vi = snapshot.data[0].trans;

                                      return Text(
                                        snapshot.data[0].trans,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18.0),
                                      );
                                    } else
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                  },
                                ))
                          : Container())
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: false,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: _listen,
          child: Icon(Icons.volume_up),
        ),
      ),
    );
  }

  void _listen() async {
    if (dropdownValue == "vi-ja") {
      flutterTts.setLanguage("ja");

      flutterTts.setVoice("ja-jp-x-sfg#male_1-local");
//    flutterTts.setVolume(1.0);
      var result = await flutterTts.speak(ja);
      print(result);
      if (result == 1) setState(() => ttsState = TtsState.playing);
    } else {
      print(vi);
      flutterTts.setLanguage("en");

//      flutterTts.setVoice("ja-jp-x-sfg#male_1-local");
//    flutterTts.setVolume(1.0);
      var result = await flutterTts.speak(vi);
      print(result);
      if (result == 1) setState(() => ttsState = TtsState.playing);
    }
  }
}
