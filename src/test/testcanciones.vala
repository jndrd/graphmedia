using Gee;
using GraphMedia.Modelos;

namespace GraphMedia {


		public class TestCanciones : TestBaseDeDatos {
 
 			private Canciones canciones; 

 			public TestCanciones () {

 				stdout.printf(" *** Tests AlbumsMusicales ***");
		        add_test ("agregar cancion", agregar_cancion);
		        add_test ("editar cancion", editar_cancion);
		        add_test ("eliminar cancion", eliminar_cancion);
		        add_test ("listar canciones", listar_canciones);
		       	add_test ("agregar cancion", agregar_cancion);

		    }

		    public override void set_up () {
				base_de_datos = new BaseDatos();
				base_de_datos.seleccionar_archivo("src/test/base_prueba.db");
				base_de_datos.inicializar();
				canciones = base_de_datos.get_canciones();

				generador = new Generador("src/test/lista.txt");
		    	COTA_SUPERIOR = generador.edad_aleatoria();

			}

		    private void agregar_cancion() {
		    	assert (canciones != null);
		    	int n = canciones.get_total_canciones();

		    	Cancion cancion = generador.cancion_aleatoria();
		    	assert (cancion.id == -1);
		    	
		    	cancion = canciones.agregar(cancion);
		    	assert (cancion != null);
		    	assert (canciones.get_total_canciones() == n+1);

		    	assert (cancion.id != -1);

		    	Cancion registrado = canciones.get_cancion_por_id(cancion.id);
		    	assert (registrado != null);

		    	assert (cancion.nombre == registrado.nombre);

			}

			private void eliminar_cancion() {
		    	assert (canciones != null);
		    	
		    	int n = canciones.get_total_canciones();

		    	Cancion cancion = generador.cancion_aleatoria();
		    	assert (cancion.id == -1);
		    	
		    	cancion = canciones.agregar(cancion);
		    	assert (canciones.get_total_canciones() == n+1);

		    	Cancion registrado = canciones.get_cancion_por_id(cancion.id);

			   	registrado = canciones.eliminar(registrado);
		    	assert (canciones.get_total_canciones() == n);
			   	assert (registrado.id == -1);

			}

			private void listar_canciones() {
				int lim = 5;

				Gee.ArrayList<Cancion> resultados = canciones.buscar_canciones_por_nombre("a",lim);
				assert (resultados.size >= 0 && resultados.size <= lim);
		
			}

		   	private void editar_cancion() {
		   		Cancion cancion = generador.cancion_aleatoria();
		    	assert (cancion.id == -1);
		    	
		    	cancion = canciones.agregar(cancion);

		    	Cancion registrado = canciones.get_cancion_por_id(cancion.id);
		    	registrado.nombre = "I'm aquarius";

		    	assert (canciones.editar(registrado));

		    	registrado = canciones.get_cancion_por_id(cancion.id);
		    	assert (registrado.nombre == "I'm aquarius");

		    	registrado.nombre = "";
		    	assert (!canciones.editar(registrado));

		   	}


	}
}