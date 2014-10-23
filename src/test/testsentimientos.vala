using Gee;
using GraphMedia.Modelos;

namespace GraphMedia {


		public class TestSentimientos : TestBaseDeDatos {
 
			private Sentimientos sentimientos;

 			public TestSentimientos () {

		        add_test ("editar sentimiento", editar_sentimiento);
		        add_test ("registrar sentimiento", registrar_sentimiento);
		        add_test ("eliminar sentimiento", eliminar_sentimiento);
		        add_test ("listar sentimientos", listar_sentimientos);
		        add_test ("sentimiento por id ", get_sentimiento_por_id);
		      
		    }

		    public override void set_up () {
				base_de_datos = new BaseDatos();
				base_de_datos.seleccionar_archivo("src/test/base_prueba.db");
				base_de_datos.inicializar();

				generador = new Generador("src/test/lista.txt");
		    	COTA_SUPERIOR = generador.edad_aleatoria();

		    	sentimientos = base_de_datos.get_sentimientos();

			}

		    private void registrar_sentimiento() {
		    	assert (sentimientos != null);
		    	int n = sentimientos.get_total_sentimientos();

		    	Sentimiento sentimiento = new Sentimiento();
		    	sentimiento.nombre = generador.nombre_aleatorio();		    	
		    	assert (sentimiento.id == -1);
		    	
		    	sentimiento = sentimientos.agregar(sentimiento);
		    	assert (sentimientos.get_total_sentimientos() == n+1);

		    	assert (sentimiento.id != -1);

		    	Sentimiento registrado = sentimientos.get_sentimiento_por_id(sentimiento.id);
		    	assert (registrado != null);

		    	assert (sentimiento.nombre == registrado.nombre);

			}

			private void eliminar_sentimiento() {
		    	assert (sentimientos != null);
		    	int n = sentimientos.get_total_sentimientos();

		    	Sentimiento sentimiento = new Sentimiento();
		    	sentimiento.nombre = generador.nombre_aleatorio();		    	
		    	assert (sentimiento.id == -1);
		    	
		    	sentimiento = sentimientos.agregar(sentimiento);
		    	assert (sentimientos.get_total_sentimientos() == n+1);

		    	assert (sentimiento.id != -1);

		    	Sentimiento registrado = sentimientos.get_sentimiento_por_id(sentimiento.id);
		    	assert (registrado != null);

		    	assert (sentimiento.nombre == registrado.nombre);
			   	registrado = sentimientos.eliminar(registrado);
			   	assert (sentimientos.get_total_sentimientos() == n);

			   	assert (registrado.id == -1);

			}

			private void listar_sentimientos() {

				Gee.ArrayList<Sentimiento> resultados = sentimientos.lista_sentimientos();
				assert (resultados.size >= 0);

				foreach (Sentimiento s in resultados ) {
					assert (s.id != -1);
					assert (s.nombre != null);
					assert (s.descripcion !=  null);
				}
		
			}

			private void editar_sentimiento() {

				Gee.ArrayList<Sentimiento> resultados = sentimientos.lista_sentimientos();
				assert (resultados.size >= 0);

				foreach (Sentimiento s in resultados ) {
					assert (s.id != -1);
					assert (s.nombre != null);
					assert (s.descripcion !=  null);
				}
		
			}

			private void get_sentimiento_por_id() {
				assert (sentimientos != null);
		    	int n = sentimientos.get_total_sentimientos();

		    	Sentimiento sentimiento = new Sentimiento();
		    	sentimiento.nombre = generador.nombre_aleatorio();		    	
		    	assert (sentimiento.id == -1);
		    	
		    	sentimiento = sentimientos.agregar(sentimiento);
		    	assert (sentimientos.get_total_sentimientos() == n+1);

		    	assert (sentimiento.id != -1);

		    	Sentimiento registrado = sentimientos.get_sentimiento_por_id(sentimiento.id);
		    	assert (registrado != null);

		    	assert (sentimiento.nombre == registrado.nombre);
			   	registrado = sentimientos.eliminar(registrado);
			   	assert (sentimientos.get_total_sentimientos() == n);

			   	assert (registrado.id == -1);

			}
		
	}
}