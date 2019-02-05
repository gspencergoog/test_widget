import 'dart:async';
import 'dart:math';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

final Map<int, Color> m2SwatchColors = <int, Color>{
  50: const Color(0xfff2e7fe),
  100: const Color(0xffd7b7fd),
  200: const Color(0xffbb86fc),
  300: const Color(0xff9e55fc),
  400: const Color(0xff7f22fd),
  500: const Color(0xff6200ee),
  600: const Color(0xff4b00d1),
  700: const Color(0xff3700b3),
  800: const Color(0xff270096),
  900: const Color(0xff270096),
};
final MaterialColor m2Swatch = new MaterialColor(m2SwatchColors[500].value, m2SwatchColors);

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Chips Test',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Chips Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

/// A Widget that sets the title text color for its children, while
/// leaving all other ambient attributes alone.
class TitleColorTheme extends StatelessWidget {
  TitleColorTheme({Key key, this.child, this.titleColor}) : super(key: key);

  final Color titleColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    // The partialTheme is very incomplete: just replacing theme.textTheme with that
    // wouldn't do what we want.
    TextTheme partialTheme = new TextTheme(title: new TextStyle(color: titleColor));
    theme = Theme.of(context).copyWith(textTheme: theme.textTheme.merge(partialTheme));
    print('partial: $partialTheme\nfull: ${theme.textTheme.title.color}');
    return new Theme(data: theme, child: child);
  }
}

/// A Widget that sets the title text color for its children, while
/// leaving all other ambient attributes alone.
class TitleColorThemeCopy extends StatelessWidget {
  TitleColorThemeCopy({Key key, this.child, this.titleColor}) : super(key: key);

  final Color titleColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    theme = theme.copyWith(
      textTheme: theme.textTheme.copyWith(
        title: theme.textTheme.title.copyWith(
          color: titleColor,
        ),
      ),
    );
    return new Theme(data: theme, child: child);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  double _size = 1.0;
  bool _enable = true;
  bool _slowAnimations = false;
  bool _rtl = false;
  bool _longText = false;
  static final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void _setValue(double value) {
    setState(() {
      sliderValue = value;
      testValue = _longText ? pow(2, value).round() : value.round();
    });
  }

  double sliderValue = 0.0;
  int testValue = 1;

