import 'package:equatable/equatable.dart';
import 'package:sensor_data/sensor_data/data/models/magnetic_field_data_model.dart';

class SensorReadingsModel extends Equatable {
  final num pressure;
  final num relativeHumidity;
  final num deviceTemperature;
  final num illuminance;
  final MagneticFieldDataModel magneticField;

  const SensorReadingsModel(
      {required this.pressure,
      required this.relativeHumidity,
      required this.deviceTemperature,
      required this.illuminance,
      required this.magneticField});

  factory SensorReadingsModel.fromList(List<List<num>> dataList) {
    return SensorReadingsModel(
        pressure: dataList[0][0],
        relativeHumidity: dataList[1][0],
        deviceTemperature: dataList[2][0],
        illuminance: dataList[3][0],
        magneticField: MagneticFieldDataModel.fromList(dataList[4]));
  }



  @override
  List<Object?> get props => [
        pressure,
        relativeHumidity,
        deviceTemperature,
        illuminance,
        magneticField
      ];
}
