using Gee;
using GraphMedia.Modelos;

namespace GraphMedia {


		public class TestPersona : Gee.TestCase {
 
 			protected Persona persona;
 			private Generador gen;

		    public TestPersona () {

		        base("Modelos.Personas");
		       	add_test ("constructor persona nueva", constructor_normal);
		        add_test ("setters && getters", set_get);
		      
		    }

		    public override void set_up () {
		    	gen = new Generador("src/test/lista.txt");
		    	persona = gen.persona_aleatoria();
			}

			public override void tear_down () {
				persona = null;
			}

		    private void set_get() {
		    	string nombre = "Jonathan de Jesus";
		    	persona.nombre = nombre;
		    	assert(nombre == persona.nombre);
		    }

		    private void constructor_normal() {

		    	string nombre = gen.nombre_aleatorio();

		    	Persona p = new Persona();

		    	assert(p.id == -1);
		    	
		    	p.nombre =  nombre;
		    	assert(nombre == p.nombre);

		    }

		
	}
}