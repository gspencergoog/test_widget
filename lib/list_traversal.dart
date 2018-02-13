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

class GroupSortKey extends OrdinalSortKey {
  const GroupSortKey(double order, {String name}) : super(order, name: name);
}

enum _MaterialListType {
  /// A list tile that contains a single line of text.
  oneLine,

  /// A list tile that contains a [CircleAvatar] followed by a single line of text.
  oneLineWithAvatar,

  /// A list tile that contains two lines of text.
  twoLine,

  /// A list tile that contains three lines of text.
  threeLine,
}

class _MyHomePageState extends State<MyHomePage> {
  _MaterialListType _itemType = _MaterialListType.oneLineWithAvatar;
  bool _dense = false;
  bool _showAvatars = true;
  bool _showIcons = true;

  Widget buildListTile(BuildContext context, String item) {
    Widget secondary;
    if (_itemType == _MaterialListType.twoLine) {
      secondary = const Text('Additional item information.');
    } else if (_itemType == _MaterialListType.threeLine) {
      secondary = const Text(
        'Even more additional list item information appears on line three.',
      );
    }
    return new MergeSemantics(
      child: new ListTile(
        isThreeLine: _itemType == _MaterialListType.threeLine,
        dense: _dense,
        leading: _showAvatars
            ? new ExcludeSemantics(child: new CircleAvatar(child: new Text(item)))
            : null,
        title: new Text('This item represents $item.'),
        subtitle: secondary,
        trailing: _showIcons ? new Icon(Icons.info, color: Theme.of(context).disabledColor) : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> items = <String>[
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
    ];
    Iterable<Widget> listTiles = items.map((String item) => buildListTile(context, item));
    listTiles = ListTile.divideTiles(context: context, tiles: listTiles);

//    return new MaterialApp(
//      theme: new ThemeData.light(),
//      home: new Scaffold(
//        body: new Scrollbar(
//          child: new ListView(
//            padding: new EdgeInsets.symmetric(vertical: 8.0),
//            children: listTiles.toList(),
//          ),
//        ),
//      ),
//    );

    return new Stack(
      alignment: Alignment.center,
      children: <Widget>[
        // Set this up so that the placeholder takes up the whole screen,
        // and place the positioned boxes so that if we traverse in the
        // geometric order, we would go from box [4, 3, 2, 1, 0], but if we
        // go in child order, then we go from box [0, 1, 2, 3, 4]. We're verifying
        // that we go in child order here, not geometric order, since there
        // is no directionality, so we don't have a geometric opinion about
        // horizontal order. We do still want to sort vertically, however.
        new Semantics(
          button: true,
          child: const Placeholder(),
        ),
        new Positioned(
          top: 200.0,
          left: 100.0,
          child: new Semantics( // Box 0
            button: true,
            child: const SizedBox(width: 30.0, height: 30.0),
          ),
        ),
        new Positioned(
          top: 100.0,
          left: 200.0,
          child: new Semantics( // Box 1
            button: true,
            child: const SizedBox(width: 30.0, height: 30.0),
          ),
        ),
        new Positioned(
          top: 100.0,
          left: 100.0,
          child: new Semantics( // Box 2
            button: true,
            child: const SizedBox(width: 30.0, height: 30.0),
          ),
        ),
        new Positioned(
          top: 100.0,
          left: 0.0,
          child: new Semantics( // Box 3
            button: true,
            child: const SizedBox(width: 30.0, height: 30.0),
          ),
        ),
        new Positioned(
          top: 10.0,
          left: 100.0,
          child: new Semantics( // Box 4
            button: true,
            child: const SizedBox(width: 30.0, height: 30.0),
          ),
        ),
      ],
    );
  }
}
