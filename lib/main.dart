import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sensor_data/core/color_scheme.dart';
import 'package:sensor_data/core/constants.dart';
import 'package:sensor_data/core/navigation_router.dart';
import 'package:sensor_data/sensor_data/presentation/manager/sensor_data_bloc.dart';
import 'package:sensor_data/sensor_data/presentation/pages/initial_page.dart';
import 'package:sensor_data/sensor_data/presentation/widgets/space_helpers.dart';

import 'injection_container.dart' as dep_inj;
import 'injection_container.dart';

void main() async {
  await dep_inj.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sensor²',
      onGenerateRoute: NavigationRouter.generateRoute,
      initialRoute: initRoute,
      theme: ThemeData(
        colorScheme: colorScheme,
        textTheme: GoogleFonts.rubikTextTheme(),
      ),
    );
  }
}
