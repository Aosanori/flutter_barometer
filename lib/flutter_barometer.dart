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

  static Future<double> get currentPressure async {
    final pressure = await _channel.invokeMethod('getCurrentPressure');
    return pressure;
  }

  //output as hPa
  static Stream<double> get currentPressureEvent {
    if (_onPressureChanged == null) {
      _onPressureChanged = _barometerEventChannel.receiveBroadcastStream().map(
            (element) => element as double,
          );
    }
    return _onPressureChanged;
  }

  //output as inHg
  // ignore: non_constant_identifier_names
  static Stream<double> get currentPressureEventAs_inHg {
    if (_onPressureChanged == null) {
      _onPressureChanged = _barometerEventChannel.receiveBroadcastStream().map(
            (element) => (element as double) / 33.8639,
          );
    }
    return _onPressureChanged;
  }

  //output as mmHg
  // ignore: non_constant_identifier_names
  static Stream<double> get currentPressureEventAs_mmHg {
    if (_onPressureChanged == null) {
      _onPressureChanged = _barometerEventChannel.receiveBroadcastStream().map(
            (element) => (element as double) / 1.33322,
          );
    }
    return _onPressureChanged;
  }
  // output as psi
  // ignore: non_constant_identifier_names
  static Stream<double> get currentPressureEventAs_psi {
    if (_onPressureChanged == null) {
      _onPressureChanged = _barometerEventChannel.receiveBroadcastStream().map(
            (element) => (element as double) / 68.9476,
          );
    }
    return _onPressureChanged;
  }

  // output as atm
  // ignore: non_constant_identifier_names
  static Stream<double> get currentPressureEventAs_atm {
    if (_onPressureChanged == null) {
      _onPressureChanged = _barometerEventChannel.receiveBroadcastStream().map(
            (element) => (element as double) / 1013.25,
          );
    }
    return _onPressureChanged;
  }


}
