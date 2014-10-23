namespace GraphMedia.Modelos {
	
	public errordomain ErrorArchivo {
		NO_ENCONTRADO,
	}

	/**
	* Clase que modela un archivo dentro de la base de datos
	* permite modificar sus atributos directamente exepto las fechas 
	* las cuales se actualizan programaticamente para evitar conflictos
	*/
	public class Archivo {

		public int64 id;
		public string nombre;
		public string ubicacion;
		public string tipo;
		public string u_acceso;
		public double popularidad;
		public bool disponible;

		public Archivo () {
			actualizar_u_acceso();
			disponible = false;
		}

		/**
		* Actualiza la cadena que representa la fecha del ultimo acceso al archivo
		*/
		public void actualizar_u_acceso() {
			u_acceso = new DateTime.now_local().to_string();
		}

		public static Cancion cast_cancion(Archivo a) {
			assert (a.tipo == "audio");
			assert (a.id != -1);

			Cancion c =  new Cancion();
			c.id = a.id;
			c.nombre = a.nombre;
			c.ubicacion = a.ubicacion;
			c.tipo  = a.tipo;
			c.u_acceso = a.u_acceso;
			c.popularidad = a.popularidad;
			c.disponible = a.disponible;

			return c;
		}

		public static Imagen cast_imagen(Archivo a) {
			assert (a.tipo == "imagen");
			assert (a.id != -1);

			Imagen c =  new Imagen();
			c.id = a.id;
			c.nombre = a.nombre;
			c.ubicacion = a.ubicacion;
			c.tipo  = a.tipo;
			c.u_acceso = a.u_acceso;
			c.popularidad = a.popularidad;
			c.disponible = a.disponible;

			return c;
		}

		public bool es_valido() {
			return id > 0 && nombre != null && nombre != "" &&
					(tipo == "audio" || tipo == "imagen"); 
		}

	}

	protected class TablaArchivo : Tablas {
		
		private static TablaArchivo instancia = null;

		protected TablaArchivo() {
			set_nombre_tabla("archivos");
		}

		protected static TablaArchivo get_instancia() {
			if (instancia == null)
				instancia = new TablaArchivo();

			return instancia;
		}

		/**
		* Agrega una archivo nueva a la base de datos 
		*/
		protected Archivo agregar(Archivo archivo) {
			Sqlite.Statement query;
        	int res = bd.prepare_v2(
	            "INSERT INTO %s (nombre, ubicacion, tipo, ultimoAcceso, popularidad, disponible)".printf(nombre_tabla)
	            + "VALUES (?, ?, ?, ?, ?, ? )",
	            -1, out query);
        	assert (res == Sqlite.OK);
	        
	        res = query.bind_text(1, archivo.nombre);
	        assert (res == Sqlite.OK);
	        res = query.bind_text(2, archivo.ubicacion);
	        assert (res == Sqlite.OK);
	        res = query.bind_text(3, archivo.tipo);
	        assert (res == Sqlite.OK);
	        res = query.bind_text(4, archivo.u_acceso);
	        assert (res == Sqlite.OK);
	        res = query.bind_double(5, archivo.popularidad);
	        assert (res == Sqlite.OK);   
	        int dis = (archivo.disponible ? 1 : 0);    
	        res = query.bind_int(6, dis);
	       	        
	        res = query.step();
	        if (res != Sqlite.DONE) 
	        	return null;

	    	archivo.id = bd.last_insert_rowid();
       
	        return archivo;

		}

		protected Archivo eliminar (Archivo p) throws ErrorBaseDatos {
			assert (p.id != -1);

			if (!eliminar_celda_por_id(p.id))
				throw new ErrorBaseDatos.CONSULTA("No se pudo eliminar a %s".printf(p.nombre));

			p.id = -1;
			return  p;

		}

		protected Gee.List<Archivo> buscar(string where) {
			return null;
		}

		protected bool editar(Archivo p) {
			if(!p.es_valido())
				return false;
			string columnas = "nombre=?, ubicacion=?, tipo=?, ultimoAcceso=?, popularidad=?, disponible=?";
			Sqlite.Statement query;

			string sql = "UPDATE %s SET %s WHERE id=?".printf(nombre_tabla, columnas);

			int res = bd.prepare_v2(sql, -1, out query);
			assert (res == Sqlite.OK);

			res = query.bind_text(1, p.nombre);
			assert (res == Sqlite.OK);
			res = query.bind_text(2, p.ubicacion);
			assert (res == Sqlite.OK);
			res = query.bind_text(3, p.tipo);
			assert (res == Sqlite.OK);
			res = query.bind_text(4, p.u_acceso);
			assert (res == Sqlite.OK);
			res = query.bind_double(5, p.popularidad);
			assert (res == Sqlite.OK);
			res = query.bind_int(6, (p.disponible) ? 1 : 0);
			assert (res == Sqlite.OK);
			res = query.bind_int64(7, p.id);
			assert (res == Sqlite.OK);

			res =  query.step();
			return (res == Sqlite.DONE);
		}

		protected Archivo get_archivo_id(int64 id) {
			Sqlite.Statement query;

			string sql = "SELECT %s FROM %s WHERE id=?".printf("*", nombre_tabla);
	
			int res = bd.prepare_v2(sql, -1, out query);
			assert (res == Sqlite.OK);

			res = query.bind_int64(1, id);
			assert (res == Sqlite.OK);

			res = query.step();
			assert (res == Sqlite.ROW);
				
		    Archivo celda = new Archivo();

    		celda.id = query.column_int64(0);
            celda.nombre = query.column_text(1);
            celda.ubicacion = query.column_text(2);
            celda.tipo = query.column_text(3);
            celda.popularidad = query.column_double(4);
            celda.disponible = (query.column_int(5)  == 0);

            return celda;
		}

		protected int get_total_archivos() {
			return get_total_celdas();
		}

		protected int get_total_tipo(string tipo) {
			Sqlite.Statement query; 
			string sql = "SELECT COUNT(id) AS total FROM %s WHERE tipo=?".printf(nombre_tabla);

			int res = bd.prepare_v2(sql, -1, out query);
			assert (res == Sqlite.OK);

			res = query.bind_text(1, tipo);
			assert (res == Sqlite.OK);

			res = query.step();
			if (res != Sqlite.ROW)
				return -1;
			return query.column_int(0);
		}

		protected Gee.ArrayList<Archivo> get_archivos(string where = "1", int limite = 0, string orden="popularidad") {
			assert (limite >= 0);
			Sqlite.Statement query;

			string sql = "SELECT id, nombre, ubicacion, tipo, ultimoAcceso, popularidad, disponible "
            + "FROM %s WHERE %s ORDER BY %s DESC".printf(nombre_tabla, where, orden);
        	int res = bd.prepare_v2(sql, -1, out query);
        	
        	GLib.warning(sql);
        	assert (res == Sqlite.OK);

        	Gee.ArrayList<Archivo> archivos =  new Gee.ArrayList<Archivo>();

        	while ((res = query.step()) == Sqlite.ROW) {

        		if (limite != 0 && archivos.size == limite)
        			break;

        		Archivo celda = new Archivo();

        		celda.id = query.column_int64(0);
	            celda.nombre = query.column_text(1);
	            celda.ubicacion = query.column_text(2);
	            celda.tipo = query.column_text(3);
	            celda.popularidad = query.column_double(4);
	            celda.disponible = (query.column_int(5) == 0);
	            
	            archivos.add(celda);
	        }

        	return archivos;
        }
		
	}
}