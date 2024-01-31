import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:sensor_data/core/failures.dart';
import 'package:sensor_data/sensor_data/data/data_sources/sensor_data_source.dart';

import '../models/sensor_data_model.dart';

abstract class SensorDataRepository {
  Future<Either<Failure, Stream<SensorReadingsModel>>> getSensorData();
}

class SensorDataRepositoryImpl implements SensorDataRepository {
  final SensorDataSource sensorDataSource;

  SensorDataRepositoryImpl({required this.sensorDataSource});

  @override
  Future<Either<Failure, Stream<SensorReadingsModel>>> getSensorData() async {
    try {
      final result = sensorDataSource.getSensorData();
      return Right(result);
    } on PlatformException {
      return Left(PlatformFailure());
    }
  }
}