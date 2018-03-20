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
  @override
  Widget build(BuildContext context) {
    const double labelWidth = 50.0;
    const double labelHeight = 30.0;
    final Key labelKey = new UniqueKey();

    debugPaintSizeEnabled = true;
    return new Directionality(
      textDirection: TextDirection.ltr,
      child: new Material(
        child: new Center(
          child: new Container(
            width: 500.0,
            height: 500.0,
            child: new Column(
              children: <Widget>[
                new Chip(
                  label: new Container(
                    key: labelKey,
                    width: labelWidth,
                    height: labelHeight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
//    return new DefaultTextStyle(
//      style: new TextStyle(
//          color: Colors.white,
//          fontSize: 14.0,
//          fontFamily: 'Roboto',
//          fontStyle: FontStyle.normal),
//      child: new Material(
//        child: new Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
//          new Padding(padding: const EdgeInsets.only(top: 30.0)),
//          new Container(
//            decoration:
//                new BoxDecoration(border: new Border.all(color: Colors.blue, width: 4.0)),
//            constraints: new BoxConstraints.tight(const Size(200.0, 100.0)),
//            child: new ConstrainedBox(
//              constraints: new BoxConstraints(maxWidth: 200.0, maxHeight: 100.0),
//              child: new UnconstrainedBox(
//                alignment: AlignmentDirectional.center,
//                child: new Container(
//                  decoration: new BoxDecoration(color: Colors.deepOrange),
//                  width: _size,
//                  height: _size,
//                ),
//              ),
//            ),
//          ),
//          new Divider(),
//          new Container(
//            decoration:
//                new BoxDecoration(border: new Border.all(color: Colors.blue, width: 4.0)),
//            constraints: new BoxConstraints.tight(const Size(200.0, 100.0)),
//            child: new UnconstrainedBox(
//              alignment: AlignmentDirectional.centerStart,
//              child: new Text("Testing", textScaleFactor: _size / 10.0),
//            ),
//          ),
//          new Divider(),
//          new Column(
//            children: <Widget>[
//              new Directionality(
//                textDirection: TextDirection.rtl,
//                child: new UnconstrainedBox(
//                  alignment: AlignmentDirectional.centerStart,
//                  child: new Text("Testing", textScaleFactor: _size / 10.0),
//                ),
//              ),
//            ],
//          ),
//          new Divider(),
//          new Flexible(child: new Container()),
//          new Column(
//            children: <Widget>[
//              new Slider(
//                  min: 1.0,
//                  max: 500.0,
//                  onChanged: (double value) {
//                    setState(() {
//                      _size = value;
//                    });
//                  },
//                  value: _size),
//            ],
//          ),
//          new Text("Size: $_size"),
//        ]),
//      ),
//    );
  }
}
