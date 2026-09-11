import '../models/attendee.dart';

/// Datos iniciales del grupo, separados de la capa de presentacion.
///
/// La pantalla solo los usa para poblar la lista por primera vez y
/// para el boton "Reiniciar"; nunca se modifican aqui. Ningun widget
/// de UI construye o conoce esta lista directamente, la reciben ya
/// armada desde el estado de la pantalla.
const List<Attendee> attendeeSeedData = [
  Attendee(id: '1', name: 'Alisson Denisse Quijano Guzmán', studentId: '20245233', isPresent: false),
  Attendee(id: '2', name: 'Melisa Eugenia Rivas Linares', studentId: '20245324', isPresent: false),
  Attendee(id: '3', name: 'Lorena Alejandra Arriola González', studentId: '20245416', isPresent: false),
  Attendee(id: '4', name: 'Christian Odir Renderos Laínez', studentId: '20245266', isPresent: false),
  Attendee(id: '5', name: 'Gabriel Enrique Martínez Carballo', studentId: '20245120', isPresent: false),
];
