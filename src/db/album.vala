

namespace GraphMedia.Modelos {

	/**
	 * Clase que almacena las propiedades de un album o carpeta que se
	 * usara para modelar un album de canciones o de fotografias
	 */
	public abstract class Album  {
	
		public int64 id;
		public string nombre;
		public string descripcion;

		public Album() {
			id = -1;
			descripcion	= "Sin descripcion";
		}

		public bool es_valido() {
			return (nombre != null && nombre !=  "");
		}

		public static AlbumImagenes cast_album_imagenes(Album a) {
			AlbumImagenes ai =  new AlbumImagenes();
			
			ai.id = a.id;
			ai.nombre = a.nombre;
			ai.descripcion = a.descripcion;

			return ai;
		}

		public static AlbumCanciones cast_album_canciones(Album a) {
			AlbumCanciones ai =  (AlbumCanciones) a;
			return ai;
		}
	}


	public class AlbumImagenes : Album {

		public Epoca epoca;
		public Gee.ArrayList<Imagen> imagenes;

		public AlbumImagenes () {
			nombre = "sin nombre";
			id = -1;
			epoca = Epoca(1,1,2000);
			imagenes = new Gee.ArrayList<Imagen>();
		}

		public void agregar_imagen(Imagen i) {
			imagenes.add(i);
		}

		public new  bool es_valido() {
			return (nombre != null && nombre !=  "");
		}
	}


	public class AlbumsImagenes : Tablas, Filtrable {
		
		private static AlbumsImagenes instancia = null;

		private AlbumsImagenes() {
			set_nombre_tabla("album_imagenes");
		}

		public static AlbumsImagenes get_instancia() {
			if (instancia == null)
				instancia = new AlbumsImagenes();

			return instancia;
		}

		/**
		* Agrega una album nueva a la base de datos 
		*/
		public AlbumImagenes agregar(AlbumImagenes album) {
			Sqlite.Statement query;
			string sql = "INSERT INTO %s (nombre, descripcion, fecha)".printf(nombre_tabla)
	            + " VALUES (?, ?, ?)";

        	int res = bd.prepare_v2(sql, -1, out query);
        	assert (res == Sqlite.OK);
        	stdout.printf("0");
	        
	        res = query.bind_text(1, album.nombre);
	        assert (res == Sqlite.OK);
           	stdout.printf("1");
	        res = query.bind_text(2, album.descripcion);
	        assert (res == Sqlite.OK);
	       	stdout.printf("2");
	        res = query.bind_text(3, album.epoca.to_string());
	        assert (res == Sqlite.OK);
        	stdout.printf("3");
             	        
	        res = query.step();
	        if (res != Sqlite.DONE) 
	        	return null;

	    	album.id = bd.last_insert_rowid();
       
	        return album;

		}

		public AlbumImagenes eliminar (AlbumImagenes p) throws ErrorBaseDatos {
			assert (p.id != -1);

			if (!eliminar_celda_por_id(p.id))
				throw new ErrorBaseDatos.CONSULTA("No se pudo eliminar a %s".printf(p.nombre));

			p.id = -1;
			return  p;

		}

		public AlbumImagenes get_album_por_id (int64 id) {
			return get_album_id(id);
		}

		public Gee.ArrayList<AlbumImagenes> buscar_albums_por_nombre (string nombre="", int lim=0) {
			return buscar (nombre, lim);
		}

		private Gee.ArrayList<AlbumImagenes> buscar(string busqueda, int limite) {
			Gee.ArrayList<Album> resultados =  get_albums("nombre LIKE '%" + busqueda + "%'", limite);
			Gee.ArrayList<AlbumImagenes> albums = new Gee.ArrayList<AlbumImagenes>();

			foreach (Album a in resultados ) {
				albums.add(Album.cast_album_imagenes(a));	
			}

			return albums;
		}

		public bool editar(AlbumImagenes album) {
			if(!album.es_valido())
				return false;

			string columnas = "nombre=?, descripcion=?, fecha=?";
			Sqlite.Statement query;

			string sql = "UPDATE %s SET %s WHERE id=?".printf(nombre_tabla, columnas);

			int res = bd.prepare_v2(sql, -1, out query);
			assert (res == Sqlite.OK);

			res = query.bind_text(1, album.nombre);
			assert (res == Sqlite.OK);
			res = query.bind_text(2, album.descripcion);
			assert (res == Sqlite.OK);
			res = query.bind_text(3, album.epoca.to_string());
			assert (res == Sqlite.OK);
			res = query.bind_int64(4, album.id);
			assert (res == Sqlite.OK);
			
			res =  query.step();
			return (res == Sqlite.DONE);
		}

		public AlbumImagenes get_album_id(int64 id) {
			Sqlite.Statement query;
			
			if (!existe_id(id))
				return null;

			string sql = "SELECT %s FROM %s WHERE id=?".printf("*", nombre_tabla);
	
			int res = bd.prepare_v2(sql, -1, out query);
			assert (res == Sqlite.OK);

			res = query.bind_int64(1, id);
			assert (res == Sqlite.OK);

			res = query.step();
			assert (res == Sqlite.ROW);
				
		    AlbumImagenes celda = new AlbumImagenes();
		    // nombre, caratula, popularidad, descripcion
    		celda.id = query.column_int64(0);
            celda.nombre = query.column_text(1);
            celda.descripcion = query.column_text(2);
            celda.epoca = Epoca.cadena(query.column_text(3));

            return celda;
		}

		public int get_total_albums() {
			return get_total_celdas();
		}

		public Gee.ArrayList<Album> get_albums(string where = "1", int limite = 0, string orden="fecha") {
			assert (limite >= 0);
			Sqlite.Statement query;

			string sql = "SELECT id, nombre, descripcion, fecha"
            + " FROM %s WHERE %s ORDER BY %s DESC".printf(nombre_tabla, where, orden);

        	int res = bd.prepare_v2(sql, -1, out query);
        	assert (res == Sqlite.OK);

        	Gee.ArrayList<AlbumImagenes> albums =  new Gee.ArrayList<AlbumImagenes>();

        	while ((res = query.step()) == Sqlite.ROW) {

        		if (limite != 0 && albums.size == limite)
        			break;

        		AlbumImagenes celda = new AlbumImagenes();

        		celda.id = query.column_int64(0);
	            celda.nombre = query.column_text(1);
	            celda.descripcion = query.column_text(2);
	            celda.epoca = Epoca.cadena(query.column_text(3));

	            albums.add(celda);
	        }

        	return albums;
        }

        public  Gtk.IconView filtrar(string consulta, int lim) {
            var albums = buscar_albums_por_nombre(consulta, lim);

            Gtk.ListStore model = new Gtk.ListStore (3, typeof (Gdk.Pixbuf), 
                                            typeof (string), typeof (int64));
            
            Gtk.IconView vista = new Gtk.IconView.with_model (model);
            vista.set_pixbuf_column (0);
            vista.set_text_column (1);
            vista.set_item_width(120);

            Gtk.TreeIter iter =  Gtk.TreeIter();

            foreach (AlbumImagenes a in albums ) {
                model.append (out iter);
                model.set (iter, 0, cargar_icono_ubicacion("caratula", AppGUI.TAM_ICONO, AppGUI.TAM_ICONO),
                                1, a.nombre ,
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