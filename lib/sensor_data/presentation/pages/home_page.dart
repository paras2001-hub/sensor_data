import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sensor_data/core/color_scheme.dart';
import 'package:sensor_data/sensor_data/data/models/magnetic_field_data_model.dart';
import 'package:sensor_data/sensor_data/data/models/sensor_data_model.dart';
import 'package:sensor_data/sensor_data/presentation/widgets/space_helpers.dart';

import '../../../injection_container.dart';
import '../manager/sensor_data_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool _paused = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
  }

  void _dispatchStopStreamingEvent(
      BuildContext context, SensorReadingsModel latestSensorReadingsModel) {
    BlocProvider.of<SensorDataBloc>(context).add(PauseSensorDataStream(
        latestSensorReadingsModel: latestSensorReadingsModel));
  }

  void _dispatchStartStreamingEvent(BuildContext context) {
    BlocProvider.of<SensorDataBloc>(context).add(const StartSensorDataStream());
  }

  void _togglePausePlayStreaming(
      BuildContext context, SensorReadingsModel sensorReadingsModel) {
    _paused = !_paused;
    if (_paused) {
      _animationController.forward();
      _dispatchStopStreamingEvent(context, sensorReadingsModel);
    } else {
      _animationController.reverse();
      _dispatchStartStreamingEvent(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sensor²",
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: colorScheme.background,
      ),
      body: SafeArea(
        child: BlocProvider<SensorDataBloc>(
          create: (context) =>
              sl<SensorDataBloc>()..add(const StartSensorDataStream()),
          child: BlocConsumer<SensorDataBloc, SensorDataState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is SensorDataInitial) {
                return _initialScreen(context);
              } else if (state is SensorDataStreaming) {
                return _sensorStreamingScreen(context, state);
              } else if (state is SensorDataError) {
                return Center(
                  child: Text(state.errorMessage),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _initialScreen(BuildContext context) {
    return Container();
  }

  Widget _sensorStreamingScreen(
      BuildContext context, SensorDataStreaming state) {
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        addVerticalSpace(height * .05),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            singleMetricInfoTile(
                "Pressure", state.sensorReadingsModel.pressure),
            singleMetricInfoTile(
                "Humidity", state.sensorReadingsModel.relativeHumidity)
          ],
        ),
        addVerticalSpace(height * .05),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            singleMetricInfoTile(
                "Temperature", state.sensorReadingsModel.deviceTemperature),
            singleMetricInfoTile(
                "Illuminance", state.sensorReadingsModel.illuminance)
          ],
        ),
        addVerticalSpace(height * .05),
        tripleMetricInfoTile(
            "Magnetic Field", state.sensorReadingsModel.magneticField),
        addVerticalSpace(height * .05),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.all(height * .02),
              backgroundColor: colorScheme.primary),
          onPressed: () =>
              _togglePausePlayStreaming(context, state.sensorReadingsModel),
          child: AnimatedIcon(
            icon: AnimatedIcons.pause_play,
            progress: _animationController,
            size: height * .035,
            color: colorScheme.onPrimary,
          ),
        )
      ],
    );
  }

  Widget singleMetricInfoTile(String label, num metric) {
    double width = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: width * .035,
              fontWeight: FontWeight.w600,
              color: colorScheme.onPrimary),
        ),
        Text(
          metric == 0? "--" : metric.toStringAsFixed(2),
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: width * .07,
              color: colorScheme.primary),
        )
      ],
    );
  }

  Widget tripleMetricInfoTile(String label, MagneticFieldDataModel dataModel) {
    double width = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label,
                style: TextStyle(
                    fontSize: width * .035,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onPrimary))
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  dataModel.x.toStringAsFixed(2),
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: width * .045,
                      color: colorScheme.primary),
                ),
                Text(
                  dataModel.y.toStringAsFixed(2),
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: width * .045,
                      color: colorScheme.primary),
                ),
                Text(
                  dataModel.z.toStringAsFixed(2),
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: width * .045,
                      color: colorScheme.primary),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
