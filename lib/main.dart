import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:image/image.dart' as image;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

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
    timeDilation = 1.0;

    return new MaterialApp(
      home: new Material(
        child: new Center(
          child: new CastFilter(),
        ),
      ),
    );
  }
}

class ActorFilterEntry {
  const ActorFilterEntry(this.name, this.initials);
  final String name;
  final String initials;
}

class CastFilter extends StatefulWidget {
  @override
  State createState() => new CastFilterState();
}

class CastFilterState extends State<CastFilter> {
  final List<ActorFilterEntry> _cast = <ActorFilterEntry>[
    const ActorFilterEntry('Aaron Burr', 'AB'),
    const ActorFilterEntry('Alexander Hamilton', 'AH'),
    const ActorFilterEntry('Eliza Hamilton', 'EH'),
    const ActorFilterEntry('James Madison', 'JM'),
  ];
  List<String> _filters = <String>[];

  final GlobalKey boundaryKey = new GlobalKey();

  Iterable<Widget> get actorWidgets sync* {
    for (ActorFilterEntry actor in _cast) {
      yield new Padding(
        padding: const EdgeInsets.all(4.0),
        child: new FilterChip(
          avatar: new CircleAvatar(child: new Text(actor.initials)),
          label: new Text(actor.name),
          selected: _filters.contains(actor.name),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _filters.add(actor.name);
              } else {
                _filters.removeWhere((String name) {
                  return name == actor.name;
                });
              }
            });
          },
        ),
      );
    }
  }

  Future<image.Image> getImage(RenderRepaintBoundary object) async {
    ui.Image capture = await object.toImage();
    ByteData data = await capture.toByteData();
    return new image.Image.fromBytes(capture.width, capture.height, data.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new RepaintBoundary(
          key: boundaryKey,
          child: new Wrap(
            children: actorWidgets.toList(),
          ),
        ),
        new Text('Look for: ${_filters.join(', ')}'),
        new RaisedButton(
          onPressed: () async {
            image.Image chipImage = await getImage(boundaryKey.currentContext.findRenderObject());
            final Directory directory = await getApplicationDocumentsDirectory();
            File outputFile = new File(path.join(directory.path, 'test.png'));
            await outputFile.writeAsBytes(image.encodePng(chipImage));
            print('Wrote file');
          },
          child: const Text('Snap'),
        ),
      ],
    );
  }
}
