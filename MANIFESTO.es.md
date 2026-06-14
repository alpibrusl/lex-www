# Confianza Sin Comprensión

*El caso por herramientas diseñadas para la IA, no adaptadas de los humanos*

*Alfonso Sastre — 25 de mayo de 2026*

---

## I. La Forma de una Herramienta

Toda herramienta lleva consigo los supuestos de quien la fabricó. El martillo asume una muñeca. El teclado asume diez dedos y la capacidad de mantener un pensamiento el tiempo suficiente para escribirlo. La hoja de cálculo asume una mente capaz de sostener una cuadrícula y navegarla celda a celda. Estas restricciones no son errores — son el reconocimiento honesto de que las herramientas son hechas por humanos, para humanos, moldeadas en torno a la percepción y la memoria humanas.

Ahora estamos construyendo agentes capaces de razonar, escribir, planificar y actuar. Y casi sin excepción, les estamos dando herramientas humanas.

Este es el error central del momento. No un error en ningún producto o artículo en particular — un error estructural en cómo estamos planteando el problema. Estamos pidiendo a los agentes que sean humanos muy rápidos, cuando podrían ser algo completamente distinto.

---

## II. Sobre los Hombros de Gigantes

Isaac Newton, escribiendo a Robert Hooke en 1675, dijo: *"Si he visto más lejos, es porque me he subido a hombros de gigantes."* La frase se lee a menudo como un acto de humildad. Es también una declaración sobre cómo se acumula el conocimiento — cada generación hereda la estructura acumulada de la anterior y la amplía, en lugar de reconstruirla desde cero.

Las herramientas que entregamos a los agentes son esos gigantes. Python, Git, SQL, Jira, Figma — décadas de pensamiento cuidadoso sobre cómo hacer que el cómputo y la coordinación sean manejables para los seres humanos. Merecen respeto. Son logros extraordinarios.

Pero heredar una herramienta no es lo mismo que ser su usuario natural. Newton heredó las observaciones de Galileo y las leyes de Kepler. No heredó el telescopio de Galileo — construyó uno mejor, adecuado a lo que quería ver.

La pregunta no es si las herramientas humanas son buenas. La pregunta es: *¿qué herramienta construirías si el usuario no tuviera manos, no tuviera una atención corporal, no necesitara azúcar sintáctico, y pudiera sostener mil restricciones simultáneamente dentro de una sola tarea sin olvidar ninguna?*

---

## III. El Desajuste

Consideremos lo que pedimos a los agentes en el dominio del software.

Les pedimos que escriban en lenguajes con décadas de sintaxis acumulada para la legibilidad humana — sangría, palabras clave con nombre, precedencia de operadores implícita, convenciones liberales de espacios en blanco. Les pedimos que gestionen el control de versiones mediante diffs por líneas, donde la unidad de identidad es una línea de texto en lugar de una unidad de significado con nombre, tipada y semánticamente estable. Les pedimos que naveguen bases de código de millones de líneas, la mayoría de las cuales no responden ninguna pregunta que el agente necesite hacer. Un diff semántico que dice *"el tipo de `fn execute` cambió de `[io] → Result[A, B]` a `[io, net] → Result[A, B]`"* le dice algo a un agente. Un diff que dice *"la línea 47 cambió"* le dice algo a un humano. Les damos el segundo.

Les pedimos que lean la base de código completa para construir un modelo mental que desecharán al final de la conversación y reconstruirán desde cero en la siguiente llamada. Los humanos construimos modelos mentales porque lo necesitamos — no podemos retener la estructura de un sistema de un millón de líneas en la memoria de trabajo de una vez, y el modelo amortiza el coste de la comprensión a lo largo de las sesiones. Un agente no tiene memoria de trabajo entre sesiones. Cada conversación es la primera. La interfaz correcta para un agente no es una base de código que leer, sino un contrato que satisfacer.

Les pedimos, sobre todo, que confíen en sí mismos a través de la comprensión. Leer el código. Entender la especificación. Interpretar el brief. Pero la comprensión es una *estrategia humana* para construir confianza en presencia de ambigüedad. No es la única estrategia. Y para un agente — rápido, incansable, pero sin memoria continua y propenso a las alucinaciones con confianza — ni siquiera es la mejor.

