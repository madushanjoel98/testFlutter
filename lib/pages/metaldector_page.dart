import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class EC extends StatelessWidget {
  const EC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MetalDetectorApp extends StatefulWidget {
  const MetalDetectorApp({super.key});

  @override
  _MetalDetectorAppState createState() => _MetalDetectorAppState();
}

class _MetalDetectorAppState extends State<MetalDetectorApp> {
  double _intensity = 0.0;
  AccelerometerEvent? _accelerometerEvent;
  MagnetometerEvent? _magnetometerEvent;
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  StreamSubscription<MagnetometerEvent>? _magnetometerSubscription;

  @override
  void initState() {
    super.initState();
    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerEvent = event;
        _calculateIntensity();
      });
    });

    _magnetometerSubscription =
        magnetometerEvents.listen((MagnetometerEvent event) {
      setState(() {
        _magnetometerEvent = event;
        _calculateIntensity();
      });
    });
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    _magnetometerSubscription?.cancel();
    super.dispose();
  }

  void _calculateIntensity() {
    if (_accelerometerEvent != null && _magnetometerEvent != null) {
      double x = _accelerometerEvent!.x;
      double y = _accelerometerEvent!.y;
      double z = _accelerometerEvent!.z;
      double intensity = (x * x) + (y * y) + (z * z);

      double mx = _magnetometerEvent!.x;
      double my = _magnetometerEvent!.y;
      double mz = _magnetometerEvent!.z;
      double magnetism = (mx * mx) + (my * my) + (mz * mz);

      setState(() {
        _intensity = intensity + magnetism;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Metal Intensity:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              _intensity.toStringAsFixed(2),
              style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
