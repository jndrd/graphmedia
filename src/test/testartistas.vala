using Gee;
using GraphMedia.Modelos;

namespace GraphMedia {


		public class TestArtistas : TestBaseDeDatos {
 
 			public TestArtistas () {

		        add_test ("editar artista", editar_artista);
		        add_test ("registrar artista", registrar_artista);
		        add_test ("eliminar artista", eliminar_artista);
		        add_test ("listar artistas", listar_artistas);
		        add_test ("artista por id ", get_artista_por_id);
		      
		    }

		    public override void set_up () {
				base_de_datos = new BaseDatos();
				base_de_datos.seleccionar_archivo("src/test/base_prueba.db");
				base_de_datos.inicializar();

				generador = new Generador("src/test/lista.txt");
		    	COTA_SUPERIOR = generador.edad_aleatoria();

		    	artistas = base_de_datos.get_artistas();

			}

		    private void registrar_artista() {
		    	assert (artistas != null);
		    	int n = artistas.get_total_artistas();

		    	Artista artista = generador.artista_aleatorio();
		    	assert (artista.id == -1);
		    	
		    	artista = artistas.agregar(artista);
		    	assert (artistas.get_total_artistas() == n+1);

		    	assert (artista.id != -1);

		    	Artista registrado = artistas.get_artista_por_id(artista.id);
		    	assert (registrado != null);

		    	assert (artista.nombre == registrado.nombre);
		    	assert (artista.imagen == registrado.imagen);

			}

			private void eliminar_artista() {
		    	assert (artistas != null);
		    	
		    	int n = artistas.get_total_artistas();

		    	Artista artista = generador.artista_aleatorio();
		    	assert (artista.id == -1);
		    	
		    	artista = artistas.agregar(artista);
		    	assert (artistas.get_total_artistas() == n+1);

		    	Artista registrado = artistas.get_artista_por_id(artista.id);

			   	registrado = artistas.eliminar(registrado);

			   	assert (registrado.id == -1);

			}

			private void listar_artistas() {
				int lim = 5;

				Gee.ArrayList<Artista> resultados = artistas.buscar_artistas_por_nombre("Andrade",lim);
				assert (resultados.size >= 0 && resultados.size <= lim);
		
			}

		   	private void editar_artista() {
		   		Artista artista = generador.artista_aleatorio();
		    	assert (artista.id == -1);
		    	
		    	artista = artistas.agregar(artista);

		    	Artista registrado = artistas.get_artista_por_id(artista.id);
		    	registrado.nombre = "Jonathan Andrade";

		    	assert (artistas.editar(registrado));

		    	registrado = artistas.get_artista_por_id(artista.id);
		    	assert (registrado.nombre == "Jonathan Andrade");

		    	registrado.nombre = "";
		    	assert (!artistas.editar(registrado));

		   	}

		   	private void get_artista_por_id() {
		   		Artista artista = generador.artista_aleatorio();
		    	assert (artista.id == -1);
		    	
		    	artista = artistas.agregar(artista);

		    	Artista registrado = artistas.get_artista_por_id(artista.id);
		    	registrado.nombre = "Jonathan Andrade";

		    	assert (artistas.editar(registrado));

		    	registrado = artistas.get_artista_por_id(artista.id);
		    	assert (registrado.nombre == "Jonathan Andrade");

		   	}

		
	}
}