part of 'sensor_data_bloc.dart';

abstract class SensorDataState extends Equatable {
  const SensorDataState();
}

class SensorDataInitial extends SensorDataState {
  @override
  List<Object> get props => [];
}

class SensorDataStreaming extends SensorDataState {
  final SensorReadingsModel sensorReadingsModel;

  const SensorDataStreaming({required this.sensorReadingsModel});

  @override
  List<Object?> get props => [sensorReadingsModel];
}

class SensorDataError extends SensorDataState {
  final String errorMessage;

  const SensorDataError({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
