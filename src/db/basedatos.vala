using GraphMedia.Modelos;

namespace GraphMedia {
	/**
	* Clase que prove los singletones de cada una de las tablas
	* para poder manipular la base de datos desde
	* cualquier punto de la aplicacion con el mismo objeto para 
	* no desperdiciar memoria.
	*/

	public class BaseDatos {

		private  string nombre_archivo;

		private  Artistas artistas;
		private  AlbumsMusicales  albums_musicales;
		private  Sentimientos  sentimientos;
		private  Canciones canciones;
		private  Imagenes imagenes;
		private  AlbumsImagenes albums_imagenes;


		public  void  seleccionar_archivo(string archivo) {
			assert(archivo !=  null);
			nombre_archivo =  archivo;
		}

		public  void inicializar() {
			assert(nombre_archivo != null);
			Tablas.inicializar(nombre_archivo);
		}

		public  Artistas get_artistas() {
			if (artistas == null)
				artistas = Artistas.get_instancia();

			return artistas;
		}

		public  AlbumsMusicales get_albums_musicales() {
			if (albums_musicales == null)
				albums_musicales = AlbumsMusicales.get_instancia();

			return albums_musicales;
		}

		public  AlbumsImagenes get_albums_imagenes() {
			if (albums_imagenes == null)
				albums_imagenes = AlbumsImagenes.get_instancia();

			return albums_imagenes;
		}

		public  Sentimientos get_sentimientos() {
			if (sentimientos == null)
				sentimientos = Sentimientos.get_instancia();

			return sentimientos;
		}

		public  Canciones get_canciones() {
			if (canciones == null)
				canciones = Canciones.get_instancia();

			return canciones;
		}

		public  Imagenes get_imagenes() {
			if (imagenes == null)
				imagenes = Imagenes.get_instancia();

			return imagenes;
		}
	}


}