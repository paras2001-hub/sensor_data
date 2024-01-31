package com.dotplus.sensor_data

import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import io.flutter.plugin.common.EventChannel

class StreamHandler(private val sensorManager: SensorManager, sensorType: Int, private var interval: Int = SensorManager.SENSOR_DELAY_NORMAL)
    : EventChannel.StreamHandler, SensorEventListener {

    private val sensor = sensorManager.getDefaultSensor(sensorType)
    private var eventSink: EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        if (sensor != null) {
            eventSink = events
            sensorManager.registerListener(this, sensor, interval)
        }
    }

    override fun onCancel(arguments: Any?) {
        sensorManager.unregisterListener(this)
        eventSink = null
    }

    override fun onSensorChanged(p0: SensorEvent?) {
        if (p0 != null) {
            eventSink?.success(p0.values)
        } else {
            eventSink?.error("ON_CHANGE_ERR", "Error on value change", "An error occurred when the sensor value changed.")
        }
    }

    override fun onAccuracyChanged(p0: Sensor?, p1: Int) {}
}