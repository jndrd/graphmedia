
namespace GraphMedia.Modelos {

	public errordomain ErrorBD {
		NO_EXISTE;	
	}

	public class Artista : Persona {	
		private const string TIPO = "artista";

		public Artista() {
			base.id = -1;
			base.rol = TIPO;
		}
	}


	public class Artistas : TablaPersonas, Filtrable {

		private TablaPersonas personas;
		private ArtistaAlbum albums;
		private ArtistaCanciones canciones;
		private static Artistas instancia;

		private Artistas () {
			albums = ArtistaAlbum.get_instancia();
			canciones = ArtistaCanciones.get_instancia();
			personas = TablaPersonas.get_instancia();
		}

		public  static Artistas get_instancia() {
			if (instancia == null)
				instancia = new Artistas();

			return instancia;
		}

		public new Artista agregar(Artista artista) {
			return personas.agregar(artista) as Artista;
		}

		public new Artista eliminar(Artista artista) {
			personas.eliminar(artista);

			canciones.eliminar_relaciones_artista(artista);

			albums.eliminar_relaciones_artista(artista);

			artista.id = -1;

			return artista;
		}

		public new bool editar(Artista artista) {
			return personas.editar(artista);
		}

		public int get_total_artistas() {
			return get_total_celdas("rol='artista'");
		}

		private Gee.ArrayList<Artista> get_artistas(string where = "1", int lim = 0) {
			Gee.ArrayList<Artista> artistas = new  Gee.ArrayList<Artista>();

			var personas = get_personas(where, lim);
			
			foreach (Persona p  in personas) {
				Artista a =  Persona.cast_artista(p);
				artistas.add(a);
			}

			return artistas;
		}

		public Artista get_artista_por_id(int64 id) throws Error {
			Persona persona = get_persona_id(id);
			if (persona == null)
				throw new ErrorBD.NO_EXISTE("No se encontro la persona");

			return Persona.cast_artista(persona);
		}


		public Gee.ArrayList<Artista> buscar_artistas_por_nombre(string nombre, int lim = 0) {
			return get_artistas(" nombre LIKE '%" + nombre +"%'", lim);
		}

		public Gee.ArrayList<Album> get_albums_artista(Artista artista) {
			return albums.albums_por_artista(artista);
		}

		public void agregar_album_artista(Artista artista, AlbumCanciones album) {
			albums.relaciona(artista, album);
		}

		public  Gtk.IconView filtrar(string consulta, int lim) {
		 	var personas = buscar_artistas_por_nombre(consulta,lim);

		 	Gtk.ListStore model = new Gtk.ListStore (3, typeof (Gdk.Pixbuf), 
		 									typeof (string), typeof (int64));
            
            Gtk.IconView vista = new Gtk.IconView.with_model (model);
            vista.set_pixbuf_column (0);
            vista.set_text_column (1);
            vista.set_item_width(120);

            Gtk.TreeIter iter =  Gtk.TreeIter();

            foreach (Persona a in personas ) {
                model.append (out iter);
                model.set (iter, 0, cargar_icono_ubicacion(a.imagen,AppGUI.TAM_ICONO, AppGUI.TAM_ICONO),
                                1, a.nombre + " (" + a.rol +")",
                                2, a.id);

            }

           return vista;

		 }
	}


	internal class ArtistaAlbum : Relacion {
		
		private static ArtistaAlbum instancia;

		private ArtistaAlbum() {
			set_nombre_tabla("r_artista_album");
			set_llave("id_artista");
			set_puerta("id_album");
			set_tabla_puerta("album_cancion");

		}

		public static ArtistaAlbum get_instancia() {
			if (instancia == null) 
				instancia =  new ArtistaAlbum();
			
			return instancia;
		}

		internal void relaciona(Artista artista, AlbumCanciones album) {
			relaciona_ids(artista.id, album.id);
		}	

		internal void eliminar_relaciones_artista(Artista artista) {
			eliminar_relaciones_id(artista.id);
		}

		internal int n_albums_por_artista(Artista artista) {
			return total_relaciones_llave(artista.id);
		}

		internal Gee.ArrayList<AlbumCanciones> albums_por_artista (Artista artista) {
			assert (artista.es_valida());

			Sqlite.Statement query;

			string sql = "SELECT id, nombre, caratula, popularidad, descripcion "
            + "FROM %s WHERE id IN ( SELECT id_album FROM %s WHERE id_artista=%lld) ".printf(tabla_puerta, nombre_tabla, artista.id );

        	int res = bd.prepare_v2(sql, -1, out query);
        	assert(res == Sqlite.OK);

        	Gee.ArrayList<AlbumCanciones> albums =  new Gee.ArrayList<AlbumCanciones>();

        	while ((res = query.step()) == Sqlite.ROW) {

        		AlbumCanciones celda = new AlbumCanciones();

        		celda.id = query.column_int64(0);
	            celda.nombre = query.column_text(1);
	            celda.caratula = query.column_text(2);
	            celda.popularidad = query.column_double(3);
	            celda.descripcion = query.column_text(5);
	            
	            albums.add(celda);
	        }

        	return albums;
		}

	}

	internal class ArtistaCanciones : PersonaArchivo {

		private static ArtistaCanciones instancia;
		private PersonaArchivo personas_archivos;

		private ArtistaCanciones() {
			personas_archivos = PersonaArchivo.get_instancia();
		}

		public static ArtistaCanciones get_instancia() {
			if (instancia == null)
				instancia = new ArtistaCanciones();

			return instancia;
		}

		public Gee.ArrayList<Cancion> canciones_por_artista(Artista artista) {
			Gee.ArrayList<Archivo> archivos = personas_archivos.archivos_por_persona(artista);
			assert (archivos != null);

			Gee.ArrayList<Cancion> canciones =  new  Gee.ArrayList<Cancion>();

			foreach (Archivo a in archivos) 
				canciones.add(Archivo.cast_cancion(a));
			
			return canciones;
		}

		public void  eliminar_relaciones_artista(Artista a) {
			eliminar_relaciones_persona(a);
		}
	}

}