namespace GraphMedia.Modelos {

	/**
	* Clase que modela la estructura de un album dentro de la base de 
	* datos, ademas de permitir agregarle canciones para cuando se
	* esta usando dentro del tiempo de ejecucion y tener una mejor
	* organización de los objetos dentro del programa
	*/
	public class AlbumCanciones : Album {

		public Gee.ArrayList<Cancion> canciones;
		public string caratula;
		public double popularidad;

		/** 
		* Constructor por defecto, provee un id invalido para indicar
		* que no se encuentra registrado dentro de la base de datos
		*/
		public AlbumCanciones () {
			id = -1;
			canciones = new Gee.ArrayList<Cancion> ();
		}

		/** 
		* Agrega una nueva cancion a la lista interna, no lo registra 
		* dentro de la base de datos.
		*/
		public void agregar (Cancion c) {
			canciones.add (c);
		}

	}

	/**
	* Clase que permite manipular todas las operaciones posibles con albums 
	* músicales dentro de la base de datos, tanto las relaciones con otras
	* tablas, como la propia
	*/
	public class AlbumsMusicales : Object, Filtrable {

		private static AlbumsMusicales instancia;
		private TablaAlbumCanciones albums;
		private AlbumsCanciones album_y_canciones;

		private AlbumsMusicales () {
			albums = TablaAlbumCanciones.get_instancia ();
			album_y_canciones = AlbumsCanciones.get_instancia ();
		}

		public static AlbumsMusicales get_instancia () {
			if (instancia == null) 
				instancia = new AlbumsMusicales ();
			
			return instancia;
		}

		public AlbumCanciones registrar (AlbumCanciones ac) {
			return albums.agregar (ac);
		}

		public AlbumCanciones eliminar (AlbumCanciones ac) {
			album_y_canciones.eliminar_relaciones_album(ac);
			return albums.eliminar (ac);
		}

		public bool editar (AlbumCanciones ac) {
			return albums.editar (ac);	
		}

		public void llenar_album_canciones (out AlbumCanciones ac) {
			ac.canciones = album_y_canciones.canciones_por_id_album (ac.id); 
		}

		public int get_total_albums () {
			return albums.get_total_albums ();
		}

		public AlbumCanciones get_album_por_id (int64 id) {
			return albums.get_album_id (id);
		}

		public Gee.ArrayList<AlbumCanciones> buscar_albums_por_nombre (string nombre="", int lim=0) {
			return albums.buscar (nombre, lim);
		}

		public bool agregar_cancion_album(Cancion c, AlbumCanciones album) {
			if (album_y_canciones.relaciona(album, c))
				album.agregar(c);
			else
				return false;
			return true;
		}

