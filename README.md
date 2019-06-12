## RappiTestiOS Prueba Hugo Mauricio Jimenez Elizondo

Esta es la version de mi test para Rappi, para poder correr el proyecto es necesario despues de clonar el repositorio abrir la terminal en la raiz del proyecto y ejecutar `pod install` esto es para cargar los pods en el worskpace ya que dentro del .gitignore no se incluyeron esos archivos. 

## Repositorio
  Se utilizo gitHub con una metodologia Git-Flow creando branch de develop para el desarrollo de las implementaciones
  
## Capas de la aplicación
  La estructura de carpetas del proyecto se manejo de la siguiente manera
  # Application
En esta carpeta se encuentran archivos relacionados con la aplicacion como (.plist, AppDelegate) asi como tambien los    archivos utils, esta esta parte del proyecto se agrego la carpeta `UtilsView` en ella se encuentran estilos predeterminados y con colores, tipografia, estilos de botones, vistas, etc esto para optimizar la maquetacion del proyecto
      `UtilsDataManager y RealmUtils`
        En esta parte se maneja la persistencia de datos, por medio del uso de Realm.
        
   # Constants
   Se crea archivos para manejar constantes del proyecto, tales como paths de request, etiquetas para realm mensajes, etc
   # NavUtils
   Nos permite realizar un custom de nuestro navigationBar se configura por cases de un enum
   # BaseViewController
   Es la base de todos nuestros ViewControllers, todos heredan de el y pueden hacer uso de metodos como alertas, toastmessage etc
  # Assets
   En esta carpeta almacena todos los objetos graficos del proyecto
    
  # Modules
   Se utilizo el patrón de diseño VIPER por modulo para la aplicación, segmentando en las siguientes capas
   # View
        ViewContollers y/o vistas .xib
        Interface de view
   # Interactor
        Interfaces de Comunicacion Presenter - interactor
        En esta capa se maneja la logica de negocio
   # Presenter
        Interfaces de comunicacion View - Presenter
   # Entity
        Modelos o structuras del modulo
   # WireFrame ó Route
        Interfaces de comunicacion interactor - wireframe
        Es el encargado de presentar a la vista o hacer push hacia otra
   # DataManager
        interfaces de comunicacion Datamanager - presenter
        la encargada de realizar las peticiones hacia los Servicios Web
      
   ## Preguntas
   # 1.- En qué consiste el principio de responsabilidad única? Cuál es su propósito?
   Establece que cada módulo, clase o función debe tener responsabilidad sobre una sola parte de la funcionalidad provista por la aplicacion, y que la responsabilidad debe estar completamente encapsulada por la clase. pienso que el proposito es tener mejor estructurados nuestros codigos en capas y de esa forma facilitar la programacion asi como el mantenimiento 
   # 2.- Qué características tiene, según su opinión, un “buen” código o código limpio?
   Tener una estructura adecuada, nombres de variables adecuadas, comentarios en funciones complejas, evitar redundancia de codigo, generar extensiones o clases que puedan ser reutilizadas en todo el proyecto, no tener demasiadas lineas de codigo.
      

      
