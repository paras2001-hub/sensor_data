import 'dart:async';

import 'package:flutter/services.dart';
import 'package:sensor_data/sensor_data/data/models/sensor_data_model.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/constants.dart';

abstract class SensorDataSource {
  Stream<SensorReadingsModel> getSensorData();
}

class SensorDataSourceImpl implements SensorDataSource {
  static const pressureChannel = EventChannel("$rootName/pressure");
  static const temperatureChannel = EventChannel("$rootName/temperature");
  static const relativeHumidityChannel =
      EventChannel("$rootName/relative_humidity");
  static const illuminanceChannel = EventChannel("$rootName/illuminance");
  static const magneticFieldChannel = EventChannel("$rootName/magnetic_field");

  @override
  Stream<SensorReadingsModel> getSensorData() {
    Stream pressureStream =
        pressureChannel.receiveBroadcastStream().shareValueSeeded([0]);
    Stream temperatureStream =
        temperatureChannel.receiveBroadcastStream().shareValueSeeded([0]);
    Stream relativeHumidityStream =
        relativeHumidityChannel.receiveBroadcastStream().shareValueSeeded([0]);
    Stream illuminanceStream =
        illuminanceChannel.receiveBroadcastStream().shareValueSeeded([0]);
    Stream magneticFieldStream = magneticFieldChannel
        .receiveBroadcastStream()
        .shareValueSeeded([0, 0, 0]);

    Stream<SensorReadingsModel> sensorDataStream = Rx.combineLatest5(
        pressureStream,
        temperatureStream,
        relativeHumidityStream,
        illuminanceStream,
        magneticFieldStream,
        (a, b, c, d, e) => SensorReadingsModel.fromList([a, b, c, d, e]));

    return sensorDataStream.asBroadcastStream();
  }
}
