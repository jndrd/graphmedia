using Gee;
using GraphMedia.Modelos;

namespace GraphMedia {


		public class TestImagenes : TestBaseDeDatos {
 
 			private Imagenes imagenes; 

 			public TestImagenes () {

		        add_test ("agregar imagen", agregar_imagen);
		        add_test ("editar imagen", editar_imagen);
		        add_test ("eliminar imagen", eliminar_imagen);
		        add_test ("listar imagenes", listar_imagenes);
		       	add_test ("agregar imagen", agregar_imagen);

		    }

		    public override void set_up () {
				base_de_datos = new BaseDatos();
				base_de_datos.seleccionar_archivo("src/test/base_prueba.db");
				base_de_datos.inicializar();
				imagenes = base_de_datos.get_imagenes();

				generador = new Generador("src/test/lista.txt");
		    	COTA_SUPERIOR = generador.edad_aleatoria();

			}

		    private void agregar_imagen() {
		    	assert (imagenes != null);
		    	int n = imagenes.get_total_imagenes();

		    	Imagen imagen = generador.imagen_aleatoria();
		    	assert (imagen.id == -1);
		    	
		    	imagen = imagenes.agregar(imagen);
		    	assert (imagen != null);
		    	assert (imagenes.get_total_imagenes() == n+1);

		    	assert (imagen.id != -1);

		    	Imagen registrado = imagenes.get_imagen_por_id(imagen.id);
		    	assert (registrado != null);

		    	assert (imagen.nombre == registrado.nombre);

			}

			private void eliminar_imagen() {
		    	assert (imagenes != null);
		    	
		    	int n = imagenes.get_total_imagenes();

		    	Imagen imagen = generador.imagen_aleatoria();
		    	assert (imagen.id == -1);
		    	
		    	imagen = imagenes.agregar(imagen);
		    	assert (imagenes.get_total_imagenes() == n+1);

		    	Imagen registrado = imagenes.get_imagen_por_id(imagen.id);

			   	registrado = imagenes.eliminar(registrado);
		    	assert (imagenes.get_total_imagenes() == n);
			   	assert (registrado.id == -1);

			}

			private void listar_imagenes() {
				int lim = 5;

				Gee.ArrayList<Imagen> resultados = imagenes.buscar_imagenes_por_nombre("a",lim);
				assert (resultados.size >= 0 && resultados.size <= lim);
		
			}

		   	private void editar_imagen() {
		   		Imagen imagen = generador.imagen_aleatoria();
		    	assert (imagen.id == -1);
		    	
		    	imagen = imagenes.agregar(imagen);

		    	Imagen registrado = imagenes.get_imagen_por_id(imagen.id);
		    	registrado.nombre = "I'm aquarius";

		    	assert (imagenes.editar(registrado));

		    	registrado = imagenes.get_imagen_por_id(imagen.id);
		    	assert (registrado.nombre == "I'm aquarius");

		    	registrado.nombre = "";
		    	assert (!imagenes.editar(registrado));

		   	}


	}
}