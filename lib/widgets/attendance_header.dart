import 'package:flutter/material.dart';

/// Cabecera fija de la pantalla.
///
/// Es un widget aparte y sin estado: solo recibe por constructor los
/// valores ya calculados (nombre del grupo, presentes y total) y los
/// pinta. No lee el estado de la pantalla ni contiene logica propia,
/// por eso puede reconstruirse barato en cada cambio.
class AttendanceHeader extends StatelessWidget {
  const AttendanceHeader({
    super.key,
    required this.groupName,
    required this.presentCount,
    required this.totalCount,
  });

  final String groupName;
  final int presentCount;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      color: theme.colorScheme.primaryContainer,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              groupName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$presentCount/$totalCount presentes',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
