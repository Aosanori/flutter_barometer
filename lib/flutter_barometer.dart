import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class FlutterBarometer {
  static const MethodChannel _channel =
      const MethodChannel('flutter_barometer');
  static const EventChannel _barometerEventChannel =
      EventChannel('pressureStream');

  static var _onPressureChanged;

  static void initializePressureSensor() async {
    if (Platform.isAndroid) {
      final result = await _channel.invokeMethod('initializePressureSensor');
      print(result);
    }
  }

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<double> get currentPressue async {
    final pressure = await _channel.invokeMethod('getCurrentPressure');
    return pressure;
  }

  static Stream<double> get currentPressueEvent {
    if (_onPressureChanged == null) {
      _onPressureChanged = _barometerEventChannel.receiveBroadcastStream().map(
            (element) => element as double,
          );
    }
    return _onPressureChanged;
  }
}
