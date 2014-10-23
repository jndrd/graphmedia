
namespace GraphMedia.Modelos {
	
	/**
	* Clase que modela los arhivos de audio de la biblioteca, usa los mismos 
	* atributos que Archivo, ademas de la caratula que representa el archivo
	* Parece una buena alternativa obtener las etiquetas del archivo aqui mismo.
	*/
	public class Cancion : Archivo {
		
		private const string TIPO = "audio";
		public string imagen { get; private set; }

		/**
		* Constructor para un objeto recibido de la base de datos 
		*/
		public Cancion.desde_campo (int id, string nombre, string ubicacion, string u_acceso, 
						double popularidad, bool disponible) {
			base.desde_campo (id, nombre, ubicacion, TIPO, u_acceso, popularidad, disponible);
		}
 	

	}
}