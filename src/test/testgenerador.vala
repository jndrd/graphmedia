using Gee;

namespace GraphMedia {


		public class TestGenerador : Gee.TestCase {
 
 			private Generador gen;
 			private int COTA_SUPERIOR = 50;

		    public TestGenerador () {

		        base("Test.Generador");
		        add_test ("palabra aleatoria", palabra_aleatoria);
		        add_test ("nombre aleatorio", nombre_aleatorio);
		        add_test ("ruta aleatoria", ruta_aleatoria);

		      
		    }

		    public override void set_up () {
		    	gen = new Generador("src/test/lista.txt");
		    	COTA_SUPERIOR = gen.edad_aleatoria();
			}

			public override void tear_down () {
			}

		    private void palabra_aleatoria() {
		    	string s = gen.palabra_aleatoria();
		    	assert(s != null);
		    	assert(s.size() != 0);
		    }

		    private void nombre_aleatorio() {
		    	int n = 4;

		    	string nombre = gen.nombre_aleatorio();
		    	
		    	assert(nombre != null);
		    	
		    	string[] split = nombre.split(" ");

		    	nombre = gen.nombre_aleatorio(n);
		    	split = nombre.split(" ");
		    }

		    private void ruta_aleatoria() {

		    	string ruta = "";

		    	for (int i = 0; i < COTA_SUPERIOR; i++) {
		    		int n = gen.edad_aleatoria();
		    		ruta = gen.ruta_aleatoria(n);
		    		assert(ruta != null);
		    		string[] split = ruta.split("/");
		    		assert(split.length == n);
		    	}
		    	
		    
		    }
		
	}
}