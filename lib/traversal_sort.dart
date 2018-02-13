import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Accessibility Traversal Test Code',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Accessibility Traversal Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static bool multiLayer = false;
  double tiltAngle = 0.0;

  Widget _makeMultilayerCell(BuildContext context, int row, int col) {
    return new ConstrainedBox(
      constraints: new BoxConstraints.tight(const Size.fromRadius(50.0)),
      child: new Center(
        child: new Text('$row, $col', style: Theme.of(context).textTheme.display1),
      ),
    );
  }

  Widget _makeFlatCell(BuildContext context, int row, int col) {
    return new ConstrainedBox(
      constraints: new BoxConstraints.tight(const Size.fromRadius(50.0)),
      child: new Center(
        child: new Text('$row, $col', style: Theme.of(context).textTheme.display1),
      ),
    );
  }

  Widget _makeCell(BuildContext context, int row, int col) {
    return multiLayer ? _makeMultilayerCell(context, row, col) : _makeFlatCell(context, row, col);
  }

  Widget _makeCenterCell(BuildContext context) {
    if (multiLayer) {
      return new Semantics(
        label: 'Center',
        child: new ExcludeSemantics(
          child: _makeMultilayerCell(context, 1, 1),
        ),
      );
    } else {
      return new Semantics(
        label: "Center",
        child: new ExcludeSemantics(
          child: _makeCell(context, 1, 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData.light(),
      home: new Scaffold(
        body: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Directionality(
              textDirection: TextDirection.rtl,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(' Col A ', textScaleFactor: 2.0),
                  const Text(' Col B ', textScaleFactor: 2.0),
                  const Text(' Col C ', textScaleFactor: 2.0),
                ],
              ),
            ),
            new Transform.rotate(
              angle: tiltAngle,
              child: new Directionality(
                textDirection: TextDirection.ltr,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _makeCell(context, 0, 0),
                    _makeCell(context, 0, 1),
                    _makeCell(context, 0, 2),
                    const Text(' Row A ', textScaleFactor: 2.0),
                  ],
                ),
              ),
            ),
            new Directionality(
              textDirection: TextDirection.rtl,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _makeCell(context, 1, 0),
                  _makeCenterCell(context),
                  _makeCell(context, 1, 2),
                  const Text(' Row B ', textScaleFactor: 2.0),
                ],
              ),
            ),
            new Directionality(
              textDirection: TextDirection.ltr,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _makeCell(context, 2, 0),
                  _makeCell(context, 2, 1),
                  _makeCell(context, 2, 2),
                  const Text(' Row C ', textScaleFactor: 2.0),
                ],
              ),
            ),
            new Center(
              child: new MaterialButton(
                child: const Text("Tilt!"),
                onPressed: () {
                  setState(() => tiltAngle += pi / 8.0);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
