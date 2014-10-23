using Gee;
using GraphMedia.Modelos;


namespace GraphMedia {

		/**
		* Clase que crea un generador para hacer objetos que sirvan 
		* para las pruebas unitarias y no invertir tiempo en generar registros
		* falsos, incluso podria ocuparse para llenar la mayoria de las tablas.
		*/
		public class Generador : Object {
 			
 			private int LIMITE_PALABRAS = 500;
 			private int TOTAL_PALABRAS = 0;
 			private string[] diccionario;

 			public Generador(string ruta_diccionario) {
 				diccionario = new string[LIMITE_PALABRAS];
 				FileStream stream = FileStream.open (ruta_diccionario, "r");

 				assert(stream != null);

 				string? line = null;

 				int i = 0;
 				/* llenamos el diccionario mientras tenga palabras */
 				while ((line = stream.read_line ()) != null || diccionario.length < LIMITE_PALABRAS) {
					if ( line != null) {
						string [] palabras  = line.split(" - ");
						foreach (string s in palabras) {
							if (s.length >= 3)
								diccionario[i++] = s.split(".")[0];
						}
					}
 				}

				TOTAL_PALABRAS = i;
			}

			/** @return palabra, una palabra aleatoria sacada del diccionario de palabras */
			public string palabra_aleatoria() {
				int i = Random.int_range (0, TOTAL_PALABRAS);
				return diccionario[i];
			}

			/** @return ruta, devulve una ubicación falsa de algun archivo */
			public string ruta_aleatoria(int longitud = 3) {
				string ruta = "";

				for (int i = 0; i < longitud; i++ ) {
					ruta += palabra_aleatoria();
					ruta += (i < longitud -1) ? "/" : "";
				}

				return ruta;
			}

			/** @return nombre, algun nombre aleatorio de una longitud dada */
			public string nombre_aleatorio(int longitud = 2 ) {
				string nombre = "";

				for (int i = 0; i < longitud; i++ ) {
					nombre += palabra_aleatoria();
					nombre += (i < longitud -1) ? " " : "";
				}

				return nombre;
			}

			/** @return edad, una edad entre  12 y 99 años */
			public int edad_aleatoria() {
				return Random.int_range(12,99);
			}

			/* genera un rol falso para un artista */
			public string rol_aleatorio() {
				string[] roles = {"artista", "amigo"};
				return roles[Random.int_range(0,1)];
			}

			/* genera una persona aleatoria */
			public Persona persona_aleatoria() {
				var p =  new Persona();
				p.nombre = nombre_aleatorio();
				p.rol =  rol_aleatorio();
				p.edad =  edad_aleatoria();
				p.popularidad =  0;
				p.nacionalidad =  "mexicano";
				p.imagen =  "src/ui/images/" + Random.int_range(1,176).to_string() + ".jpg";

				return p;
			}

			/** @return artistam crea un artista con datos aleatorios */
			public Artista artista_aleatorio() {
				var p =  new Artista();
				
				p.nombre = nombre_aleatorio();
				p.rol =  "artista";
				p.edad =  edad_aleatoria();
				p.popularidad =  0;
				p.nacionalidad =  "mexicano";
				p.imagen =  "src/ui/images/" + Random.int_range(1,176).to_string() + ".jpg";

				return p;

			}

			/** genera un album aleatorio de imagenes */
			public AlbumImagenes album_imagenes_aleatorio(int imagenes = 10) {
				AlbumImagenes ai =  new AlbumImagenes();
				ai.nombre = nombre_aleatorio();
				ai.descripcion = nombre_aleatorio(5);
				return ai;

			}

			public AlbumCanciones album_canciones_aleatorio() {
				AlbumCanciones ac = new AlbumCanciones();
				ac.nombre = nombre_aleatorio();
				ac.id = -1;
				return ac;
			}

			public Cancion cancion_aleatoria() {
				Cancion c = new Cancion();
				c.nombre = nombre_aleatorio();
				c.ubicacion = ruta_aleatoria() + ".mp3";
				c.actualizar_u_acceso();
				c.popularidad = 0;
				c.disponible =  true;

				return c;
			}

			private string ruta_imagen_aleatoria() {
				string [] rutas = {"/usr/share/backgrounds/gnome/Blinds.jpg",
									"/usr/share/backgrounds/gnome/Chmiri.jpg",
									"/usr/share/backgrounds/gnome/Bokeh_Tails.jpg",
									"/usr/share/backgrounds/gnome/Dark_Ivy.jpg",
									"/usr/share/backgrounds/gnome/Fabric.jpg",
									"/usr/share/backgrounds/gnome/Flowerbed.jpg",
									"/usr/share/backgrounds/gnome/Locked.jpg",
									"/usr/share/backgrounds/gnome/Mirror.jpg",
									"/usr/share/backgrounds/gnome/Road.jpg",
									"/usr/share/backgrounds/gnome/Sandstone.jpg",
									"/usr/share/backgrounds/gnome/Stones.jpg",
									"/usr/share/backgrounds/gnome/Terraform-green.jpg",
									"/usr/share/backgrounds/gnome/Whispy_Tails.jpg"};

				return rutas[Random.int_range(0,rutas.length-1)];
			}

			public Imagen imagen_aleatoria() {
				Imagen imagen = new Imagen();
				imagen.nombre = palabra_aleatoria();
				imagen.ubicacion =  ruta_imagen_aleatoria();
				
				return imagen;
			}

			public Sentimiento sentimiento_aleatorio() {
				return null;
			}

			public Gdk.Pixbuf imagen_aleatoria_real(int h, int w) {
				return new Gdk.Pixbuf.from_file_at_size ("src/ui/images/" + Random.int_range(1,176).to_string() + ".jpg", h, w);
			}

			public static string  caratula_aleatoria() {
				return "src/ui/images/" + Random.int_range(1,176).to_string() + ".jpg";
			}




 		}
}