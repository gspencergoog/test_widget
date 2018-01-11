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

class _MyHomePageState extends State<MyHomePage> {
  double _textScale = 1.0;
  bool _isDense = false;
  bool _hideDivider = false;
  bool _isCollapsed = false;
  bool _isSlow = false;

  @override
  Widget build(BuildContext context) {
    return new DefaultTextStyle(
      style: new TextStyle(
          color: Colors.white, fontSize: 14.0, fontFamily: 'Roboto', fontStyle: FontStyle.normal),
      child: new Material(
        child: new Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          new Padding(padding: const EdgeInsets.only(top: 30.0)),
          new MediaQuery(
            data: new MediaQueryData(textScaleFactor: _textScale),
            child: new Column(
              children: <Widget>[
                new TextField(
                  maxLines: 1,
                  maxLength: 10,
                  maxLengthEnforced: false,
                  decoration: _isCollapsed
                      ? new InputDecoration.collapsed(
                          hintText: "Hintp",
                        )
                      : new InputDecoration(
                          isDense: _isDense,
                          icon: new Icon(Icons.android),
                          labelText: "Labelp",
                          hintText: "Hintp",
                          helperText: "Helper",
                          //counterText: "HELP",
                        ),
                ),
                new Container(
                    decoration: new BoxDecoration(
                      border: new Border(
                        bottom: new BorderSide(width: 2.0),
                      ),
                    ),
                    child: new Text(_isDense ? "Dense" : "Normal")),
              ],
            ),
          ),
          new Flexible(child: new Container()),
          new TextField(),
          new Column(
            children: <Widget>[
              new Row(children: <Widget>[
                new Checkbox(
                    value: _isDense,
                    onChanged: (bool value) {
                      setState(() {
                        _isDense = value;
                      });
                    }),
                new Checkbox(
                    value: _hideDivider,
                    onChanged: (bool value) {
                      setState(() {
                        _hideDivider = value;
                      });
                    }),
                new Checkbox(
                    value: _isCollapsed,
                    onChanged: (bool value) {
                      setState(() {
                        _isCollapsed = value;
                      });
                    }),
                new Checkbox(
                    value: _isSlow,
                    onChanged: (bool value) {
                      setState(() {
                        _isSlow = value;
                        if (_isSlow) {
                          timeDilation = 20.0;
                        } else {
                          timeDilation = 1.0;
                        }
                      });
                    }),
              ]),
              new Slider(
                  min: 1.0,
                  max: 10.0,
                  onChanged: (double value) {
                    setState(() {
                      _textScale = value;
                    });
                  },
                  value: _textScale),
            ],
          ),
          new Text("Size: $_textScale"),
        ]),
      ),
    );
  }
}
