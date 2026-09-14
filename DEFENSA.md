# Defensa 

## Integrantes de laboratorio
- Alisson Denisse Quijano Guzmán - 20245233
- Melisa Eugenia Rivas Linares - 20245324
- Lorena Alejandra Arriola González - 20245416
- Christian Odir Renderos Laínez - 20245266
- Gabriel Enrique Martínez Carballo - 20245120

## 1. Decisión sobre el estado

El estado, es decir la lista de asistentes junto con la marca de quien está
presente, vive en la clase privada de estado que acompaña a la única
pantalla con estado de la aplicación, la que administra todo el flujo de
asistencia.

Se decidió ponerlo ahí porque esa pantalla es el ancestro común de todos los
widgets que necesitan leer o modificar esos datos. La cabecera necesita
saber cuántos están presentes. La lista necesita cada registro individual y los botones de acción necesitan modificar todos los registros a la vez.
Al mantener el estado en un solo lugar hay una única fuente de verdad y una
sola actualización de estado reconstruye exactamente lo que depende de esos
datos.

Si el estado viviera en otro lugar, por ejemplo si cada fila de la lista
guardara su propia marca de presencia como estado local en lugar de
recibirla desde afuera, pasarían dos cosas concretas. Primero, la cabecera
no podría saber cuántos están presentes porque un widget hijo no puede
empujar datos hacia arriba sin que exista un mecanismo explícito para
avisarle al padre. Segundo, los botones de marcar a todos presentes y de
reiniciar no tendrían forma directa de tocar el estado interno de doce
widgets independientes sin recurrir a una referencia manual por cada fila,
lo cual en la práctica vuelve a requerir subir el estado al mismo lugar
donde ya está. Es decir, descentralizarlo no elimina la necesidad de un
dueño único, solo la oculta y complica el código.

## 2. Efecto de actualizar un registro

Cuando se cambia el estado de un registro, se dispara una actualización de
estado dentro de la clase de estado de la pantalla. Eso marca la pantalla
como pendiente de redibujar y hace que Flutter vuelva a ejecutar su función
de construcción en el siguiente frame. Eso significa que se reconstruye la
cabecera y también cada fila que esté montada en el árbol, porque todas son
hijas, directas o indirectas, del widget que disparó el cambio.

Para no pagar más costo del necesario, se tomaron dos medidas. Cada fila dentro de la lista recibe una identidad propia basada en el
identificador del asistente que representa. Eso permite que Flutter
empareje correctamente cada elemento visual con el registro que le
corresponde entre una reconstrucción y la siguiente, en vez de reciclar
elementos por posición, evitando así reconstrucciones o pérdidas de estado
incorrectas si el orden llegara a cambiar.

Además, las partes que no dependen de los datos, como los iconos fijos, los
espacios en blanco y los márgenes de los botones de acción, están
declaradas de forma que Flutter puede reutilizarlas sin volver a crearlas.
Un widget marcado de esa manera no se vuelve a instanciar entre
reconstrucciones. Flutter compara la referencia del widget nuevo contra la
anterior y, al ser idéntica, se salta el trabajo de reconstruir ese
subárbol. Por eso las reglas de análisis estático del proyecto exigen
marcar así todo lo que califica. Esto no cambia cuántas veces se llama a la
función de construcción en la pantalla, pero sí reduce el trabajo real
dentro de cada reconstrucción.

## 3. Decisión sobre el componente extraído

Se extrajo la fila de la lista a su propia clase sin estado, además de la
cabecera como componente adicional. El criterio para elegir la fila fue que
es la unidad que se repite una vez por cada asistente, tiene entradas bien
definidas (un registro y una función de aviso cuando se toca) y no necesita
ver el resto del estado de la pantalla para hacer su trabajo. Eso la vuelve
el límite natural entre la lógica de la pantalla y la forma en que se
dibuja una fila.

Si en vez de una clase se hubiera usado un método privado dentro de la
clase de estado de la pantalla, el número de veces que se reconstruye no
cambia, pero se pierden tres cosas. Primero, el método queda atado a esa
instancia de estado y tienta a leer la lista de asistentes directamente
desde afuera en vez de recibir los datos de forma explícita por parámetro,
lo cual erosiona la regla de tener un solo lugar para el estado. Segundo,
un método no puede declararse ni beneficiarse como widget reutilizable de
la forma en que sí puede hacerlo una clase, así que se pierde la
posibilidad de que Flutter salte su reconstrucción cuando sus datos no
cambiaron. Tercero, una clase se puede probar de forma aislada con una
prueba propia y reutilizar en otra pantalla, mientras que un método privado
solo existe dentro de esa clase de estado y no se puede instanciar ni
probar por separado.
