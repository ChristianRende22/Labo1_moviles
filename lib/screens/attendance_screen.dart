import 'package:flutter/material.dart';

import '../data/attendee_seed_data.dart';
import '../models/attendee.dart';
import '../widgets/attendance_header.dart';
import '../widgets/attendee_tile.dart';

/// Unica pantalla de la practica.
///
/// Concentra todo el estado (la lista de asistentes) en este
/// StatefulWidget (requisito 4.3). Todas las modificaciones pasan por
/// setState y ningun otro widget guarda ni muta esta lista: la
/// cabecera y cada fila solo reciben datos ya calculados por aca.
class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key, required this.groupName});

  final String groupName;

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<Attendee> _attendees = List.of(attendeeSeedData);

  int get _presentCount => _attendees.where((a) => a.isPresent).length;

  void _toggleAttendee(String id) {
    setState(() {
      _attendees = [
        for (final attendee in _attendees)
          if (attendee.id == id)
            attendee.copyWith(isPresent: !attendee.isPresent)
          else
            attendee,
      ];
    });
  }

  void _markAllPresent() {
    setState(() {
      _attendees = [
        for (final attendee in _attendees) attendee.copyWith(isPresent: true),
      ];
    });
  }

  void _resetAttendance() {
    setState(() {
      _attendees = List.of(attendeeSeedData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AttendanceHeader(
              groupName: widget.groupName,
              presentCount: _presentCount,
              totalCount: _attendees.length,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 80),
                itemCount: _attendees.length,
                itemBuilder: (context, index) {
                  final attendee = _attendees[index];
                  return AttendeeTile(
                    key: ValueKey(attendee.id),
                    attendee: attendee,
                    onToggle: _toggleAttendee,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _resetAttendance,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reiniciar'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: _markAllPresent,
                  icon: const Icon(Icons.done_all),
                  label: const Text('Todos presentes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
