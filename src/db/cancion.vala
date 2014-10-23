
namespace GraphMedia.Modelos {
	
	/**
	* Clase que modela los arhivos de audio de la biblioteca, usa los mismos 
	* atributos que Archivo, ademas de la caratula que representa el archivo
	* Parece una buena alternativa obtener las etiquetas del archivo aqui mismo.
	*/
	public class Cancion : Archivo {
		
		private const string TIPO = "audio";
		public string imagen;

		public Cancion () {
			id = -1;
			tipo = TIPO;
		}

 	}

 	public class Canciones : TablaArchivo, Filtrable {

		private TablaArchivo archivos;
		private static Canciones instancia;

		private Canciones () {
			archivos = TablaArchivo.get_instancia();
		}

		public new static Canciones get_instancia() {
			if (instancia == null)
				instancia = new Canciones();

			return instancia;
		}

		public new Cancion agregar(Cancion cancion) {
			assert (cancion.tipo == "audio");
			return archivos.agregar(cancion) as Cancion;
		}

		public new Cancion eliminar(Cancion cancion) {
			archivos.eliminar(cancion);
			cancion.id = -1;

			return cancion;
		}

		public new bool editar(Cancion cancion) {
			return archivos.editar(cancion);
		}

		public int get_total_canciones() {
			return get_total_tipo("audio");
		}

		private Gee.ArrayList<Cancion> get_canciones(string where = "1", int lim = 0) {
			Gee.ArrayList<Cancion> canciones = new  Gee.ArrayList<Cancion>();

			var archivos = get_archivos(where, lim);
			
			foreach (Archivo p  in archivos) {
				Cancion a =  Archivo.cast_cancion(p);
				canciones.add(a);
			}

			return canciones;
		}

		public Cancion get_cancion_por_id(int64 id) {
			Archivo archivo = get_archivo_id(id);
			assert (archivo != null);

			return Archivo.cast_cancion(archivo);
		}


		public Gee.ArrayList<Cancion> buscar_canciones_por_nombre(string nombre, int limite = 0, string orden="popularidad") {
			assert (limite >= 0);
			Sqlite.Statement query;

			string sql = "SELECT id, nombre, ubicacion, tipo, ultimoAcceso, popularidad, disponible"
            + " FROM %s WHERE tipo=? AND nombre %s ORDER BY %s DESC".printf(nombre_tabla, "LIKE '%" + nombre +"%'", orden);

        	int res = bd.prepare_v2(sql, -1, out query);
        	assert (res == Sqlite.OK);
        	res = query.bind_text(1, "audio");
        	assert (res == Sqlite.OK);

     	    Gee.ArrayList<Cancion> archivos =  new Gee.ArrayList<Cancion>();

        	while ((res = query.step()) == Sqlite.ROW) {

        		if (limite != 0 && archivos.size == limite)
        			break;

        		Cancion celda = new Cancion();

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

		public  Gtk.IconView filtrar(string consulta, int lim) {
            var canciones = buscar_canciones_por_nombre(consulta,lim);

            Gtk.ListStore model = new Gtk.ListStore (3, typeof (Gdk.Pixbuf), 
                                            typeof (string), typeof (int64));
            
            Gtk.IconView vista = new Gtk.IconView.with_model (model);
            vista.set_pixbuf_column (0);
            vista.set_text_column (1);
            vista.set_item_width(120);

            Gtk.TreeIter iter =  Gtk.TreeIter();

            foreach (Cancion a in canciones ) {
                model.append (out iter);
                model.set (iter, 0, cargar_icono_ubicacion(a.imagen,50, 50),
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