---

## IV. Confianza Sin Comprensión

**La tesis de este ensayo es que la comprensión no es la única base para la confianza, y que las herramientas nativas para agentes deberían diseñarse en torno a una diferente: la verificación.**

Por *comprensión* entiendo específicamente el requisito de que un humano lea y simule mentalmente un sistema para poder responder por él. La comprensión conceptual de lo que hace el sistema y por qué sigue siendo esencial; lo que cambia es si esa validación interpretativa línea a línea es el sustrato sobre el que se construye la confianza mecánica.

La pregunta correcta no es *"¿cómo hacemos Python mejor para los agentes?"* Es: si estuvieras diseñando un lenguaje de programación para un agente — no para que un humano lo escriba, no para que un humano lo lea, sino para que un agente lo genere y lo verifique — ¿qué conservarías y qué descartarías?

Conservarías los tipos, porque los tipos son restricciones verificables por máquina. Conservarías las estructuras de datos algebraicas, porque hacen que los estados ilegales sean no representables. Conservarías los efectos, no como convención de documentación sino como declaración formal: esta función puede tocar la red; esta otra no puede. Un agente que genera una función con una fila de efectos `[net]` no necesita leer el cuerpo de la función para saber que toca la red. El sistema de tipos se lo dice. El sistema de tipos se lo dice al llamador. **Confianza sin comprensión.**

Descartarías el control de versiones por líneas, porque las líneas son un formato de serialización humano. La unidad significativa de un programa no es una línea — es una función, un tipo, un módulo. Nodos AST direccionados por contenido, identidades estables a través de reformateos, versionado semántico de funciones no de archivos — estas son las primitivas del control de versiones diseñado para un agente.

Descartarías las grandes bases de código como unidad de especificación. La interfaz correcta para un agente es una especificación formal pequeña — una firma de tipo, un conjunto de ejemplos, un conjunto de propiedades — a partir de la cual puede generar una implementación correcta. No una implementación de referencia que imitar, sino un contrato que satisfacer.

Y añadirías **atestación**. No revisión — atestación. Un agente puede generar código; un verificador de tipos puede verificarlo; un arnés de pruebas puede ejecutarlo; un sandbox puede ejecutarlo con efectos restringidos; un log de solo adición puede registrar exactamente lo que sucedió, firmado, direccionado por contenido, a prueba de manipulaciones. Esta cadena no se comprende — se verifica, en cada eslabón.

El sustrato no es hostil a los humanos. Soporta proyecciones — vistas de código fuente legibles, resúmenes narrativos, diffs en estilo de línea — derivadas de la misma forma canónica. Lo que cambia es qué representación soporta el peso de la confianza.

---

## V. La Objeción Obvia

La respuesta refleja a "confianza sin comprensión" es: *pero alguien todavía tiene que entender el sistema cuando falla.* Cuando un regulador pregunta por qué se tomó una decisión automatizada, cuando un ingeniero recibe una alerta a las 3 de la madrugada, cuando un cliente exige responsabilidad — "el verificador de tipos dijo que estaba bien" no es una respuesta suficiente.

Esta es la objeción más fuerte a todo el planteamiento, y merece una respuesta directa.

Es correcto que los humanos tengan responsabilidad residual, y esa responsabilidad no puede delegarse únicamente a la maquinaria. Pero nótese lo que la objeción realmente pide. No pide que el humano *re-derive* el comportamiento del sistema desde los primeros principios. Pide que el humano pueda *auditar* el sistema después del hecho: cuál fue la entrada, cuál fue la salida, qué restricciones se verificaron, qué efectos se declararon, qué se registró.

La confianza basada en comprensión requiere que el humano mantenga todo el sistema en su cabeza, de antemano, para poder responder por él. La confianza basada en verificación requiere que el humano mantenga las *restricciones* del sistema en su cabeza — la especificación, el conjunto de efectos, la política — y confíe en las herramientas para hacerlas cumplir. La superficie de auditoría es menor. La revisión es más precisa. El humano interviene donde su juicio importa: en la especificación, la política, la traza — no en cada línea de cada cuerpo de función.

Esto no es la abolición de la supervisión humana. Es la reubicación de la supervisión humana hacia la capa donde realmente aporta valor, y la delegación del resto a mecanismos que escalan.

