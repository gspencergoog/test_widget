import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MyHomePage(title: 'Testing Test'),
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
  bool selected = false;
  final GlobalKey chipKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final Key labelKey = new UniqueKey();
    timeDilation = 1.0;

    return new MaterialApp(
      home: new Material(
        child: new Center(
          child: new RawChip(
            key: chipKey,
            avatar: new Container(width: 40.0, height: 40.0, color: Colors.red),
            onSelected: (bool value) {
              setState(() {
                print('Selected: $value');
                selected = value;
              });
            },
            isEnabled: true,
            selected: selected,
            label: new Text('Chip', key: labelKey),
            showCheckmark: true,
            border: new StadiumBorder(),
          ),
        ),
      ),
    );
  }
}
