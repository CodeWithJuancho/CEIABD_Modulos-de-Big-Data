<<<<<<< HEAD
# CE_IABD_BIU_SPS
This repo will contain the course structure for managing and working with GIt during the whole duration of the scholar year.

Test.
=======
# Curso de Especialización en Inteligencia Artificial y Big Data

**Curso 2026–2027 · CIFP Zonzamas**  

Este repositorio reúne los materiales que utilizo y adapto para impartir **Sistemas de Big Data** y **Big Data Aplicado**.

Lo comparto para que otro docente pueda encontrar un punto de partida para sus clases y adaptarlo a su grupo. El alumnado puede utilizarlo para consultar el temario, completar los ejercicios y repasar lo trabajado en el aula.

## Módulos y organización

| Módulo | Carpeta | Orientación general |
| --- | --- | --- |
| **5074 · Sistemas de Big Data** | `SPS/` | Fundamentos, complejidad computacional, pipelines, arquitecturas, procesamiento y valoración de inversiones. |
| **5075 · Big Data Aplicado** | `BIU/` | Datos e información, formatos, preparación, ETL, almacenamiento y análisis con hojas de cálculo y R. |

Los materiales se organizan por **unidades de trabajo (UT)** y sus apartados. También se incluyen recursos comunes sobre Git, organización de proyectos y entornos de procesamiento de datos.

El repositorio se amplía conforme avanza el curso. Cada docente puede seleccionar los recursos publicados y ajustar su secuencia a la programación de su centro.

## Qué encontrarás

- **Presentaciones y lecturas** para preparar las explicaciones y consultar los contenidos.
- **Guiones de trabajo** con objetivos, instrucciones y entregas.
- **Conjuntos de datos** para explorar, transformar y analizar información.
- **Scripts de Python y R y cuadernos Jupyter** para trabajar el código y sus resultados.
- **Materiales de repaso y apoyo** para consolidar lo aprendido.

Conviven plantillas para completar, ejemplos explicados, soluciones y materiales originales adaptados para el aula. Algunos recursos requieren revisar rutas, dependencias o bloques de código antes de utilizarlos en otro entorno.

## Cómo utilizarlo

### Para docentes

1. **Sitúen los contenidos.** Revisen las presentaciones y las lecturas de la unidad que vayan a trabajar.
2. **Seleccionen los materiales.** Comprueben los objetivos, los datos de entrada y las entregas que se piden.
3. **Preparen su versión docente.** Distingan las plantillas de las soluciones y decidan qué archivos facilitarán al alumnado.
4. **Prueben el código.** Completen las partes pendientes y ajusten las rutas y los paquetes necesarios.
5. **Adapten la propuesta.** Ajusten tiempos, apoyos, entregas y criterios de evaluación a su grupo, conservando las referencias de los materiales utilizados.

### Para el alumnado

Sigan el guion que indique el docente y trabajen sobre una copia. Los comentarios `TODO`, los puntos suspensivos y las instrucciones `NotImplementedError` señalan partes que deben completar. Las celdas que lanzan `NotImplementedError` se detendrán hasta que implementen esa parte.

Mantengan los datos junto al ejercicio cuando este lea archivos externos. Ejecuten las celdas de los cuadernos en orden y acompañen los resultados con la interpretación que pida el guion.

## Entorno de trabajo

Las herramientas necesarias dependen del material elegido:

| Tipo de material | Herramientas |
| --- | --- |
| Presentaciones, lecturas y guiones | Lector de PDF y editor compatible con `.pptx` y `.docx`. |
| Datos tabulares | Hoja de cálculo, como Excel o LibreOffice Calc. |
| Python | Python 3.10 o posterior; Jupyter o Google Colab para los `.ipynb`. NumPy y Matplotlib cuando se requieran cálculos y gráficos con estas bibliotecas. |
| R | R y RStudio, con los paquetes indicados en los scripts. |
| Automatización y bases de datos | Bash, Docker, PostgreSQL y `psycopg2`, cuando el trabajo los requiera. |

Las rutas y las dependencias se revisan por recurso. Parte de los ejemplos utiliza únicamente la biblioteca estándar de Python o R base. Las simulaciones introductorias de procesamiento distribuido se ejecutan localmente, sin desplegar un clúster.

Pueden descargar el repositorio desde **Code → Download ZIP** o clonarlo con Git. Los cuadernos `.ipynb` pueden abrirse en Jupyter o subirse a Colab. Cuando haya un proyecto de RStudio, ábranlo para trabajar desde su carpeta y mantener las rutas relativas.

## Autoría y fuentes

**Juan José Sánchez Sánchez · CIFP Zonzamas**  
Organización y adaptación para el aula: **CodeWithJuancho**.

El repositorio combina materiales preparados para estas clases con recursos de referencia de otros autores. Entre las fuentes figuran documentos de la **Universidad de Castilla-La Mancha**, con aportaciones de **Ricardo García Ródenas** y **Julio Alberto López Gómez**. Consulten los créditos y las referencias de cada documento y consérvenlos al adaptar el material.

Actualmente el repositorio no incluye un archivo `LICENSE` con una licencia general de reutilización. Las condiciones de los recursos de terceros deben consultarse en sus fuentes.

## Comunicar errores y proponer adaptaciones

Pueden utilizar las **Issues de GitHub** indicando el módulo, la unidad y el archivo afectado. Si se trata de código, añadan los pasos para reproducir el problema y el mensaje que aparece. Para proponer una adaptación, expliquen qué contenido trabaja y qué necesita para llevarla al aula.

>>>>>>> 43f7cf2a27d52491ad8f4ea4854e5882d730f6b3