La verificación escala limpiamente para propiedades formales — tipos, efectos, capacidades, invariantes. Escala parcialmente para comportamientos comprobables, donde propiedades y ejemplos bien elegidos pueden sustituir a una especificación completa. Escala mal para propiedades estéticas o intencionales, donde el juicio humano sigue siendo el único oráculo disponible. El argumento aquí no es que la verificación reemplace el juicio en todas partes — solo que debería reemplazar la comprensión donde pueda, para que el juicio se reserve para las preguntas que solo los humanos pueden responder.

El paradigma actual pide a los humanos que comprendan todo y no confíen en nada. El paradigma nativo para agentes pide a los humanos que especifiquen lo que importa y verifiquen que se cumple. El primero es agotador e imposible a la escala a la que los agentes empiezan a operar. El segundo es como funciona ya toda disciplina de ingeniería madura — los ingenieros civiles no verifican personalmente cada remache; especifican la carga y confían en la cadena de certificación.

---

## VI. Un Ejemplo Concreto

El argumento anterior es conceptual. Aquí hay un artefacto concreto.

Construí `lex-code`, un asistente de código IA escrito íntegramente en Lex — un lenguaje de programación diseñado bajo la disciplina de este ensayo. Los prompts de sistema para cada modo de agente (build, spec, test, review) son de unas cinco líneas de Lex cada uno. El agente que generó la implementación trabajó a partir de una referencia compacta del lenguaje y la descripción del rol — sin base de código Lex existente que imitar, sin ejemplos idiomáticos más allá de lo que la propia referencia contenía.

El orquestador gestiona la ejecución paralela multi-agente con concurrencia tipada por efectos. Una firma se lee así:

```
fn run_parallel(...) -> [env, concurrent, net, llm, io, proc, sql, fs_write, time] MultiResult
```

El agente dedujo esa firma a partir de la especificación, no de los datos de entrenamiento. Compuso correctamente las filas de efectos a través de sub-agentes paralelos. Propagó `Result` y `Option` a través de cada camino de error. Distinguió construcción-como-dato (la definición del agente) de ejecución-como-efecto (la invocación del agente), sin que se lo indicaran.

Esto es lo que *"diseñado para que un agente lo genere"* significa en la práctica: el sustrato lleva las restricciones; el modelo rellena los cuerpos; el sistema de tipos verifica el resultado. No se confía en el modelo porque se comprendió. Se confía en él porque lo que produjo fue verificado — por el verificador de tipos, por el verificador de especificaciones, por la puerta de capacidades, por la traza. **Confianza sin comprensión, de extremo a extremo.**

El artefacto no es el punto. El punto es que el artefacto existe, fue producido bajo la disciplina que describe el ensayo, y se comporta como el ensayo predice. El sustrato hizo el trabajo.

---

## VII. Más Allá del Código

El argumento se generaliza más allá de los lenguajes de programación, aunque no desarrollaré ese caso completo aquí. Brevemente:

Todo dominio del trabajo intelectual humano se ha organizado en torno a las restricciones cognitivas humanas. El sprint dura dos semanas porque la atención humana no puede sostener ciclos más largos sin un punto de control visible. El brief de marketing es un documento porque los humanos necesitan narrativa para coordinarse frente a la ambigüedad. La hoja de ruta del producto es una presentación porque los humanos necesitan jerarquía visual para establecer prioridades. Ninguna de estas restricciones se aplica a los agentes.

El principio tiene la misma forma en todos los dominios: reemplazar la **comprensión** por la **verificación**, reemplazar los **artefactos legibles por humanos** por **especificaciones verificables por máquina**, reemplazar la **coordinación por reunión** por la **coordinación por protocolo**. En código, eso significa tipos, atestación e identidad direccionada por contenido. En revisión de contratos, significaría representaciones formales de obligaciones que un agente puede verificar en lugar de prosa legal que un socio tiene que leer. En cumplimiento normativo, significaría políticas expresadas como restricciones ejecutables en lugar de PDFs interpretados por equipos de auditoría. En diseño experimental, significaría protocolos preregistrados que un agente puede validar en lugar de secciones de métodos que los humanos deben aceptar en buena fe.

