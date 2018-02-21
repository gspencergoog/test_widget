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
  double _size = 1.0;
  double _testValue = 1.0;

  void _setValue(double value) {
    setState(() {
      _testValue = pow(2, value);
    });
  }

  double get sliderValue => _testValue > 0.0 ? log(_testValue) / ln2 : 0.0;

  Widget _wrapSlider(String label, Widget slider) {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Center(child: new Text(label)),
        new Expanded(child: slider),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme1 = Theme.of(context).copyWith(sliderTheme: new SliderThemeData(activeRail: Colors.black));
    SliderThemeData theme2 = theme1.sliderTheme.copyWith(thumb: Colors.red,
        activeTickMarks: Colors.black);
    return new DefaultTextStyle(
      style: new TextStyle(
          color: Colors.white,
          fontSize: 14.0,
          fontFamily: 'Roboto',
          fontStyle: FontStyle.normal),
      child: new Material(
        child: new Theme(
          data: theme1,
          child: new MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: _size),
            child: new SliderTheme(
              data: theme2,
              child: new Padding(
                padding: new EdgeInsets.all(20.0),
                child: new Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new Padding(padding: const EdgeInsets.only(top: 60.0)),
                    const Text(
                      'M2 Sliders',
                      style: const TextStyle(
                          fontSize: 32.0, fontWeight: FontWeight.bold),
                    ),
                    _wrapSlider(
                      '          ',
                      new Slider(
                          label: '${_testValue.floor()}',
                          min: 0.0,
                          max: 18.0,
                          onChanged: _setValue,
                          value: sliderValue),
                    ),
                    new Divider(),
                    new Directionality(
                      textDirection: TextDirection.rtl,
                      child: _wrapSlider(
                        'RTL Discrete',
                        new Slider(
                            label: '${_testValue.floor()}',
                            min: 0.0,
                            max: 18.0,
                            divisions: 9,
                            onChanged: _setValue,
                            value: sliderValue),
                      ),
                    ),
                    new Divider(),
                    _wrapSlider(
                      'Disabled Discrete',
                      new Slider(
                        label: '0.0',
                        min: 10.0,
                        max: 10.0,
                        divisions: 9,
                        onChanged: null,
                        value: 10.0,
                      ),
                    ),
                    new Divider(),
                    _wrapSlider(
                      'Discrete',
                      new Slider(
                          label: '${_testValue.floor()}',
                          min: 0.0,
                          max: 18.0,
                          divisions: 9,
                          onChanged: _setValue,
//                        activeColor: Colors.purple,
//                        inactiveColor: Colors.white,
                          value: sliderValue),
                    ),
                    new Divider(),
                    _wrapSlider(
                      'Disabled Continuous',
                      new Slider(
                        label: '0.0',
                        min: 10.0,
                        max: 10.0,
                        onChanged: null,
                        value: 10.0,
                      ),
                    ),
                    new Divider(),
                    new Flexible(child: new Container()),
                    new Row(
                      children: <Widget>[
                        new Expanded(
                            child: new Slider(
                                label: '$_size',
                                min: 0.25,
                                max: 9.5 / 2.0,
                                divisions: 18 * 2,
                                onChanged: (double value) {
                                  setState(() {
                                    _size = value;
                                  });
                                },
                                value: _size)),
                        new MaterialButton(
                          onPressed: () {
                            setState(() {
                              _size = 1.0;
                              _testValue = 0.0;
                            });
                          },
                          child: const Text('Reset'),
                        ),
                      ],
                    ),
                    new Text("Text Scale Factor: $_size", textScaleFactor: 1.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
