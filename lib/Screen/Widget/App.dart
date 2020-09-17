import 'package:flutter/material.dart';
import 'package:minnav2/Screen/MainScreen/HomeScreen.dart';

import 'TabItem.dart';
import 'bottomNavigation.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  // this is static property so other widget throughout the app
  // can access it simply by AppState.currentTab
  static int currentTab = 0;

  // list tabs here
  final List<TabItem> tabs = [
    TabItem(
      tabName: "Trang chủ",
      icon: Icons.home,
      page: HomeScreen(),
    ),
    TabItem(
      tabName: "Cài đặt",
      icon: Icons.settings,
      page: SettingsScreen(),
    ),
  ];

  AppState() {
    // indexing is necessary for proper funcationality
    // of determining which tab is active
    tabs.asMap().forEach((index, details) {
      details.setIndex(index);
    });
  }

  // sets current tab index
  // and update state
  void _selectTab(int index) {
    if (index == currentTab) {
      // pop to first route
      // if the user taps on the active tab
      tabs[index].key.currentState.popUntil((route) => route.isFirst);
    } else {
      // update the state
      // in order to repaint
      setState(() => currentTab = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    // WillPopScope handle android back btn
    return WillPopScope(
        onWillPop: () async {
          final isFirstRouteInCurrentTab =
              !await tabs[currentTab].key.currentState.maybePop();
          if (isFirstRouteInCurrentTab) {
            // if not on the 'main' tab
            if (currentTab != 0) {
              // select 'main' tab
              _selectTab(0);
              // back button handled by app
              return false;
            }
          }
          // let system handle back button if we're on the first route
          return isFirstRouteInCurrentTab;
        },
        // this is the base scaffold
        // don't put appbar in here otherwise you might end up
        // with multiple appbars on one screen
        // eventually breaking the app
        child: Scaffold(
//        backgroundColor: Colors.black54,
            // indexed stack shows only one child
            body: IndexedStack(
              index: currentTab,
              children: tabs.map((e) => e.page).toList(),
            ),
            // Bottom navigation
            bottomNavigationBar: new Container(
                child: new Theme(
              data: Theme.of(context).copyWith(
                  // sets the background color of the `BottomNavigationBar`
                  canvasColor: Colors.white70,
                  // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                  primaryColor: Colors.green,
                  bottomAppBarColor: Colors.red,
                  textTheme: Theme.of(context)
                      .textTheme
                      .copyWith(caption: new TextStyle(color: Colors.orange))),
              // sets the inactive color of the `BottomNavigationBar`
              child: BottomNavigation(
                onSelectTab: _selectTab,
                tabs: tabs,
              ),
            ))));
  }
}

class SettingsScreen extends StatelessWidget {
  final Function openSettings;

  const SettingsScreen({Key key, this.openSettings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: FlatButton(
        child: Text("Push other Settings"),
        onPressed: () {
//          Navigator.of(context).push(
//            MaterialPageRoute(
//              builder: (context) => NewPage(),
//            ),
//          );
        },
      ),
    );
  }
}
