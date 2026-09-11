# Defensa tecnica

## 1. Decision sobre el estado

El estado (la lista de asistentes con su bandera `isPresent`) vive en
`_AttendanceScreenState`, la clase privada de estado de `AttendanceScreen`,
que es el unico `StatefulWidget` de la app.

Se decidio ahi porque `AttendanceScreen` es el ancestro comun de todos los
widgets que necesitan leer o modificar ese estado: la cabecera (necesita el
conteo de presentes), la lista (necesita cada registro) y los botones de
accion (necesitan modificar todos los registros a la vez). Con el estado en
un solo lugar hay una unica fuente de verdad y un solo `setState` reconstruye
exactamente lo que depende de esos datos.

Si el estado viviera en otro lugar, por ejemplo si cada `AttendeeTile`
guardara su propio `isPresent` como estado local en vez de recibirlo por
constructor, pasarian dos cosas concretas: (1) la cabecera no podria saber
cuantos estan presentes, porque un widget hijo no puede empujar datos hacia
arriba sin un callback explicito, y (2) los botones "Todos presentes" y
"Reiniciar" no tendrian forma directa de tocar el estado interno de doce
widgets independientes sin recurrir a `GlobalKey` por cada fila, lo cual
vuelve a requerir, en la practica, subir el estado al mismo lugar donde ya
esta. Es decir, descentralizarlo no elimina la necesidad de un dueno unico,
solo la oculta y complica el codigo.

## 2. Efecto de actualizar un registro

Cuando se togglea un registro, `setState` se llama en
`_AttendanceScreenState`, lo que marca ese `State` como "dirty" y hace que
Flutter vuelva a ejecutar su `build()` en el siguiente frame. Eso significa
que se re-ejecuta el `build()` de `AttendanceHeader` y de cada `AttendeeTile`
que esta montado en el arbol, porque todos son hijos, directos o indirectos,
del widget que llamo a `setState`.

Para no pagar mas costo del necesario que ese, se tomaron dos medidas:

- Cada `AttendeeTile` en el `ListView.builder` recibe
  `key: ValueKey(attendee.id)`. Eso permite que Flutter empareje
  correctamente cada `Element` con el registro que le corresponde entre un
  build y el siguiente, en vez de reciclar elementos por posicion, evitando
  reconstrucciones o perdidas de estado incorrectas si el orden cambiara.
- Las partes que no dependen de los datos (`Icon`, `SizedBox`, `EdgeInsets`,
  los botones de accion, etc.) estan declaradas como `const`. Un widget
  `const` no se vuelve a instanciar entre builds: Flutter compara la
  referencia del widget nuevo contra la anterior y, al ser identica, se salta
  el trabajo de reconstruir ese subarbol. Por eso `flutter analyze` con
  `flutter_lints` exige `const` en todo lo que califica: no cambia cuantas
  veces se llama `build()` en la pantalla, pero si reduce el trabajo real
  dentro de cada rebuild.

## 3. Decision sobre el componente extraido

Se extrajo `AttendeeTile` (la fila de la lista) a su propia clase
`StatelessWidget`, ademas de `AttendanceHeader` como extra. El criterio para
elegir `AttendeeTile` fue que es la unidad que se repite N veces (una por
asistente), tiene entradas bien definidas (un `Attendee` y un callback
`onToggle`) y no necesita ver el resto del estado de la pantalla para hacer
su trabajo: eso la vuelve el limite natural entre "logica de la pantalla" y
"como se dibuja una fila".

Si en vez de una clase se hubiera usado un metodo privado dentro de
`_AttendanceScreenState` (por ejemplo `Widget _buildTile(Attendee a)`), el
numero de veces que se reconstruye no cambia, pero se pierden tres cosas:
primero, el metodo queda atado a esa instancia de `State` y tienta a leer
`_attendees` directamente por closure en vez de recibir datos explicitos por
parametro, lo cual erosiona la regla de "un solo lugar para el estado";
segundo, un metodo no puede declararse ni beneficiarse como widget `const`,
asi que se pierde la posibilidad de que Flutter salte su reconstruccion
cuando sus datos no cambiaron; y tercero, una clase se puede probar aislada
con un widget test propio y reutilizar en otra pantalla, mientras que un
metodo privado solo existe dentro de esa State y no se puede instanciar ni
testear por separado.
