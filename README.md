# Laboratorio 1 - Clase 9: lista de asistencia

App de Flutter con una sola pantalla que registra la asistencia de un grupo:
lista dinamica con `ListView.builder`, estado local centralizado en un
`StatefulWidget`, y acciones para marcar a todos presentes o reiniciar.

## Integrantes de laboratorio
- Alisson Denisse Quijano Guzmán - 20245233
- Melisa Eugenia Rivas Linares - 20245324
- Lorena Alejandra Arriola González - 20245416
- Christian Odir Renderos Laínez - 20245266
- Gabriel Enrique Martínez Carballo - 20245120

## Como correrlo

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

## Estructura

```
lib/
  models/attendee.dart          Modelo inmutable de un registro
  data/attendee_seed_data.dart  Datos iniciales (12 registros), fuera de la UI
  widgets/attendance_header.dart  Cabecera fija (grupo + contador)
  widgets/attendee_tile.dart      Fila individual de la lista
  screens/attendance_screen.dart  Unica pantalla, dueña de todo el estado
  main.dart                       Entry point
test/
  attendance_screen_test.dart     Widget test del flujo principal
DEFENSA.md                        Sustentacion tecnica requerida
```

## Alcance

No incluye persistencia, navegacion entre pantallas ni servicios externos,
tal como pide el enunciado.
