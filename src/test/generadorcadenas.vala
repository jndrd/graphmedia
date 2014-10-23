using Gee;
using GraphMedia.Modelos;


namespace GraphMedia {


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
 				while ((line = stream.read_line ()) != null || i < LIMITE_PALABRAS) 
					diccionario[i++] = line;

				TOTAL_PALABRAS = i;
			}

			public string palabra_aleatoria() {
				int i = Random.int_range (0, TOTAL_PALABRAS);
				return diccionario[i];
			}

			public string ruta_aleatoria(int longitud = 3) {
				string ruta = "";

				for (int i = 0; i < longitud; i++ ) {
					ruta += palabra_aleatoria();
					ruta += (i < longitud -1) ? "/" : "";
				}

				return ruta;
			}

			public string nombre_aleatorio(int longitud = 2 ) {
				string nombre = "";

				for (int i = 0; i < longitud; i++ ) {
					nombre += palabra_aleatoria();
					nombre += (i < longitud -1) ? " " : "";
				}

				return nombre;
			}

			public int edad_aleatoria() {
				return Random.int_range(12,99);
			}

			public string rol_aleatorio() {
				string[] roles = {"artista", "amigo"};
				return roles[Random.int_range(0,1)];
			}


			public Persona persona_aleatoria() {
				return new Persona.nueva(nombre_aleatorio(), rol_aleatorio(), edad_aleatoria(), 0, "mexicano", ruta_aleatoria(3) + ".jpg");
			}

			public Artista artista_aleatorio() {
				return new Artista.nuevo(nombre_aleatorio(), edad_aleatoria(), 0, "mexicano", ruta_aleatoria(3) + ".jpg");

			}



 		}
}