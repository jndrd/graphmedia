namespace GraphMedia.Modelos {

	/**
	* Clase que modela los arhivos de imagen de la biblioteca, usa los mismos 
	* atributos que Archivo
	*/
	public class Imagen : Archivo {
		
		private const string TIPO = "imagen";

		public Imagen () {
			id = -1;
			tipo = TIPO;
		}

	}

	public class Imagenes : TablaArchivo, Filtrable{

		private TablaArchivo archivos;
		private static Imagenes instancia;

		private Imagenes () {
			archivos = TablaArchivo.get_instancia();
		}

		public new static Imagenes get_instancia() {
			if (instancia == null)
				instancia = new Imagenes();

			return instancia;
		}

		public new Imagen agregar(Imagen imagen) {
			assert (imagen.tipo == "imagen");
			return archivos.agregar(imagen) as Imagen;
		}

		public new Imagen eliminar(Imagen imagen) {
			archivos.eliminar(imagen);
			imagen.id = -1;

			return imagen;
		}

		public new bool editar(Imagen imagen) {
			return archivos.editar(imagen);
		}

		public int get_total_imagenes() {
			return get_total_tipo("imagen");
		}

		private Gee.ArrayList<Imagen> get_imagenes(string where = "1", int lim = 0) {
			Gee.ArrayList<Imagen> imagenes = new  Gee.ArrayList<Imagen>();

			var archivos = get_archivos("tipo='imagen' AND " + where, lim);
			
			foreach (Archivo p  in archivos) {
				Imagen a =  Archivo.cast_imagen(p);
				imagenes.add(a);
			}

			return imagenes;
		}

		public Imagen get_imagen_por_id(int64 id) {
			Archivo archivo = get_archivo_id(id);
			assert (archivo != null);

			return Archivo.cast_imagen(archivo);
		}


		public Gee.ArrayList<Imagen> buscar_imagenes_por_nombre(string nombre="", int limite = 0, string orden="popularidad") {
			assert (limite >= 0);
			Sqlite.Statement query;

			string sql = "SELECT id, nombre, ubicacion, tipo, ultimoAcceso, popularidad, disponible"
            + " FROM %s WHERE tipo=? AND nombre %s ORDER BY %s DESC".printf(nombre_tabla, "LIKE '%" + nombre +"%'", orden);

        	int res = bd.prepare_v2(sql, -1, out query);
        	assert (res == Sqlite.OK);
        	res = query.bind_text(1, "imagen");
        	assert (res == Sqlite.OK);

     	    Gee.ArrayList<Imagen> archivos =  new Gee.ArrayList<Imagen>();

        	while ((res = query.step()) == Sqlite.ROW) {

        		if (limite != 0 && archivos.size == limite)
        			break;

        		Imagen celda = new Imagen();

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
		 	var imagenes = buscar_imagenes_por_nombre(consulta, lim);

		 	Gtk.ListStore model = new Gtk.ListStore (3, typeof (Gdk.Pixbuf), 
		 									typeof (string), typeof (int64));
            
            Gtk.IconView vista = new Gtk.IconView.with_model (model);
            vista.set_pixbuf_column (0);
            vista.set_text_column (1);
            vista.set_item_width(120);

            Gtk.TreeIter iter =  Gtk.TreeIter();

            foreach (Imagen a in imagenes ) {
                model.append (out iter);
                model.set (iter, 0, cargar_icono_ubicacion(a.ubicacion,AppGUI.TAM_ICONO, AppGUI.TAM_ICONO),
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