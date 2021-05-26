package com.example.flutter_barometer;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** FlutterBarometerPlugin */
public class FlutterBarometerPlugin extends FlutterActivity implements FlutterPlugin, MethodCallHandler{
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private EventChannel stream;

  private void getCurrentPressure (){}

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_barometer");
    channel.setMethodCallHandler(this);
    stream = new EventChannel(flutterPluginBinding.getBinaryMessenger(),"plugins.flutter.io/sensors/barometer");
    stream.setStreamHandler(new EventChannel.StreamHandler() {
      @Override
      public void onListen(Object args, EventChannel.EventSink events) {

      }
      @Override
      public void onCancel(Object args) {

      }
    });
  }

  // こいつが呼ばれる
  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    // getPlatFormVersionが呼ばれた時
    if (call.method.equals("getPlatformVersion")) {
      // この値が返る
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
