import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'UnconstrainedBox Test Code',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'UnconstrainedBox Test'),
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
  double _size = 10.0;
  @override
  Widget build(BuildContext context) {
    return new DefaultTextStyle(
      style: new TextStyle(
          color: Colors.white, fontSize: 14.0, fontFamily: 'Roboto', fontStyle: FontStyle.normal),
      child: new Material(
        child: new Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          new Padding(padding: const EdgeInsets.only(top: 30.0)),
          new Container(
            decoration: new BoxDecoration(border: new Border.all(color: Colors.blue, width: 4.0)),
            constraints: new BoxConstraints.tight(const Size.fromRadius(100.0)),
            child: new ConstrainedBox(
              constraints: new BoxConstraints(maxWidth: 200.0, maxHeight: 200.0),
              child: new UnconstrainedBox(
                child: new Container(
                  decoration: new BoxDecoration(color: Colors.deepOrange),
                  width: _size,
                  height: _size,
                ),
              ),
            ),
          ),
          new Divider(),
          new Container(
            decoration: new BoxDecoration(border: new Border.all(color: Colors.blue, width: 4.0)),
            constraints: new BoxConstraints.tight(const Size.fromRadius(100.0)),
            child: new Column(
              children: <Widget>[
                new UnconstrainedBox(
                  child: new Text("Testing", textScaleFactor: _size/10.0),
                ),
              ],
            ),
          ),
          new Divider(),
          new Flexible(child: new Container()),
          new Column(
            children: <Widget>[
              new Slider(
                  min: 1.0,
                  max: 500.0,
                  onChanged: (double value) {
                    setState(() {
                      _size = value;
                    });
                  },
                  value: _size),
            ],
          ),
          new Text("Size: $_size"),
        ]),
      ),
    );
  }
}
