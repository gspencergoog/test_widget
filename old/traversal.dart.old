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

class _MyHomePageState extends State<MyHomePage> {
  static bool multiLayer = false;

  Widget _makeMultilayerCell(BuildContext context, int row, int col) {
    return new Semantics(
      sortKey: new GroupSortKey(col.toDouble()),
      child: new Semantics(
        sortKey: new OrdinalSortKey(row.toDouble()),
        container: true,
        child: new ConstrainedBox(
          constraints: new BoxConstraints.tight(const Size.fromRadius(50.0)),
          child: new Center(
            child: new Text('$row, $col', style: Theme.of(context).textTheme.display1),
          ),
        ),
      ),
    );
  }

  Widget _makeFlatCell(BuildContext context, int row, int col) {
    return new Semantics(
      sortOrder: new SemanticsSortOrder(
        keys: <SemanticsSortKey>[
          new GroupSortKey(col.toDouble()),
          new OrdinalSortKey(row.toDouble())
        ],
      ),
      container: true,
      child: new ConstrainedBox(
        constraints: new BoxConstraints.tight(const Size.fromRadius(50.0)),
        child: new Center(
          child: new Text('$row, $col', style: Theme.of(context).textTheme.display1),
        ),
      ),
    );
  }

  Widget _makeCell(BuildContext context, int row, int col) {
    return multiLayer ? _makeMultilayerCell(context, row, col) : _makeFlatCell(context, row, col);
  }

  Widget _makeCenterCell(BuildContext context) {
    if (multiLayer) {
      return new Semantics(
        sortKey: new GroupSortKey(1.0),
        child: new Semantics(
          sortKey: new OrdinalSortKey(3.0),
          label: 'Center',
          child: new ExcludeSemantics(
            child: _makeMultilayerCell(context, 1, 1),
          ),
        ),
      );
    } else {
      return new Semantics(
        sortOrder: new SemanticsSortOrder(
          keys: <SemanticsSortKey>[new GroupSortKey(1.0), new OrdinalSortKey(3.0)],
        ),
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
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(' Col A ', textScaleFactor: 2.0),
                const Text(' Col B ', textScaleFactor: 2.0),
                const Text(' Col C ', textScaleFactor: 2.0),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _makeCell(context, 0, 0),
                _makeCell(context, 0, 1),
                _makeCell(context, 0, 2),
                const Text(' Row A ', textScaleFactor: 2.0),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _makeCell(context, 1, 0),
                _makeCenterCell(context),
                _makeCell(context, 1, 2),
                const Text(' Row B ', textScaleFactor: 2.0),
              ],
            ),
            new Row(


              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _makeCell(context, 2, 0),
                _makeCell(context, 2, 1),
                _makeCell(context, 2, 2),
                const Text(' Row C ', textScaleFactor: 2.0),
              ],
            )
          ],
        ),
      ),
    );
  }
}
