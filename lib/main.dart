import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_control_test/controller/preset_controller.dart';
import 'package:remote_control_test/views/screens/connection_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => PresetController(),
    child: MaterialApp(
      home: ConnectionScreen(),
    ),
  ));
}