  Widget _buildControls(BuildContext context) {
    final SliderThemeData controlTheme = SliderTheme.of(context).copyWith(
          thumbColor: Colors.grey[50],
          activeTickMarkColor: Colors.deepPurple[200],
          activeTrackColor: Colors.deepPurple[300],
          inactiveTrackColor: Colors.grey[50],
        );

    return new PreferredSize(
      preferredSize: const Size.fromHeight(150.0),
      child: new Padding(
        padding: new EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 10.0),
        child: new TitleColorThemeCopy(
          titleColor: const Color(0xffff0000),
          child: new Builder(builder: (BuildContext context) {
            return new Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Row(
                    children: <Widget>[
                      new Text(
                        'Text Scale',
                        style: Theme.of(context).textTheme.title,
                      ),
                      new Expanded(
                        child: new SliderTheme(
                          data: controlTheme,
                          child: new Slider(
                              label: '$_size',
                              min: 0.5,
                              max: 3.0,
                              //divisions: 18 * 2,
                              onChanged: (double value) {
                                setState(() {
                                  _size = value;
                                });
                              },
                              value: _size),
                        ),
                      ),
                      new Text(
                        "${_size.toStringAsFixed(3)}",
                        style: new TextStyle(color: Colors.grey[50]),
                      ),
                    ],
                  ),
                ),
                new Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    new Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Checkbox(
                          onChanged: (bool checked) {
                            setState(() {
                              _enable = checked;
                            });
                          },
                          value: _enable,
                        ),
                        new Text(
                          'Enabled',
                          style: new TextStyle(color: Colors.grey[50]),
                        ),
                      ],
                    ),
                    new Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Checkbox(
                          onChanged: (bool checked) {
                            setState(() {
                              _slowAnimations = checked;
                            });
                            new Future.delayed(new Duration(milliseconds: 150)).then((dynamic _) {
                              if (_slowAnimations) {
                                timeDilation = 20.0;
                              } else {
                                timeDilation = 1.0;
                              }
                            });
                          },
                          value: _slowAnimations,
                        ),
                        new Text(
                          'Slow',
                          style: new TextStyle(color: Colors.grey[50]),
                        ),
                      ],
                    ),
                    new Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Checkbox(
                          onChanged: (bool checked) {
                            setState(() {
                              _rtl = checked;
                            });
                          },
                          value: _rtl,
                        ),
                        new Text(
                          'RTL',
                          style: new TextStyle(color: Colors.grey[50]),
                        ),
                      ],
                    ),
                    new Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Checkbox(
                          onChanged: (bool checked) {
                            setState(() {
                              _longText = checked;
                            });
                          },
                          value: _longText,
                        ),
                        new Text(
                          'Long Label',
                          style: new TextStyle(color: Colors.grey[50]),
                        ),
                      ],
                    ),
                    new MaterialButton(
                      onPressed: () {
                        setState(() {
                          _size = 1.0;
                          _enable = true;
                          _slowAnimations = false;
                          _longText = false;
                          sliderValue = 0.0;
                          testValue = 1;
                        });
                      },
                      child: new Text(
                        'Reset',
                        style: new TextStyle(color: Colors.grey[50]),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _wrapSlider(String label, Widget slider, int value) {
    return new ListTile(
      title: new Text(label, textAlign: TextAlign.start),
      subtitle: slider,
    );
  }

  @override
  Widget build(BuildContext context) {
//    Secondary	#191919
//    Dark	#000000
//    Light	#FFFFFF
//    Error	#FF1744

    ThemeData theme1 = new ThemeData(
      primarySwatch: m2Swatch,
    );
    SliderThemeData theme2 = theme1.sliderTheme;

    List<Widget> tiles = <Widget>[
      _wrapSlider(
        _rtl ? 'مستمر' : 'Continuous',
        new Slider(
            label: '$testValue',
            min: 0.0,
            max: 20.0,
            onChanged: _enable ? _setValue : null,
            value: sliderValue),
        testValue,
      ),
      Spacer(flex: 1),
      _wrapSlider(
        _rtl ? 'منفصله' : 'Discrete',
        new Slider(
            label: '$testValue',
            min: 0.0,
            max: 20.0,
            divisions: 10,
            onChanged: _enable ? _setValue : null,
            value: sliderValue),
        testValue,
      ),
      Spacer(flex: 5),
      new Center(child: new Text('Set Value: $testValue')),
    ];
//    tiles = ListTile.divideTiles(context: context, tiles: tiles).toList();

    return new SafeArea(
      child: new Theme(
        data: theme1,
        child: new DefaultTextStyle(
          style: new TextStyle(color: Colors.white, fontSize: 14.0, fontFamily: 'Roboto', fontStyle: FontStyle.normal),
          child: new Scaffold(
            key: scaffoldKey,
            appBar: new AppBar(
              title: new Text('M2 Slider'),
              bottom: _buildControls(context),
              backgroundColor: const Color(0xff323232),
            ),
            body: new Directionality(
              textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
              child: new Scrollbar(
                child: new SliderTheme(
                  data: theme2,
                  child: new MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: _size),
//                    data: new MediaQueryData(
//                      textScaleFactor: 2.0,
//                      size: window.physicalSize / window.devicePixelRatio,
//                      padding: const EdgeInsets.all(100.0),
//                      viewInsets: const EdgeInsets.all(50.0),
//                    ),
                    child: new Column(
//                      padding: new EdgeInsets.all(0.0),
                      children: tiles,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
