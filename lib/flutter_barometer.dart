import 'dart:async';

import 'package:flutter/services.dart';

class FlutterBarometer {
  static const MethodChannel _channel =
      const MethodChannel('flutter_barometer');
  static const EventChannel _barometerEventChannel =
      EventChannel('plugins.flutter.io/sensors/barometer');
  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static var _onPressureChanged;

  static Stream<double?> get currentPressueEvent {
    if (_onPressureChanged == null) {
      _onPressureChanged = _barometerEventChannel.receiveBroadcastStream().map(
            (element) => element as double,
          );
    }
    return _onPressureChanged;
  }
}
