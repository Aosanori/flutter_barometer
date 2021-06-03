import 'dart:async';

import 'package:flutter/services.dart';

class FlutterBarometer {
  static const MethodChannel _channel =
      const MethodChannel('flutter_barometer');
  static const EventChannel _barometerEventChannel =
      EventChannel('pressureStream');

  static var _onPressureChanged;

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<BarometerValue> get currentPressure async {
    final pressure = await _channel.invokeMethod('getCurrentPressure');
    return BarometerValue(pressure);
  }

  static Stream<BarometerValue> get currentPressureEvent {
    if (_onPressureChanged == null) {
      _onPressureChanged = _barometerEventChannel.receiveBroadcastStream().map(
            (element) => BarometerValue(element as double),
          );
    }
    return _onPressureChanged;
  }

}

class BarometerValue {
  const BarometerValue(this.hectpascal);
  final double hectpascal;

  double get inchOfMercury => hectpascal / 33.8639;
  double get millimeterOfMercury => hectpascal / 1.33322;
  double get poundsSquareInch => hectpascal / 68.9476;
  double get atm => hectpascal / 1013.25;
}
