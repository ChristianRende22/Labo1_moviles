import 'package:flutter/material.dart';

import 'screens/attendance_screen.dart';

void main() {
  runApp(const AsistenciaApp());
}

/// Punto de entrada de la aplicacion.
class AsistenciaApp extends StatelessWidget {
  const AsistenciaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asistencia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const AttendanceScreen(groupName: 'Chocolatina'),
    );
  }
}
