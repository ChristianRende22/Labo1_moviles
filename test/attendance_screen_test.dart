import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:asistencia_app/main.dart';

void main() {
  testWidgets('marcar presente, marcar todos y reiniciar actualizan el contador',
      (tester) async {
    await tester.pumpWidget(const AsistenciaApp());

    expect(find.text('0/12 presentes'), findsOneWidget);

    await tester.tap(find.byType(Switch).first);
    await tester.pump();
    expect(find.text('1/12 presentes'), findsOneWidget);

    await tester.tap(find.text('Todos presentes'));
    await tester.pump();
    expect(find.text('12/12 presentes'), findsOneWidget);

    await tester.tap(find.text('Reiniciar'));
    await tester.pump();
    expect(find.text('0/12 presentes'), findsOneWidget);
  });
}
