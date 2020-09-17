import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Hero(
      tag: "profile-image",
      child: Container(
        width: double.infinity,
        height: 200.0,
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                  "https://images.unsplash.com/flagged/photo-1566127992631-137a642a90f4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
                ),
                fit: BoxFit.cover)),
      ),
    ));
  }
}
