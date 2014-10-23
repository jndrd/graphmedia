namespace GraphMedia.Modelos {
	
	/**
	* clase que modela  a una persona, permite modificar sus atributos
	* y acceder desde ellos
	*/
	public class Persona {

		public int64 id;
		public string nombre;
		public string rol;
		public int edad;
		public double popularidad;
		public string nacionalidad;
		public string imagen;

		public Persona() {
			id = -1;
		}

		public static Artista cast_artista (Persona p) {
			assert (p.rol == "artista");
			Artista a =  new Artista();

			a.id = p.id;
			a.nombre = p.nombre;
			a.rol = p.rol;
			a.edad = p.edad;
			a.popularidad = p.popularidad;
			a.nacionalidad = p.nacionalidad;
			a.imagen = p.imagen;

			return a; 
		}

		public bool es_valida() {
			bool valido = (nombre != "" && nombre != null) && (rol == "artista" || rol == "amigo");
			valido &= (nacionalidad != null && id != -1);

			return valido;
		}

	}


	public class TablaPersonas : Tablas {
		
		private static TablaPersonas instancia = null;

		protected TablaPersonas() {
			set_nombre_tabla("personas");
		}

		protected static TablaPersonas get_instancia() {
			if (instancia == null)
				instancia = new TablaPersonas();

			return instancia;
		}

		/**
		* Agrega una persona nueva a la base de datos 
		*/
		protected Persona agregar(Persona persona) {
			Sqlite.Statement query;
        	int res = bd.prepare_v2(
	            "INSERT INTO %s (nombre, rol, edad, popularidad, nacionalidad, imagen)".printf(nombre_tabla)
	            + "VALUES (?, ?, ?, ?, ?, ? )",
	            -1, out query);
        	assert(res == Sqlite.OK);
	        
	        res = query.bind_text(1, persona.nombre);
	        assert(res == Sqlite.OK);
	        res = query.bind_text(2, persona.rol);
	        assert(res == Sqlite.OK);
	        res = query.bind_int(3, persona.edad);
	        assert(res == Sqlite.OK);
	        res = query.bind_double(4, persona.popularidad);
	        assert(res == Sqlite.OK);
	        res = query.bind_text(5, persona.nacionalidad);
	        assert(res == Sqlite.OK);       
	        res = query.bind_text(6, persona.imagen);
	       	        
	        res = query.step();
	        if (res != Sqlite.DONE) 
	        	return null;

	    	persona.id = bd.last_insert_rowid();
       
			assert (persona.es_valida());       	
	        return persona;

		}

		protected Persona eliminar (Persona p) throws ErrorBaseDatos {
			assert(p.id != -1);

			if (!eliminar_celda_por_id(p.id))
				throw new ErrorBaseDatos.CONSULTA("No se pudo eliminar a %s".printf(p.nombre));

			p.id = -1;
			return  p;

		}

		protected bool editar(Persona p) {
			if (!p.es_valida())
				return false;

			string columnas = "nombre=?, rol=?, edad=?, popularidad=?, nacionalidad=?, imagen=?";
			Sqlite.Statement query;

			string sql = "UPDATE %s SET %s WHERE id=?".printf(nombre_tabla, columnas);

			int res = bd.prepare_v2(sql, -1, out query);
			assert(res == Sqlite.OK);

			res = query.bind_text(1, p.nombre);
			assert(res == Sqlite.OK);
			res = query.bind_text(2, p.rol);
			assert(res == Sqlite.OK);
			res = query.bind_int(3, p.edad);
			assert(res == Sqlite.OK);
			res = query.bind_double(4, p.popularidad);
			assert(res == Sqlite.OK);
			res = query.bind_text(5, p.nacionalidad);
			assert(res == Sqlite.OK);
			res = query.bind_text(6, p.imagen);
			assert(res == Sqlite.OK);
			res = query.bind_int64(7, p.id);
			assert(res == Sqlite.OK);

			res =  query.step();
			return (res == Sqlite.DONE);
		}

		protected Persona get_persona_id(int64 id) {
			Sqlite.Statement query;

			string sql = "SELECT %s FROM %s WHERE id=?".printf("*", nombre_tabla);
			if (!existe_id(id))
				return null;
	
			int res = bd.prepare_v2(sql, -1, out query);
			assert (res == Sqlite.OK);

			res = query.bind_int64(1, id);
			assert(res == Sqlite.OK);

			res = query.step();
			assert (res == Sqlite.ROW);
				
		    Persona celda = new Persona();

    		celda.id = query.column_int64(0);
            celda.nombre = query.column_text(1);
            celda.rol = query.column_text(2);
            celda.edad = query.column_int(3);
            celda.popularidad = query.column_double(4);
            celda.nacionalidad = query.column_text(5);
            celda.imagen = query.column_text(6);

            return celda;
		}

		protected int get_total_personas() {
			return get_total_celdas();
		}

		protected Gee.ArrayList<Persona> get_personas(string where = "1", int limite = 0, string orden="popularidad") {
			assert(limite >= 0);
			Sqlite.Statement query;

			string sql = "SELECT id, nombre, rol, edad, popularidad, nacionalidad, imagen "
            + "FROM %s WHERE %s ORDER BY %s DESC".printf(nombre_tabla, where, orden);

        	int res = bd.prepare_v2(sql, -1, out query);
        	assert(res == Sqlite.OK);

        	Gee.ArrayList<Persona> personas =  new Gee.ArrayList<Persona>();

        	while ((res = query.step()) == Sqlite.ROW) {

        		if (limite != 0 && personas.size == limite)
        			break;

        		Persona celda = new Persona();

        		celda.id = query.column_int64(0);
	            celda.nombre = query.column_text(1);
	            celda.rol = query.column_text(2);
	            celda.edad = query.column_int(3);
	            celda.popularidad = query.column_double(4);
	            celda.nacionalidad = query.column_text(5);
	            celda.imagen = query.column_text(6);
	            
	            personas.add(celda);
	        }

        	return personas;
        }
		
	}

	protected class PersonaArchivo : Relacion {

		private static PersonaArchivo instancia;

		protected PersonaArchivo() {
			set_nombre_tabla("r_persona_archivo");
			set_llave("id_persona");
			set_puerta("id_archivo");
			set_tabla_llave("personas");
			set_tabla_puerta("archivos");
		}

		protected static PersonaArchivo get_instancia() {
			if (instancia == null) 
				instancia = new PersonaArchivo();
			
			return instancia;
		}

		protected void relaciona(Persona persona, Archivo cancion) {
			relaciona_ids(persona.id, cancion.id);
		}	

		protected void eliminar_relaciones_persona(Persona persona) {
			eliminar_relaciones_id(persona.id);
		}

		protected void eliminar_relaciones_archivo(Archivo archivo) {
			eliminar_relaciones_secundarias_id(archivo.id);
		}

		protected int n_archivos_por_persona(Persona persona) {
			return total_relaciones_llave(persona.id);
		}

		protected int n_personas_por_archivo(Archivo archivo) {
			return total_relaciones_puerta(archivo.id);
		}

		protected Gee.ArrayList<Archivo> archivos_por_persona(Persona p) {
			Sqlite.Statement query;

			string sql = "SELECT id, nombre, ubicacion, tipo, ultimoAcceso, popularidad, disponible "
            + "FROM %s WHERE id IN ( SELECT %s FROM %s WHERE %s=%lld) ".printf(tabla_puerta, puerta, nombre_tabla,llave, p.id );

        	int res = bd.prepare_v2(sql, -1, out query);
        	assert(res == Sqlite.OK);

        	Gee.ArrayList<Archivo> archivos =  new Gee.ArrayList<Archivo>();

        	while ((res = query.step()) == Sqlite.ROW) {

        		Archivo c = new Archivo();

	            c.id = query.column_int64(0);
				c.nombre = query.column_text(1);
				c.ubicacion = query.column_text(2);
				c.tipo  = query.column_text(2);
				c.u_acceso = query.column_text(2);
				c.popularidad = query.column_double(3);
				c.disponible = (query.column_int(2) == 0);
	            
	            archivos.add(c);
	        }

        	return archivos;
		}
	}




}