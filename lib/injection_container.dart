import 'package:get_it/get_it.dart';
import 'package:sensor_data/sensor_data/data/data_sources/sensor_data_source.dart';
import 'package:sensor_data/sensor_data/data/repositories/sensor_data_repository.dart';
import 'package:sensor_data/sensor_data/presentation/manager/sensor_data_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => SensorDataBloc(repository: sl()));

  sl.registerLazySingleton<SensorDataRepository>(
      () => SensorDataRepositoryImpl(sensorDataSource: sl()));

  sl.registerLazySingleton<SensorDataSource>(() => SensorDataSourceImpl());
}