		public bool eliminar_cancion_album(Cancion c, AlbumCanciones album) {
			if (album_y_canciones.elimina_relacion(album, c))
				album.canciones.remove(c);
			else
				return false;
			return true;
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

            foreach (AlbumCanciones a in albums ) {
                model.append (out iter);
                model.set (iter, 0, cargar_icono_ubicacion(a.caratula, AppGUI.TAM_ICONO, AppGUI.TAM_ICONO),
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

	/** 
	* Clase que modela las operaciones que se pueden realizar con la
	* tabla de la base de datos para los objetos del tipo Album
	*/
	internal class TablaAlbumCanciones : Tablas {
		
		private static TablaAlbumCanciones instancia = null;

		private TablaAlbumCanciones () {
			set_nombre_tabla ("album_cancion");
		}

		/** Devuelve un singleton de la tabla */
		internal static TablaAlbumCanciones get_instancia () {
			if (instancia == null)
				instancia = new TablaAlbumCanciones ();

			return instancia;
		}

		/**
		* Agrega una album nueva a la base de datos 
		*/
		internal AlbumCanciones agregar (AlbumCanciones album) {
			Sqlite.Statement query;
			string sql = "INSERT INTO %s (nombre, caratula, popularidad, descripcion) ".printf (nombre_tabla)
	            + "VALUES (?, ?, ?, ?)";
        	int res = bd.prepare_v2 (sql,-1, out query);
        	assert (res == Sqlite.OK);

        	album.descripcion = (album.descripcion == null) ? "Sin descripcion" : album.descripcion;
        	album.caratula = (album.caratula == null) ? Generador.caratula_aleatoria() : album.caratula;
	       
	        res = query.bind_text (1, album.nombre);
	        assert (res == Sqlite.OK);
	        res = query.bind_text (2, album.caratula);
	        assert (res == Sqlite.OK);
	        res = query.bind_double (3, album.popularidad);
	        assert (res == Sqlite.OK);
	        res = query.bind_text (4, album.descripcion);
	        assert (res == Sqlite.OK);
	             	        
	        res = query.step ();
	        if (res != Sqlite.DONE) 
	        	return null;
	    	album.id = bd.last_insert_rowid ();
       
	        return album;

		}

		internal AlbumCanciones eliminar (AlbumCanciones p) throws ErrorBaseDatos {
			assert (p.id != -1);

			if (!eliminar_celda_por_id (p.id))
				throw new ErrorBaseDatos.CONSULTA ("No se pudo eliminar a %s".printf (p.nombre));

			p.id = -1;
			return  p;

		}

		internal Gee.ArrayList<AlbumCanciones> buscar (string busqueda, int limite) {
			return get_albums ("nombre LIKE '%" + busqueda + "%'", limite);
		}

		internal bool editar (AlbumCanciones album) {
			if (!album.es_valido())
				return false;
			string columnas = "nombre=?, caratula=?, popularidad=?, descripcion=?";
			Sqlite.Statement query;

			string sql = "UPDATE %s SET %s WHERE id=?".printf (nombre_tabla, columnas);

			int res = bd.prepare_v2 (sql, -1, out query);
			assert (res == Sqlite.OK);

			res = query.bind_text (1, album.nombre);
			assert (res == Sqlite.OK);
			res = query.bind_text (2, album.caratula);
			assert (res == Sqlite.OK);
			res = query.bind_double (3, album.popularidad);
			assert (res == Sqlite.OK);
			res = query.bind_text (4, album.descripcion);
			assert (res == Sqlite.OK);
			res = query.bind_int64 (5, album.id);
			assert (res == Sqlite.OK);

			res =  query.step ();
			return (res == Sqlite.DONE);
		}

		internal AlbumCanciones get_album_id (int64 id) {
			Sqlite.Statement query;
			if (!existe_id(id))
				return null;

			string sql = "SELECT %s FROM %s WHERE id=?".printf ("*", nombre_tabla);
	
			int res = bd.prepare_v2 (sql, -1, out query);
			assert (res == Sqlite.OK);

			res = query.bind_int64 (1, id);
			assert (res == Sqlite.OK);

			res = query.step ();
			assert (res == Sqlite.ROW);
				
		    AlbumCanciones celda = new AlbumCanciones ();

    		celda.id = query.column_int64 (0);
            celda.nombre = query.column_text (1);
            celda.caratula = query.column_text (2);
            celda.popularidad = query.column_double (3);
            celda.descripcion = query.column_text (4);

            return celda;
		}

		internal int get_total_albums () {
			return get_total_celdas ();
		}

		internal Gee.ArrayList<AlbumCanciones> get_albums (string where = "1", int limite = 0, string orden="popularidad") {
			assert (limite >= 0);
			Sqlite.Statement query;

			string sql = "SELECT id, nombre, caratula, popularidad, descripcion "
            + "FROM %s WHERE %s ORDER BY %s DESC".printf (nombre_tabla, where, orden);

        	int res = bd.prepare_v2 (sql, -1, out query);
        	assert (res == Sqlite.OK);

        	Gee.ArrayList<AlbumCanciones> albums =  new Gee.ArrayList<AlbumCanciones> ();

        	while ( (res = query.step ()) == Sqlite.ROW) {

        		if (limite != 0 && albums.size == limite)
        			break;

        		AlbumCanciones celda = new AlbumCanciones ();

        		celda.id = query.column_int64 (0);
	            celda.nombre = query.column_text (1);
	            celda.caratula = query.column_text (2);
	            celda.popularidad = query.column_double (3);
	            celda.descripcion = query.column_text (4);;
	            
	            albums.add (celda);
	        }

        	return albums;
        }
		
	}

	/**
	* Modela la relacion que existe entre los albums y las canciones
	* se mantiene un sentido bidereccional, para mantener la 
	* bidireccionalidad de la relacion.
	*/
	internal class AlbumsCanciones : Relacion {

		private static AlbumsCanciones instancia;

		private AlbumsCanciones () {
			set_nombre_tabla ("r_album_cancion");
			set_llave ("id_album");
			set_puerta ("id_cancion");
			set_tabla_llave ("album_cancion");
			set_tabla_puerta ("archivos");
		}

		internal static AlbumsCanciones get_instancia () {
			if (instancia == null) 
				instancia = new AlbumsCanciones ();
			
			return instancia;
		}

		internal bool relaciona (AlbumCanciones album, Cancion cancion) {
			return relaciona_ids (album.id, cancion.id);
		}

		internal bool elimina_relacion(AlbumCanciones album, Cancion cancion) {
			return eliminar_relacion(album.id, cancion.id);
		}

		internal void eliminar_relaciones_album (AlbumCanciones album) {
			eliminar_relaciones_id (album.id);
		}

		internal void eliminar_relaciones_cancion (Cancion cancion) {
			eliminar_relaciones_secundarias_id (cancion.id);
		}

		internal Gee.ArrayList<Cancion> canciones_por_id_album (int64 album_id) {
			Sqlite.Statement query;

			string sql = "SELECT id, nombre, ubicacion, tipo, ultimoAcceso, popularidad, disponible "
            + "FROM %s WHERE id IN ( SELECT %s FROM %s WHERE %s=%lld) ".printf (tabla_puerta, puerta, nombre_tabla,llave, album_id );

        	int res = bd.prepare_v2 (sql, -1, out query);
        	assert (res == Sqlite.OK);

        	Gee.ArrayList<Cancion> archivos =  new Gee.ArrayList<Cancion> ();

        	while ( (res = query.step ()) == Sqlite.ROW) {

        		Cancion c = new Cancion ();

	            c.id = query.column_int64 (0);
				c.nombre = query.column_text (1);
				c.ubicacion = query.column_text (2);
				c.tipo  = query.column_text (2);
				c.u_acceso = query.column_text (2);
				c.popularidad = query.column_double (3);
				c.disponible = (query.column_int (2) == 0);
	            
	            archivos.add (c);
	        }

        	return archivos;
		}

	}
}