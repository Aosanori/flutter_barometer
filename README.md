# flutter_barometer_plugin

This plugin makes it easier to use barometer of devices.

## Getting Started

Use this package as a library
Depend on it
Run this command:

With Flutter:

` $ flutter pub add flutter_barometer_plugin`

This will add a line like this to your package's pubspec.yaml (and run an implicit dart pub get):


``` yaml
dependencies: 
  flutter_barometer_plugin: ^0.0.1+3
```

Alternatively, your editor might support flutter pub get. Check the docs for your editor to learn more.

Import it
Now in your Dart code, you can use:

`import 'package:flutter_barometer_plugin/flutter_barometer.dart';`

## Usage 

### Example

``` dart
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_barometer/flutter_barometer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BarometerValue _currentPressure = BarometerValue(0.0);

  @override
  void initState() {
    super.initState();
    FlutterBarometer.currentPressueEvent.listen((event) {
      setState(() {
        _currentPressure = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('flutter_barometer'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${(_currentPressure.hectpascal * 1000).round() / 1000} hPa',
                style: TextStyle(
                  fontSize: 70,
                ),
              ),
              Text(
                '${(_currentPressure.inchOfMercury * 1000).round() / 1000} inHg',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Text(
                '${(_currentPressure.millimeterOfMercury * 1000).round() / 1000} mmHg',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Text(
                '${(_currentPressure.poundsSquareInch * 1000).round() / 1000} psi',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Text(
                '${(_currentPressure.atm * 1000).round() / 1000} atm',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```


