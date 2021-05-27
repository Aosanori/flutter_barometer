package com.example.flutter_barometer;

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * FlutterBarometerPlugin
 */
public class FlutterBarometerPlugin implements FlutterPlugin, MethodCallHandler, SensorEventListener {
    private MethodChannel channel;
    private EventChannel stream;
    private SensorManager sensorManager;
    private EventChannel.EventSink sinkOnChanged;
    public Sensor pressureSensor;
    private Context applicationContext = null;

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        applicationContext = null;
        sensorManager.unregisterListener(this);
        channel.setMethodCallHandler(null);
    }

    @Override
    public void onSensorChanged(SensorEvent sensorEvent) {
        double pressure = sensorEvent.values[0];
        if (sinkOnChanged != null) {
            sinkOnChanged.success(pressure);
        }
    }

    @Override
    public void onAccuracyChanged(Sensor sensor, int i) {

    }

    private boolean initializePressureSensor() {
        sensorManager = (SensorManager) applicationContext.getSystemService(Context.SENSOR_SERVICE);
        if (sensorManager.getDefaultSensor(Sensor.TYPE_PRESSURE) != null) {
            pressureSensor = sensorManager.getDefaultSensor(Sensor.TYPE_PRESSURE);
            sensorManager.registerListener(this, pressureSensor, SensorManager.SENSOR_DELAY_NORMAL);
            return true;
        } else {
            pressureSensor = null;
            return false;
        }
    }

    private EventChannel.StreamHandler handler() {
        return new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object listener, EventChannel.EventSink events) {
                if (initializePressureSensor()) {
                    sinkOnChanged = events;
                }
            }

            @Override
            public void onCancel(Object args) {
                sinkOnChanged = null;
            }
        };
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        applicationContext = flutterPluginBinding.getApplicationContext();
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_barometer");
        channel.setMethodCallHandler(this);
        stream = new EventChannel(flutterPluginBinding.getBinaryMessenger(), "pressureStream");
        stream.setStreamHandler(handler());
    }

    // こいつが呼ばれる
    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        // getPlatFormVersionが呼ばれた時
        if (call.method.equals("getPlatformVersion")) {
            // この値が返る
            result.success("Android " + android.os.Build.VERSION.RELEASE);
            return;
        }
        result.notImplemented();
    }
}
