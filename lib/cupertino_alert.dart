import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Cupertino Alert Test Code',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Cupertino Alert  Test'),
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
  double _size = 1.0;
  @override
  Widget build(BuildContext context) {
    return new DefaultTextStyle(
      style: new TextStyle(
          color: Colors.white, fontSize: 14.0, fontFamily: 'Roboto', fontStyle: FontStyle.normal),
      child: new Material(
        child: new MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: _size),
          child: new Builder(builder: (BuildContext context) {
            return new Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Padding(padding: const EdgeInsets.only(top: 30.0)),
                new RaisedButton(
                  onPressed: () {
                    showDialog<Null>(
                      context: context,
                      builder: (BuildContext context) => new MediaQuery(
                          data: MediaQuery.of(context).copyWith(textScaleFactor: _size),
                          child: new CupertinoAlertDialog(
                            title: const Text('The Title'),
                            content: new Text('Very long content ' * 20),
                            actions: <Widget>[
                              const CupertinoDialogAction(
                                child: const Text('Cancel'),
                              ),
                              new CupertinoDialogAction(
                                isDestructiveAction: true,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        ),
                    );
                  },
                  child: const Text('Go'),
                ),
                new Divider(),
                new Flexible(child: new Container()),
                new Column(
                  children: <Widget>[
                    new Slider(
                        min: 0.5,
                        max: 10.0,
                        onChanged: (double value) {
                          setState(() {
                            _size = value;
                          });
                        },
                        value: _size),
                  ],
                ),
                new Text("Size: $_size", textScaleFactor: 1.0),
              ],
            );
          }),
        ),
      ),
    );
  }
}
