---
layout: post
title: La arquitectura que nadie necesita
tags:
  - Turbolinks
  - Rails
  - Stimulus
  - Programación
  - Web
---

![](../images/arquitectura.jpg)

- Traducción del artículo: [The Architecture No One Needs](https://gregnavis.com/articles/the-architecture-no-one-needs.html)
- Autor Original: [Greg Navis](https://www.gregnavis.com/)
- Créditos de la imagen: [Aquí](https://www.artuk.org/discover/artworks/trawler-gy174-with-zeppelin-l19-82393)

# La arquitectura que nadie necesita


Las aplicaciones que podemos denominar Single Page Apps (o SPAs) están en pleno auge. Muchas personas elogian sus vagos beneficios técnicos mientras ignora los tremendos costos de desarrollo.

En este artículo discutiremos por qué una SPA es casi siempre peor que una aplicación web tradicional (MPA) y exploraremos brevemente alternativas para lograr beneficios similares pero sin sufrir los costos.

## El negocio del Software

Cada negocio tiene dos partes: ingresos y costos. Si una SPA es una buena inversión, comparada con otras alternativas, depende en cómo esa SPA afecte el resultado final del negocio.

Los ingresos dependen del valor entregado a los usuarios, que en gran parte depende del conjunto de características que se implementan en el software. Las decisiones de arquitectura no proveen valor a los usuarios por sí mismas. La promesa de las SPAs es brindar una mejor experiencia de usuarios que podría trasladarse en mayores costos de desarrollo. Este aumento de costos debe evaluarse para determinar si la inversión realmente vale la pena.

Este artículo intenta probar que el costo de una SPA es excesivo comparado con una aplicación web tradicional principalmente a causa de la complejidad accidental. Lamentablemente, muchas compañías asumen con los ojos cerrados que la experiencia de usuario mejora lo suficiente como para justificar este costo adicional. Otras personas basan sus decisiones en conceptos puramente técnicos sin considerar factores de negocio.

Hay dos puntos claves en este artículo:

1. No considerar una arquitectura SPA a menos que exista una evidencia real de que la experiencia de usuario es el problema más importante de la aplicación, e incluso en ese caso, considerar alternativas. Por ejemplo, si se necesita hacer la aplicación más rápida, entonces se pueden abordar estrategias como afinar la base de datos, implementar cache, utilizar un CDN etc.
2. Una arquitectura de aplicación web tradicional (MPA) es una ventaja competitiva.

Veamos un análisis del costo para comenzar:

## El precio de las SPAs

Las decisiones de arquitectura afectan diferentes aspectos del desarrollo en formas muy variadas. Por ese motivo, he compilado una lista de areas que se afectan negativamente por la incorporación de una arquitectura SPA. Esta lista se puede usar para evaluar el impacto de una SPA tiene o podría tener en tu proyecto.

Pero antes, enfatizaré algo: Una SPA afecta la mayoría de los items en la lista y requiere trabajo adicional para alcanzar capacidades que están presentes en una arquitectura tradicional por omisión.

Esta es la lista, comenzando por los items mas costosos:

### Gestionar datos y estado

Pienso que este es un aspecto subestimado de las SPAs. El software que maneja estado es siempre mucho más difícil de trabajar que cuando no se gestiona estado. El estado del frontend se suele agregar arriba de un backend que cuenta con estado, y que existe con anterioridad. Esto requiere más tiempo de desarrollo, incrementa el riesgo de cometer errores y hace que sea más complejo resolver problemas.

### Testing

Tener que gestionar estado en el frontend incrementa notoriamente la necesidad de crear más casos de prueba a cubrir en los tests, más tiempo para escribirlos y mantenerlos. Adicionalmente, la configuración del escenario de tests es más complicado porque se necesita hacer que el backend y el frontend puedan interactuar entre sí durante las pruebas.

### Rendimiento

Se proclama frecuentemente que las SPA ofrecen una rendimiento superior pero es un poco más complicado de lo que comúnmente se piensa. Un backend que actúa de API genera y envía menos datos que una aplicación web tradicional, pero aún así, la latencia de la red seguirá ahí y la aplicación no irá más rápido que eso. Podemos abordar el problema implementando actualizaciones optimistas pero esto incrementa notoriamente el número de posibles fallos y hace que la aplicación sea mucho más compleja.

### Carga inicial muy lenta

Este es un problema muy conocido pero que no se comprende completamente. El argumento habitual es que después de que el cache del navegador almacenó todos los recursos de la aplicación va a funcionar rápido. Aquí se asume implícitamente que dejaríamos de desarrollar y actualizar esos paquete de recursos. Si hiciéramos eso entonces los usuarios experimentarían esa carga inicial muy lenta una sola vez.

### Autenticación

Si bien esto es opcional para una SPA, parece que JWT es una de las opciones más elegidas a la hora de implementar autenticación. El beneficio que se proclama es de "stateless". Esto es cierto, pero tiene una desventaja grande: no podemos invalidad las sesiones, a menos que podamos identificarlas en el backend, lo que hace que el sistema entero tenga estado y deje de ser "stateless". Pienso que siempre debemos ser capaces de invalidar sesiones. Por lo tanto, como vamos a necesitar estado del lado del servidor podemos utilizar tokens al portador. Son mas simples de entender, implementar y depurar.

### Información de la sesión

Al igual que lo anterior, esto también es opcional aunque las SPA generalmente utilizan localStorage en lugar de cookies. Esto tiene una desventaja y es que no tiene un mecanismo similar a las cookies HTTP-only. Estas aplicaciones generalmente incluyen scripts de dominios de terceros y CDNs que si sufren un ataque podrían ganar acceso a IDs de sesión u otros secretos.

### Actualizaciones de estado

Ilustremos esto con un ejemplo: Estamos construyendo un sitio de comercio que tiene una lista de categorías. Necesitamos actualizar esa lista de categorías de vez en cuando. En una aplicación web tradicional, la lista se actualiza con cada visita a una página nueva. En una SPA no sucede lo mismo, necesitamos pensar en un algoritmo e implementarlo para cargar las categorías nuevas. No es algo complejo, pero lleva algo de trabajo adicional que a los usuarios no les importará.

### Manejo de errores

Una aplicación tradicional emite una página con código de error 500 y eso es todo. En cambio, una SPA necesita detectar errores en el código del cliente y luego actualizar la interface de usuario acordemente. Nuevamente, se requiere mucho trabajo para recuperar lo que una aplicación tradicional hacía por omisión.

### Renderización del lado del servidor

Necesitamos que el servidor sea capaz de producir HTML para que los usuarios puedan descubrir la aplicación desde buscadores o compartiendo links en redes sociales. Esta es otra tarea en donde necesitas trabajar para alcanzar la misma funcional que incluye por omisión una aplicación web tradicional.

### Protocolos y serialización

En una arquitectura tradicional, simplemente enviamos los modelos a una vista y publicamos los atributos que necesitamos. Este no es el caso en una SPA. En una SPA necesitamos implementar formatos de datos e implementar algún tipo de serialización. Naturalmente, existen herramientas que pueden ayudar, pero eso requiere trabajo adicional y vincular dependencias que solo intentan recuperar lo que una arquitectura tradicional puede hacer.

### Herramientas

Nuestro sistema de compilación se puede volver más complicado a causa de las herramientas y dependencias que se necesitan para construir una SPA.

### Metadatos compartidos

Podríamos necesitar compartir la estructura de datos entre el frontend y el backend. Por ejemplo, si la SPA consume una API Rest nos gustaría que la información relacionada se pueda obtener desde la misma fuente. De nuevo, esto es innecesario en una arquitectura tradicional.



Si miramos la arquitectura SPA desde una perspectiva de negocios, tus costos van a elevarse pero no vas a ver un incremento de tus ingresos porque a los usuarios no les importan las decisiones técnicas. El resultado es un retorno negativo de la inversión.

## ¿Qué hacer en lugar de una SPA?

Mi consejo es simple: Si duele entonces dejá de hacerlo. O incluso mejor: no comiences a hacerlo en primer lugar.

Una aplicación web tradicional es mucho más simple de implementar y tiene muchas ventajas que solo se pueden replicar en una SPA a un costo muy alto. Naturalmente, a veces es inevitable abordar componentes más complejos, pero aún así existen enfoques más sencillos para elaborarlos.

Primero, comienza a utilizar [Turbolinks](<https://github.com/turbolinks/turbolinks>). Hace que la aplicación se vea mucho más ligera sin inyectar un montón de complejidad accidental. Generalmente se asocia con Ruby on Rails sin embargo se puede usar de manera independiente en otras tecnologías.

Luego, usa [Stimulus.js](<https://stimulusjs.org/>) para componentes simples. Es un desarrollo relativamente nuevo pero tuve la posibilidad de implementar una docena de controladores en stimulus y la experiencia es estupenda.

Tercero, si estás implementando un componente realmente complicado podrías usar [React](<https://reactjs.org/>) solo para ese componente. Por ejemplo, si estás construyendo una caja de texto para un sistema de chat no hay necesidad de implementar la página de login usando React. Lo mismo aplica para [Vue.js](<https://vuejs.org/>) y el resto de las cosas.

## Resumen

Las aplicaciones SPA son mucho más costosas de elaborar que una aplicación web tradicional. En la mayoría de los casos, no existe un motivo de negocios para elegir esa arquitectura. El desafío real es tratar de abordar los problemas de manera simple sin sufrir el costo y la complejidad excesiva. Hay casos en donde una SPA tiene sentido, pero ese es un tema para otro artículo.
