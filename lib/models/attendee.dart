/// Modelo de datos de un registro de asistencia.
///
/// Es inmutable a proposito: cualquier cambio (por ejemplo marcar
/// presente/ausente) se hace creando una copia nueva con [copyWith].
/// Asi la unica fuente de verdad sigue siendo la lista que vive en
/// el estado de la pantalla, y nadie modifica un registro "por fuera".
class Attendee {
  const Attendee({
    required this.id,
    required this.name,
    required this.studentId,
    required this.isPresent,
  });

  final String id;
  final String name;
  final String studentId;
  final bool isPresent;

  Attendee copyWith({bool? isPresent}) {
    return Attendee(
      id: id,
      name: name,
      studentId: studentId,
      isPresent: isPresent ?? this.isPresent,
    );
  }
}
