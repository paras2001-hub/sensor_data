import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/sensor_data_model.dart';
import '../../data/repositories/sensor_data_repository.dart';

part 'sensor_data_event.dart';
part 'sensor_data_state.dart';

class SensorDataBloc extends Bloc<SensorDataEvent, SensorDataState> {
  final SensorDataRepository repository;

  SensorDataBloc({required this.repository}) : super(SensorDataInitial()) {
    on<StartSensorDataStream>(
      (event, emit) async {
        final resultEither = await repository.getSensorData();
        late Stream<SensorReadingsModel> stream;
        resultEither.fold(
          (failure) => emit(const SensorDataError(errorMessage: 'ERROR')),
          (sensorDataStream) {
            stream = sensorDataStream;
          },
        );
        await emit.forEach(stream.asBroadcastStream(),
            onData: (SensorReadingsModel sensorReadingsModel) {
          return SensorDataStreaming(sensorReadingsModel: sensorReadingsModel);
        });
      },
      transformer: restartable()
    );
    on<PauseSensorDataStream>((event, emit) async {
      emit(SensorDataStreaming(
          sensorReadingsModel: event.latestSensorReadingsModel));
    });
  }
}
