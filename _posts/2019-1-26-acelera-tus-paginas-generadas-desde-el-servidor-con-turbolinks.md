---
layout: post
title: Acelerá tus páginas generadas del lado del servidor con Turbolinks
tags:
  - Turbolinks
  - Programación
  - Web
---

![](../images/turbolinks.jpg)

> Traducción del artículo:
> https://medium.com/@bonfirealgorithm/spa-like-responsiveness-with-turbolinks-2657d0f013e0

[Turbolinks](https://github.com/turbolinks/turbolinks) es una biblioteca
JavaScript que hace más rápida la navegación en una aplicación web. Se puede
usar para acelerar la navegación entre páginas, entre sub secciones o incluso
redirecciones y envío de formularios. Puede darle a tus aplicaciones web la
velocidad de respuesta de una aplicación SPA pero manteniendo el mecanismo de
generación de HTML del lado del servidor. En otras palabras, podes desarrollar
la aplicación completa usando un framework como Django o Rails y hacer que se
perciba como una SPA.

## El problema con las páginas generadas del lado del servidor

Cuando el HTML se genera del lado del servidor, el navegador necesita
reconstruir todo el DOM, procesar CSS y el código JavaScript por cada página que
se quiere navegar. Incluso si el tiempo de respuesta de tu servidor es muy
bueno, digamos por debajo de los 50 milisegundos, lo que toma tiempo es procesar
toda la página desde cero, generalmente de 1/2 a 1 segundo. Esta demora es
suficiente para que el usuario no perciba a la aplicación que genera html del
lado del servidor tan rápida como una SPA. Las aplicaciones SPA logran rapidez
solicitando solamente datos a través de AJAX y actualizando solamente partes del
DOM.

## Turbolinks al rescate

Turbolinks utiliza un truco para mostrar la página en el navegador. Cuando se
intenta enviar una solicitud al servidor, por ejemplo cuando el usuario hace
click en un link o emite un formulario, turbolinks intercepta la petición,
previene que el navegador la procese tradicionalmente y en su lugar solicita la
página nueva usando XMLHttpRequest de forma asincrónica. Cuando el servidor
retorna el contenido HTML turbolinks intercambia el body del HTML actual con el
contenido nuevo. En la última versión de Turbolinks también se pueden realizar
actualizaciones parciales, de forma que solo se actualicen partes del HTML.

## Reducción de la complejidad y un desarrollo más simple

Generar todo el HTML del lado del servidor reduce la complejidad y hace que el
desarrollo sea mas simple y rápido. Esta es una ventaja no solo para los
desarrolladores solitarios o los equipos pequeños. En lugar de usar Rails,
Sprint o Django para realizar una API y un frontend como Angular, React o Vue,
con Turbolinks solo se necesita un solo framework. Además, no se requiere
duplicar estructuras de datos o lógicas de validaciones en el frontend y el
backend. El resultado de usar un solo Framework es menos complejidad, menos
código para mantener, menos deuda técnica y un desarrollo más rápido.

## ¿Cómo lo puedo obtener?

Turbolinks viene instalado y habilitado en cada link junto a Rails 5. También se
puede agregar fácilmente a los formularios para agilizarlos. Funciona bastante
bien desde el primer momento.

En otros frameworks se necesita agregar Turbolinks manualmente. Todo lo que se
necesita es incluirlo en la sección HEAD de tu plantilla principal y a partir de
ahí comenzará a interceptar los links para acelerar la navegación. Y para que
funcione en los formularios se necesita interceptar la emisión de los
formularios con JavaScript y enviarlos como una solicitud AJAX. Generalmente
también se necesita agregar un middleware para que funcione con redirecciones,
varios frameworks tienen complementos para facilitar este proceso.

## Conclusión

Turbolinks es un interesante punto medio entre paginas estrictamente generadas
del lado del servidor y SPA realmente completas. Otras bibliotecas, como
[Unpoly](https://unpoly.com/) e [Intercooler](http://intercoolerjs.org/),
ofrecen la misma funcionalidad e incluso la llevan más allá. Me gusta la
simplicidad y discreción de Turbolinks. La exageración alrededor de las SPA
lleva varios años y permanece fuerte al día de hoy. Turbolinks y las bibliotecas
similares ofrecen una alternativa muy prometedora en donde se puede obtener
muchos de los beneficios de una SPA sin toda la complejidad adicional.
