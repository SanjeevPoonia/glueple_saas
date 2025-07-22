import 'package:flutter/material.dart';
import 'package:glueplenew/attendance_screens/attendance_14.dart';
import 'package:glueplenew/attendance_screens/attendancehome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const Attendance14(),
    );
  }
}