Lo que permanece constante en todo esto es lo que *no* cambia: los humanos siguen fijando los objetivos, los humanos siguen asumiendo la responsabilidad, los humanos siguen decidiendo qué vale la pena verificar. El principio no desplaza el juicio humano. Reubica la superficie sobre la que se ejerce el juicio — de comprender el sistema a especificar lo que el sistema debe hacer.

Hay un pari más profundo debajo de este: que más de la coordinación humana puede expresarse como restricciones, protocolos y especificaciones verificables por máquina de lo que la práctica actual supone. Esa es la afirmación controvertida, y el argumento para ella es materia de otro ensayo.

El propósito de este es más modesto: que el principio es sólido, que el ejemplo concreto existe, y que el movimiento es el mismo allí donde un agente se encuentra con un sustrato construido para otra persona.

---

## VIII. La División del Trabajo

Nada de esto es un argumento contra los humanos. Es un argumento por una separación más clara de responsabilidades.

**Los humanos fijan los objetivos.** Los humanos deciden qué vale la pena construir y por qué. Los humanos asumen la responsabilidad de las consecuencias. Estas no son tareas a automatizar — son tareas que requieren el tipo particular de peso moral que solo una persona puede cargar.

**Los agentes ejecutan.** Los agentes generan, verifican, componen, prueban, despliegan, monitorizan. Estas son tareas donde las restricciones cognitivas humanas — memoria de trabajo, tiempo de atención, necesidad de sintaxis legible, tolerancia a los diffs por líneas — son fricción, no funcionalidades.

La transición requiere nuevas primitivas. Lenguajes cuyas especificaciones caben en una gramática formal compacta, no en un manual de referencia de mil páginas. Control de versiones que opera sobre unidades semánticas, no líneas de texto. Formatos de especificación verificables por máquina, no interpretados por humanos. Sistemas de atestación que producen confianza sin requerir comprensión en cada paso. Protocolos de orquestación que los agentes pueden razonar de forma nativa, no parseando APIs orientadas a humanos.

Algunos de estos existen en forma embrionaria. El campo del tooling nativo para agentes está aproximadamente donde estaban los sistemas operativos en 1970: las ideas son incipientes, las implementaciones son rudimentarias, la comunidad es pequeña. La oportunidad es proporcional.

---

## IX. La Apuesta

El momento actual es una apuesta.

Una apuesta consiste en que la estrategia correcta es mejorar progresivamente las herramientas humanas existentes para los agentes — mejores ventanas de contexto, mejor recuperación de información, mejor ingeniería de prompts, mejor ajuste fino en bases de código existentes. Esta apuesta dice que la forma de la herramienta está bien; el agente simplemente necesita mejorar para usarla.

La otra apuesta es que **la forma de la herramienta importa**. Que hay capacidades — en generación de código, en acción coordinada a través de sistemas complejos — que no son alcanzables por un agente que usa un martillo, por muy capaz que se vuelva el agente. Que el movimiento correcto no es entrenar a los agentes para leer mejor el historial de Git, sino darles un control de versiones que nunca fue diseñado en torno a la legibilidad humana.

La segunda apuesta es más difícil. Requiere construir nueva infraestructura en lugar de instrumentar la existente. Requiere convencer a comunidades construidas en torno a herramientas humanas de que las herramientas en sí mismas, no sus usuarios, son la variable que hay que cambiar. Requiere aceptar un período en que las nuevas herramientas son inmaduras — un valle entre *"herramientas humanas, usadas por la IA"* y *"herramientas nativas para agentes, lo suficientemente maduras como para confiar en ellas."*

Pero la segunda apuesta es también la que es coherente con la naturaleza real del cambio. Los agentes no son humanos más rápidos. Tienen fortalezas diferentes, modos de fallo diferentes, requisitos diferentes para la confianza y la verificación. Darles herramientas diseñadas para la cognición humana no es una elección neutral — es la elección de dejar la mayor parte de su potencial sin explotar, y de pedir a los humanos que comprendan a una escala que la comprensión ya no puede alcanzar.

Estamos sobre los hombros de gigantes. Ahora construimos la siguiente capa — no contra lo que los gigantes construyeron, sino para un escritor diferente, un lector diferente, una base diferente para la confianza.

*La comprensión era una estrategia. No es la única.*
