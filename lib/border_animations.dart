import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Test Code',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Widget Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  _MyHomePageState() {
    Decoration endDecoration = new ShapeDecoration(
      color: Colors.grey,
      shape: new RoundedRectangleBorder(side: purpleSide),
    );
    Decoration startDecoration = new ShapeDecoration(
      color: Colors.grey,
      shape: new StadiumBorder(side: redSide),
    );
    DecorationTween tween = new DecorationTween(begin: startDecoration, end: endDecoration);

    _controller = new AnimationController(
        vsync: this,
        debugLabel: "BorderAnimator",
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: new Duration(milliseconds: 1000),
        value: 0.0);
    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
      if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
//    _controller.addListener(() {
//      print ("Animation: ${_controller.value}");
//    });
    _animation = tween.animate(new CurveTween(curve: Curves.easeInOut).animate(_controller));
//    _animation = tween.animate(_controller);
    _animation.addListener(() {
      setState((){
        _value = _animation.value;
      });
    });
    timeDilation = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  static const purpleSide = const BorderSide(
    color: Colors.deepPurpleAccent,
    width: 2.0,
  );
  static const redSide = const BorderSide(
    color: Colors.redAccent,
    width: 20.0,
  );

  Decoration _value;
  AnimationController _controller;
  Animation _animation;

  @override
  Widget build(BuildContext context) {
    return new DefaultTextStyle(
      style: new TextStyle(
          color: Colors.white,
          fontSize: 14.0,
          fontFamily: 'Roboto',
          fontStyle: FontStyle.normal),
      child: new Material(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Container(
              width: 150.0,
              height: 100.0,
              decoration: _value,
            ),
            new Padding(padding: const EdgeInsets.all(30.0)),
            new Container(
              width: 150.0,
              height: 100.0,
              decoration: new ShapeDecoration(
                color: Colors.grey,
                shape: new RoundedRectangleBorder(side: redSide),
              ),
            ),
            new Padding(padding: const EdgeInsets.all(30.0)),
            new Container(
              width: 150.0,
              height: 100.0,
              decoration: new ShapeDecoration(
                color: Colors.grey,
                shape: new StadiumBorder(side: redSide),//.lerpTo(new RoundedRectangleBorder(side: redSide), 0.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
