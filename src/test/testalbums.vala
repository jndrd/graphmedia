using Gee;
using GraphMedia.Modelos;

namespace GraphMedia {


		public class TestAlbumsMusicales : TestBaseDeDatos {
 
 			private AlbumsMusicales albums; 

 			public TestAlbumsMusicales () {

 				stdout.printf(" *** Tests AlbumsMusicales ***");
		        add_test ("registrar album", registrar_album);
		        add_test ("editar album", editar_album);
		        add_test ("eliminar album", eliminar_album);
		        add_test ("listar albums", listar_albums);
		       	add_test ("agregar cancion", agregar_cancion);
		        add_test ("eliminar cancion", eliminar_cancion);
		        add_test ("listar canciones por album", llenar_album_canciones);

		      
		    }

		    public override void set_up () {
				base_de_datos = new BaseDatos();
				base_de_datos.seleccionar_archivo("src/test/base_prueba.db");
				base_de_datos.inicializar();
				albums = base_de_datos.get_albums_musicales();

				generador = new Generador("src/test/lista.txt");
		    	COTA_SUPERIOR = generador.edad_aleatoria();

			}

		    private void registrar_album() {
		    	assert (albums != null);
		    	int n = albums.get_total_albums();

		    	AlbumCanciones album = generador.album_canciones_aleatorio();
		    	assert (album.id == -1);
		    	
		    	album = albums.registrar(album);
		    	assert (album != null);
		    	assert (albums.get_total_albums() == n+1);

		    	assert (album.id != -1);

		    	AlbumCanciones registrado = albums.get_album_por_id(album.id);
		    	assert (registrado != null);

		    	assert (album.nombre == registrado.nombre);

			}

			private void eliminar_album() {
		    	assert (albums != null);
		    	
		    	int n = albums.get_total_albums();

		    	AlbumCanciones album = generador.album_canciones_aleatorio();
		    	assert (album.id == -1);
		    	
		    	album = albums.registrar(album);
		    	assert (albums.get_total_albums() == n+1);

		    	AlbumCanciones registrado = albums.get_album_por_id(album.id);

			   	registrado = albums.eliminar(registrado);

			   	assert (registrado.id == -1);

			}

			private void listar_albums() {
				int lim = 5;

				Gee.ArrayList<AlbumCanciones> resultados = albums.buscar_albums_por_nombre("Andrade",lim);
				assert (resultados.size >= 0 && resultados.size <= lim);
		
			}

		   	private void editar_album() {
		   		AlbumCanciones album = generador.album_canciones_aleatorio();
		    	assert (album.id == -1);
		    	
		    	album = albums.registrar(album);

		    	AlbumCanciones registrado = albums.get_album_por_id(album.id);
		    	registrado.nombre = "Jonathan Andrade";

		    	assert (albums.editar(registrado));

		    	registrado = albums.get_album_por_id(album.id);
		    	assert (registrado.nombre == "Jonathan Andrade");

		    	registrado.nombre = "";
		    	assert (!albums.editar(registrado));

		   	}

		   	private void llenar_album_canciones() {

		   	}

		   	private void agregar_cancion() {

		   	}

		   	private void eliminar_cancion() {

		   	}
		
	}

	public class TestAlbumsImagenes : TestBaseDeDatos {
 
 			private AlbumsImagenes albums_i; 

 			public TestAlbumsImagenes () {

 				stdout.printf(" *** Tests AlbumsMusicales ***");
		        add_test ("agregar album", agregar_album);
		        add_test ("editar album", editar_album);
		        add_test ("eliminar album", eliminar_album);
		        add_test ("listar albums", listar_albums);
		       	add_test ("agregar cancion", agregar_imagen);
		        add_test ("eliminar cancion", eliminar_imagen);
		        add_test ("listar canciones por album", llenar_album_imagenes);

		      
		    }

		    public override void set_up () {
				base_de_datos = new BaseDatos();
				base_de_datos.seleccionar_archivo("src/test/base_prueba.db");
				base_de_datos.inicializar();
				albums_i = base_de_datos.get_albums_imagenes();
				assert (albums_i != null);
				generador = new Generador("src/test/lista.txt");
		    	COTA_SUPERIOR = generador.edad_aleatoria();

			}

		    private void agregar_album() {
		    	assert (albums_i != null);
		    	int n = albums_i.get_total_albums();

		    	AlbumImagenes album = generador.album_imagenes_aleatorio();
		    	assert (album.id == -1);
		    	
		    	album = albums_i.agregar(album);
		    	assert (album != null);
		    	assert (albums_i.get_total_albums() == n+1);

		    	assert (album.id != -1);

		    	AlbumImagenes registrado = albums_i.get_album_por_id(album.id);
		    	assert (registrado != null);

		    	assert (album.nombre == registrado.nombre);

			}

			private void eliminar_album() {
		    	assert (albums_i != null);
		    	
		    	int n = albums_i.get_total_albums();

		    	AlbumImagenes album = generador.album_imagenes_aleatorio();
		    	assert (album.id == -1);
		    	
		    	album = albums_i.agregar(album);
		    	assert (albums_i.get_total_albums() == n+1);

		    	AlbumImagenes registrado = albums_i.get_album_por_id(album.id);

			   	registrado = albums_i.eliminar(registrado);

			   	assert (registrado.id == -1);

			}

			private void listar_albums() {
				int lim = 5;

				Gee.ArrayList<AlbumImagenes> resultados = albums_i.buscar_albums_por_nombre("",lim);
				assert (resultados.size >= 0 && resultados.size <= lim);
		
			}

		   	private void editar_album() {
		   				    	assert (albums_i != null);
		    	int n = albums_i.get_total_albums();

		    	AlbumImagenes album = generador.album_imagenes_aleatorio();
		    	assert (album.id == -1);
		    	
		    	album = albums_i.agregar(album);
		    	assert (album != null);
		    	assert (albums_i.get_total_albums() == n+1);

		    	assert (album.id != -1);

		    	AlbumImagenes registrado = albums_i.get_album_por_id(album.id);
		    	assert (registrado != null);

		    	registrado.nombre = "Jonathan Andrade";
		    	stdout.printf("obtenido");

		    	assert (albums_i.editar(registrado));

		    	registrado = albums_i.get_album_por_id(album.id);
		    	assert (registrado.nombre == "Jonathan Andrade");

		    	registrado.nombre = "";
		    	assert (!albums_i.editar(registrado));
		   	}

		   	private void llenar_album_imagenes() {

		   	}

		   	private void agregar_imagen() {

		   	}

		   	private void eliminar_imagen() {

		   	}
		
	}
}