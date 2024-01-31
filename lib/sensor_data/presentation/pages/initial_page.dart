import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sensor_data/core/constants.dart';

import '../../../core/color_scheme.dart';
import '../manager/sensor_data_bloc.dart';
import '../widgets/space_helpers.dart';
import 'home_page.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage>
    with TickerProviderStateMixin {
  late AnimationController __logoAnimationController;
  late Animation _offsetAnimation;
  late Animation _blurAnimation;

  late AnimationController _opacityAnimationController;
  late Animation _opacityAnimation;

  @override
  void initState() {
    super.initState();
    setupControllers();
    setupAnimations();
  }

  @override
  void dispose() {
    super.dispose();
    disposeControllers();
  }

  void _dispatchStartSensorDataStreaming(BuildContext context) {
    Navigator.of(context).pushNamed(homeRoute);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: InkWell(
        splashColor: colorScheme.onBackground.withOpacity(0.3),
        focusColor: colorScheme.onBackground,
        highlightColor: colorScheme.primary,
        onTap: () => _dispatchStartSensorDataStreaming(context),
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              addVerticalSpace(height * .2),
              Text(
                "Sensor²",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: height * .06,
                    color: colorScheme.onPrimary,
                    shadows: <Shadow>[
                      Shadow(
                          color: colorScheme.primary,
                          blurRadius: _blurAnimation.value,
                          offset: Offset(_offsetAnimation.value,
                              _offsetAnimation.value * .95)),
                      Shadow(
                          color: colorScheme.surface,
                          blurRadius: _blurAnimation.value,
                          offset: Offset(-(_offsetAnimation.value * .975),
                              -(_offsetAnimation.value * .955))),
                    ]),
              ),
              addVerticalSpace(height * .55),
              Opacity(
                opacity: _opacityAnimation.value,
                child: Text(
                  "Tap to start reading data from sensors.",
                  style: TextStyle(
                      color: colorScheme.onPrimary, fontSize: height * .015),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setupControllers() {
    __logoAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    __logoAnimationController.repeat(reverse: true);
    __logoAnimationController.addListener(() {
      setState(() {});
    });

    _opacityAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    _opacityAnimationController.repeat(reverse: true);
    _opacityAnimationController.addListener(() {
      setState(() {});
    });
  }

  void setupAnimations() {
    _offsetAnimation =
        Tween<double>(begin: 10, end: 15).animate(__logoAnimationController);

    _blurAnimation =
        Tween<double>(begin: 75, end: 90).animate(__logoAnimationController);

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _opacityAnimationController, curve: Curves.easeIn));
  }

  void disposeControllers() {
    __logoAnimationController.dispose();
    _opacityAnimationController.dispose();
  }
}
