import 'package:flutter/material.dart';

import '../models/attendee.dart';

/// Fila individual de la lista de asistencia.
///
/// Widget extraido a su propia clase (requisito 4.1): recibe los datos
/// del [Attendee] a mostrar y un callback [onToggle] por constructor.
/// No consulta el estado de AttendanceScreen ni la lista completa de
/// asistentes, solo conoce el registro que le pasaron.
class AttendeeTile extends StatelessWidget {
  const AttendeeTile({
    super.key,
    required this.attendee,
    required this.onToggle,
  });

  final Attendee attendee;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: CircleAvatar(
          backgroundColor:
              attendee.isPresent ? Colors.green.shade100 : Colors.grey.shade300,
          child: Icon(
            attendee.isPresent ? Icons.check : Icons.close,
            color: attendee.isPresent ? Colors.green.shade800 : Colors.grey.shade700,
          ),
        ),
        title: Text(
          attendee.name,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text('Carne: ${attendee.studentId}'),
        trailing: Switch(
          value: attendee.isPresent,
          onChanged: (_) => onToggle(attendee.id),
        ),
        onTap: () => onToggle(attendee.id),
      ),
    );
  }
}
