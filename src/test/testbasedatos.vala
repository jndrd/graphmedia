using Gee;
using GraphMedia.Modelos;

namespace GraphMedia {


		public class TestBaseDeDatos : Gee.TestCase {
 
 			protected BaseDatos base_de_datos;
 			protected Artistas artistas;
 			protected AlbumsMusicales albums_m;
 			protected Generador generador;
 			protected int COTA_SUPERIOR = 50;


		    public TestBaseDeDatos () {

		        base("BD");
		        add_test ("abrir archivos", abrir_base);
		        add_test ("conexion", conexion_funciona);
		        add_test ("singleton sentimientos", get_sentimientos);
		        add_test ("singleton albums musicales", get_albums_musicales);
		        add_test ("singleton albums imagenes", get_albums_musicales);
		        add_test ("singleton artistas", get_artistas);
	      
		    }

		    public override void set_up () {
				base_de_datos = new BaseDatos();
				base_de_datos.seleccionar_archivo("src/test/base_prueba.db");
				base_de_datos.inicializar();

				generador = new Generador("src/test/lista.txt");
		    	COTA_SUPERIOR = generador.edad_aleatoria();

		    	artistas = base_de_datos.get_artistas();
		    	albums_m = base_de_datos.get_albums_musicales();

			}

			public override void tear_down () {

			}

		    private void abrir_base() {
 		    	BaseDatos v =  new BaseDatos();
 		    	bool detecta_error = true;
 		    	try {
 		    		v.seleccionar_archivo("src/test/base_prueba.db");
 		    	} catch (ErrorBaseDatos e) {
 		    		detecta_error = false;
 		    	}
 		  		assert (detecta_error);
		    }

		    private void conexion_funciona() {
		    	Artistas p1 = base_de_datos.get_artistas();
		    	Artistas p2 = base_de_datos.get_artistas();

		    	assert(p1 != null);
		    	assert (p1 == p2);

		    	assert (p1.get_total_artistas() != -1);
		    }

		    private void get_sentimientos() {
		    	Sentimientos a = base_de_datos.get_sentimientos();
		    	Sentimientos b = base_de_datos.get_sentimientos();

		    	assert (a != null);
		    	assert (a == b);
		    }

		    private void get_artistas() {
		    	Artistas a = base_de_datos.get_artistas();
		    	Artistas b = base_de_datos.get_artistas();

		    	assert (a != null);
		    	assert (a == b);
		    }

		    private void get_albums_musicales () {
		    	AlbumsMusicales a = base_de_datos.get_albums_musicales();
		    	AlbumsMusicales b = base_de_datos.get_albums_musicales();

		    	assert (a != null);
		    	assert (a == b);
		    }

	}
}