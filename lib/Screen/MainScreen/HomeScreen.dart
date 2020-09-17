import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minnav2/Screen/MainScreen/AlphabetScreen/AlphabetScreen.dart';
import 'package:minnav2/Screen/MainScreen/ConversationScreen/ConversationSreen.dart';
import 'package:minnav2/Screen/MainScreen/KanjiScreen/KanjiBasicScreen.dart';
import 'package:minnav2/Screen/MainScreen/MinnaScreen/MinnaScreen.dart';
import 'package:minnav2/Screen/MainScreen/ReadingScreen/ReadingLessonScreen.dart';
import 'package:minnav2/Screen/MainScreen/TranslateScreen/TranslateScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String SEARCH = "Aa...";
  List<String> urlImage = [
    "assets/images/minna.jpg",
    "assets/images/kanji.gif",
    "assets/images/reading2.jpg",
    "assets/images/converse2.gif",
    "assets/images/alphabet.jpg"
  ];
  List<String> name = [
    "50 bài tập minna",
    "Kanji",
    "Hơn 50 bài đọc",
    "20 bài hội thoại",
    "Alphabet"
  ];
  List<Object> pageRoute = [
    MinnaScreen(),
    KanjiBasicScreen(),
    ReadingLessonScreen(),
    ConversationScreen(),
    AlphabetScreen()
  ];
  var rating = 0.0;

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutterio', 'beautiful apps'],
    contentUrl: 'https://flutter.io',
    childDirected: false,
    testDevices: <String>["92398b51202aac86fab4c5c1470163b37cd65f73","169bdcbd"], // Android emulators are considered test devices
  );

  BannerAd myBanner = BannerAd(
    adUnitId: "ca-app-pub-1142961620231228/4587346267",
    size: AdSize.smartBanner,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("BannerAd event is $event");
    },
  );

  InterstitialAd myInterstitialAd = InterstitialAd(
    adUnitId: InterstitialAd.testAdUnitId,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("InterstitialAd event is $event");
    },
  );

  BannerAd _bannerAd;

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(
        appId: "ca-app-pub-1142961620231228~1043671169"
    );
    _bannerAd = myBanner..load()..show(anchorType: AnchorType.bottom);
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    myInterstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/cover1.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.grey, BlendMode.darken),
                )),
          ),
          //            CharacterWidget(),
          ListView(
            children: [
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  myInterstitialAd
                    ..load()
                    ..show(
                      anchorType: AnchorType.bottom,
                      anchorOffset: 0.0,
                    );
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TranslateScreen()));
                },
                child: Container(
                    height: 50.0,
                    margin:
                    EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                    padding:
                    EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        border: Border.all(color: Colors.white70)),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/search.svg",
                          color: Colors.white70,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          SEARCH,
                          style: TextStyle(color: Colors.white70, fontSize: 18.0),
                        )
                      ],
                    )),
              ),
              Container(
                child: StaggeredGridView.countBuilder(
                  physics: new NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  itemCount: 4,
                  // ignore: missing_return
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => pageRoute[index]));
                      },
                      child: Container(
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              image: DecorationImage(
                                  image: AssetImage(urlImage[index]),
                                  colorFilter: ColorFilter.mode(
                                      Colors.grey, BlendMode.darken),
                                  fit: BoxFit.cover)),
                          child: Padding(
                            padding: EdgeInsets.only(right: 20.0, left: 20.0),
                            child: Center(
                              child: Text(
                                name[index],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          )),
                    );
                  },
                  staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(2, index.isEven ? 4 : 2),
                  mainAxisSpacing: 2.0,
                  crossAxisSpacing: 2.0,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AlphabetScreen()));
                  },
                  child: Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          image: DecorationImage(
                              image: AssetImage(urlImage[4]),
                              colorFilter:
                              ColorFilter.mode(Colors.grey, BlendMode.darken),
                              fit: BoxFit.cover)),
                      child: Padding(
                        padding: EdgeInsets.only(right: 20.0, left: 20.0),
                        child: Center(
                          child: Text(
                            name[4],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                 Text("Đánh giá : 5.0",
                   style: TextStyle(
                       color: Colors.white,
                       fontSize: 18.0
                   ),),
                  Text(
                    "version : 0.0.1",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,)
            ],
          ),
        ],
      ),
    );
  }
}



