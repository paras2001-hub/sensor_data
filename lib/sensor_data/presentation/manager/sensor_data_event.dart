part of 'sensor_data_bloc.dart';

abstract class SensorDataEvent extends Equatable {
  const SensorDataEvent();

  @override
  List<Object?> get props => [];
}

class StartSensorDataStream extends SensorDataEvent {
  const StartSensorDataStream();

  @override
  List<Object?> get props => [];
}

class PauseSensorDataStream extends SensorDataEvent {
  final SensorReadingsModel latestSensorReadingsModel;

  const PauseSensorDataStream({required this.latestSensorReadingsModel});

  @override
  List<Object?> get props => [latestSensorReadingsModel];
}