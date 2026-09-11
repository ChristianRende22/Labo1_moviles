import '../models/attendee.dart';

/// Datos iniciales del grupo, separados de la capa de presentacion.
///
/// La pantalla solo los usa para poblar la lista por primera vez y
/// para el boton "Reiniciar"; nunca se modifican aqui. Ningun widget
/// de UI construye o conoce esta lista directamente, la reciben ya
/// armada desde el estado de la pantalla.
const List<Attendee> attendeeSeedData = [
  Attendee(id: '1', name: 'Ana Beatriz Flores', studentId: '20241001', isPresent: false),
  Attendee(id: '2', name: 'Carlos Eduardo Martinez', studentId: '20241002', isPresent: false),
  Attendee(id: '3', name: 'Diana Sofia Hernandez', studentId: '20241003', isPresent: false),
  Attendee(id: '4', name: 'Emilio Jose Ramirez', studentId: '20241004', isPresent: false),
  Attendee(id: '5', name: 'Fernanda Lucia Torres', studentId: '20241005', isPresent: false),
  Attendee(id: '6', name: 'Gabriel Alexander Perez', studentId: '20241006', isPresent: false),
  Attendee(id: '7', name: 'Helena Marisol Cruz', studentId: '20241007', isPresent: false),
  Attendee(id: '8', name: 'Ivan Ricardo Gomez', studentId: '20241008', isPresent: false),
  Attendee(id: '9', name: 'Julia Renata Alvarado', studentId: '20241009', isPresent: false),
  Attendee(id: '10', name: 'Kevin Daniel Reyes', studentId: '20241010', isPresent: false),
  Attendee(id: '11', name: 'Laura Ximena Castillo', studentId: '20241011', isPresent: false),
  Attendee(id: '12', name: 'Mario Andres Gutierrez', studentId: '20241012', isPresent: false),
];
