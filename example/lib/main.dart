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
  String _platformVersion = 'Unknown';
  BarometerValue _currentPressure = BarometerValue(0.0);

  @override
  void initState() {
    super.initState();
    initPlatformState();
    FlutterBarometer.currentPressureEvent.listen((event) {
      setState(() {
        _currentPressure = event;
      });
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await FlutterBarometer.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
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
                'Running on: $_platformVersion\n',
                style: TextStyle(fontSize: 30),
              ),
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
