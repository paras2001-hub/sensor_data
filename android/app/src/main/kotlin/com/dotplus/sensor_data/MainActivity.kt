package com.dotplus.sensor_data

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val rootName = "com.dotplus.sensor_data"
    private val methodChannelName = "$rootName/sensor_method"
    private val pressureChannelName = "$rootName/pressure"
    private val humidityChannelName = "$rootName/relative_humidity"
    private val temperatureChannelName = "$rootName/temperature"
    private val magneticFieldChannelName = "$rootName/magnetic_field"
    private val illuminanceChannelName = "$rootName/illuminance"

    private lateinit var methodChannel: MethodChannel
    private lateinit var sensorManager: SensorManager

    private lateinit var pressureChannel: EventChannel
    private var pressureStreamHandler: StreamHandler? = null

    private lateinit var humidityChannel: EventChannel
    private var humidityStreamHandler: StreamHandler? = null

    private lateinit var temperatureChannel: EventChannel
    private var temperatureStreamHandler: StreamHandler? = null

    private lateinit var magneticFieldChannel: EventChannel
    private var magneticFieldStreamHandler: StreamHandler? = null

    private lateinit var illuminanceChannel: EventChannel
    private var illuminanceStreamHandler: StreamHandler? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        setupChannels(this, flutterEngine.dartExecutor.binaryMessenger)
    }

    override fun onDestroy() {
        destroyChannels()
        super.onDestroy()
    }

    private fun setupChannels(context: Context, messenger: BinaryMessenger){
        sensorManager = context.getSystemService(Context.SENSOR_SERVICE) as SensorManager
//        methodChannel = MethodChannel(messenger, methodChannelName)
//        methodChannel.setMethodCallHandler{
//            call, result ->
//            if (call.method == "isSensorAvailable") {
//                result.success(sensorManager.getSensorList(Sensor.TYPE_PRESSURE).isNotEmpty())
//            } else {
//                result.notImplemented()
//            }
//        }

        pressureChannel = EventChannel(messenger, pressureChannelName)
        pressureStreamHandler = StreamHandler(sensorManager, Sensor.TYPE_PRESSURE)
        pressureChannel.setStreamHandler(pressureStreamHandler)

        humidityChannel = EventChannel(messenger, humidityChannelName)
        humidityStreamHandler = StreamHandler(sensorManager, Sensor.TYPE_RELATIVE_HUMIDITY)
        humidityChannel.setStreamHandler(humidityStreamHandler)

        temperatureChannel = EventChannel(messenger, temperatureChannelName)
        temperatureStreamHandler = StreamHandler(sensorManager, Sensor.TYPE_TEMPERATURE)
        temperatureChannel.setStreamHandler(temperatureStreamHandler)

        magneticFieldChannel = EventChannel(messenger, magneticFieldChannelName)
        magneticFieldStreamHandler = StreamHandler(sensorManager, Sensor.TYPE_MAGNETIC_FIELD)
        magneticFieldChannel.setStreamHandler(magneticFieldStreamHandler)

        illuminanceChannel = EventChannel(messenger, illuminanceChannelName)
        illuminanceStreamHandler = StreamHandler(sensorManager, Sensor.TYPE_LIGHT)
        illuminanceChannel.setStreamHandler(illuminanceStreamHandler)
    }

    private fun destroyChannels() {
//        methodChannel.setMethodCallHandler(null)
        pressureChannel.setStreamHandler(null)
        humidityChannel.setStreamHandler(null)
        temperatureChannel.setStreamHandler(null)
        magneticFieldChannel.setStreamHandler(null)
        illuminanceChannel.setStreamHandler(null)
    }
}
