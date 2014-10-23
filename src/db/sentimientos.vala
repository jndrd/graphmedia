namespace GraphMedia.Modelos {

	/**
	* Clase que modela un sentimiento (sistema de clasificacion)
	* dentro de los archivos y distintas relaciones entre los componentes
	* del sistema
	*/
	public class Sentimiento {

		public int64 id;
		public string nombre;
		public string descripcion;

		public Sentimiento() {
			id = -1;
			nombre = "indiferencia";
			descripcion = "sin descripcion";
		}

		public bool es_valido() {
			return id != -1 && nombre != null && nombre != "" &&
					nombre != " " && descripcion != null && 
					descripcion !=  "";
		}

	}

	public class Sentimientos : Tablas, Filtrable {
		
		private static Sentimientos instancia = null;

		private Sentimientos () {
			set_nombre_tabla ("sentimientos");
		}

		/** Devuelve un singleton de la tabla */
		public static Sentimientos get_instancia () {
			if (instancia == null)
				instancia = new Sentimientos ();

			return instancia;
		}

		/**
		* Agrega una sentimiento nueva a la base de datos 
		*/
		public Sentimiento agregar (Sentimiento sentimiento) {
			if(existe_sentimiento(sentimiento))
				return sentimiento;

			Sqlite.Statement query;
			string sql = "INSERT INTO %s (nombre, descripcion) ".printf (nombre_tabla)
	            + "VALUES (?, ?)";
        	int res = bd.prepare_v2 (sql,-1, out query);
        	assert (res == Sqlite.OK);

	        res = query.bind_text (1, sentimiento.nombre);
	        assert (res == Sqlite.OK);
	        res = query.bind_text (2, sentimiento.descripcion);
	        assert (res == Sqlite.OK);
	             	        
	        res = query.step ();
	        if (res != Sqlite.DONE) 
	        	return null;
	    	sentimiento.id = bd.last_insert_rowid ();
       
	        return sentimiento;

		}

		public Sentimiento eliminar (Sentimiento p) throws ErrorBaseDatos {
			assert (p.id != -1);
			stdout.printf("id: " + p.id.to_string());

			if (!eliminar_celda_por_id (p.id))
				throw new ErrorBaseDatos.CONSULTA ("No se pudo eliminar a %s".printf (p.nombre));

			p.id = -1;
			return  p;

		}

		public bool editar (Sentimiento sentimiento) {
			if (!sentimiento.es_valido())
				return false;
			string columnas = "nombre=?, descripcion=?";
			Sqlite.Statement query;

			string sql = "UPDATE %s SET %s WHERE id=?".printf (nombre_tabla, columnas);

			int res = bd.prepare_v2 (sql, -1, out query);
			assert (res == Sqlite.OK);

			res = query.bind_text (1, sentimiento.nombre);
			assert (res == Sqlite.OK);
			res = query.bind_text (2, sentimiento.descripcion);
			assert (res == Sqlite.OK);
			res = query.bind_int64 (3, sentimiento.id);
			assert (res == Sqlite.OK);

			res =  query.step ();
			return (res == Sqlite.DONE);
		}

		private bool existe_sentimiento(Sentimiento s) {
			Sqlite.Statement query;
			if (s.id != -1)
				return existe_id(s.id);

			string sql = "SELECT id, nombre, descripcion "
            + "FROM %s WHERE nombre=?".printf (nombre_tabla);

        	int res = bd.prepare_v2 (sql, -1, out query);
        	assert (res == Sqlite.OK);

        	res = query.bind_text (1, s.nombre);
			assert (res == Sqlite.OK);

			res =  query.step ();
			return (res == Sqlite.ROW);

		}

		public int get_total_sentimientos() {
			return get_total_celdas();
		}

		public Sentimiento get_sentimiento_por_id(int64 id) {
			Sqlite.Statement query;

			if (!existe_id(id))
				return null;

			string sql = "SELECT %s FROM %s WHERE id=?".printf("*", nombre_tabla);
	
			int res = bd.prepare_v2(sql, -1, out query);
			assert (res == Sqlite.OK);

			res = query.bind_int64(1, id);
			assert(res == Sqlite.OK);

			res = query.step();
			assert (res == Sqlite.ROW);
				
		    Sentimiento celda = new Sentimiento();

    		celda.id = query.column_int64(0);
            celda.nombre = query.column_text(1);
            celda.descripcion = query.column_text(2);

            return celda;
		}


		public Gee.ArrayList<Sentimiento> lista_sentimientos () {
			Sqlite.Statement query;

			string sql = "SELECT id, nombre, descripcion "
            + "FROM %s WHERE 1".printf (nombre_tabla);

        	int res = bd.prepare_v2 (sql, -1, out query);
        	assert (res == Sqlite.OK);

        	Gee.ArrayList<Sentimiento> sentimientos =  new Gee.ArrayList<Sentimiento> ();

        	while ( (res = query.step ()) == Sqlite.ROW) {
        		Sentimiento celda = new Sentimiento ();

        		celda.id = query.column_int64 (0);
	            celda.nombre = query.column_text (1);
	            celda.descripcion = query.column_text (2);;
	            
	            sentimientos.add (celda);
	        }

        	return sentimientos;
        }

        public  Gtk.IconView filtrar(string consulta, int lim) {
            var sentimientos = lista_sentimientos();

            Gtk.ListStore model = new Gtk.ListStore (3, typeof (Gdk.Pixbuf), 
                                            typeof (string), typeof (int64));
            
            Gtk.IconView vista = new Gtk.IconView.with_model (model);
            vista.set_pixbuf_column (0);
            vista.set_text_column (1);
            vista.set_item_width(120);

            Gtk.TreeIter iter =  Gtk.TreeIter();

            foreach (Sentimiento a in sentimientos ) {
            	
                model.append (out iter);
                model.set (iter, 0, cargar_icono_ubicacion("sentimiento" ,AppGUI.TAM_ICONO, AppGUI.TAM_ICONO),
                                1, a.nombre,
                                2, a.id);

            }

            vista.selection_changed.connect (() => {
                List<Gtk.TreePath> paths = vista.get_selected_items ();
                if (paths == null)
                    return;
                var path = paths.nth_data(0);

                Value title;
                Value icon;
                Value index;
                
                bool tmp = model.get_iter (out iter, path);
                assert (tmp == true);

                    model.get_value (iter, 0, out icon); 
                    model.get_value (iter, 1, out title); 
                    model.get_value (iter, 2, out index); 

                    AppGUI.index_actual = (int64) index;

                    GLib.warning ("%s: %p - %lld \n", (string) title, ((Gdk.Pixbuf) icon), (int64) index);
            
            });

            return vista;

         
    }


		
	}
	
}