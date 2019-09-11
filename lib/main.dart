import 'dart:async';

import 'package:flutter/material.dart';
import 'package:snappable/snappable.dart';

void main() => runApp(MyApp());

final swiftKey = GlobalKey<SnappableState>();
final androidKey = GlobalKey<SnappableState>();
final iosKey = GlobalKey<SnappableState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: AppBody(),
      ),
    );
  }
}

class FlutterBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 200,
          left: 30,
          child: Snappable(
            snapOnTap: true,
            child: FlutterLogo(
              size: 350,
            ),
          ),
        )
      ],
    );
  }
}

class AppBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Gauntlet(),
        OtherFrameworks(),
      ],
    );
  }
}

class OtherFrameworks extends StatefulWidget {
  @override
  _OtherFrameworksState createState() => _OtherFrameworksState();
}

class _OtherFrameworksState extends State<OtherFrameworks> {

  @override
  Widget build(BuildContext context) {
    var middle = MediaQuery.of(context).size.width / 2;

    return Positioned(
      top: 400,
      left: middle - 75,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Snappable(
            key: swiftKey,
            child: SizedBox(
              height: 100,
              width: 100,
              child: Image.asset(
                "swift.png",
              ),
            ),
          ),
          Snappable(
            key: androidKey,
            offset: Offset(-64, 32),
            child: SizedBox(
              height: 80,
              width: 150,
              child: Image.asset(
                "android.png",
              ),
            ),
          ),
          Snappable(
            key: iosKey,
            offset: Offset(-32, 64),
            child: SizedBox(
              height: 80,
              width: 150,
              child: Image.asset(
                "github.png",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Gauntlet extends StatefulWidget {
  @override
  GauntletState createState() => GauntletState();
}

class GauntletState extends State<Gauntlet> {
  String gauntletUrl = "gauntlet.png";
  final key = GlobalKey<SnappableState>();

  void snapGauntlet() {
    setState(() {
      gauntletUrl = "gauntlet_snapping.png";
    });

    iosKey.currentState.isGone
        ? iosKey.currentState.reset()
        : iosKey.currentState.snap();

    androidKey.currentState.isGone
        ? androidKey.currentState.reset()
        : androidKey.currentState.snap();

    swiftKey.currentState.isGone
        ? swiftKey.currentState.reset()
        : swiftKey.currentState.snap();

    Timer(Duration(milliseconds: 300), () {
      setState(() {
        gauntletUrl = "gauntlet.png";
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    var middle = MediaQuery.of(context).size.width / 2;
    double flutterLogoSize = 150;

    return Positioned(
      top: 100,
      left: middle - flutterLogoSize / 2,
      child: SizedBox(
        height: flutterLogoSize + 30,
        width: flutterLogoSize + 30,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              child: FlutterLogo(
                size: flutterLogoSize,
              ),
              onTap: () => snapGauntlet(),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: 100,
                width: 100,
                child: Image.asset(gauntletUrl),
              ),
            ),
          ],
        ),
      ),
    );
  }
}