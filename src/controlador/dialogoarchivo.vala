namespace GraphMedia.Modelos {
    
    [GtkTemplate (ui = "/org/gtk/graphmedia/dialogoarchivo.ui")]
    public class DialogoArchivo: Gtk.Dialog {

        [GtkChild]
        Gtk.Entry nombre_archivo;
        [GtkChild]
        Gtk.Entry descripcion;
        [GtkChild]
        Gtk.ComboBoxText seleccionar_album;
        [GtkChild]
        Gtk.ComboBoxText seleccionar_artista;
        [GtkChild]
        Gtk.Button guardar;
        [GtkChild]
        Gtk.Entry artista;
         [GtkChild]
        Gtk.Entry album;



        private Archivo tmp;
        private string ruta_imagen;

        private AlbumsMusicales albums;
        private Artistas artistas;
        private Canciones canciones;

        private int64 artista_id;
        private int64  album_id;


        private const int TAM_ICONO = 170;
            
        public DialogoArchivo(AppGUI window, Archivo p, bool generico) {
            GLib.Object (transient_for: window,
                        use_header_bar: 1 );
                ruta_imagen  = "src/ui/images/0.jpg";

            if (p.es_valido())
                cargar_archivo(p);
            GLib.warning(p.id.to_string() + " --- " + p.nombre);

            AppGUI.archivo_actual = tmp = p;

            albums = AlbumsMusicales.get_instancia(); 
            artistas = Artistas.get_instancia(); 
            canciones =  Canciones.get_instancia();

            llenar_opciones(); 
            llenar_opciones_artistas(); 


            guardar.sensitive = false;
        }

        [GtkCallback]
        public void valida_archivo() {
            guardar.sensitive |= true;
        }

     

        private void llenar_opciones(){
            // Create & fill a ListStore:
            Gtk.ListStore list_store = new Gtk.ListStore (2, typeof (string), typeof (int64));
            Gtk.TreeIter iter = new Gtk.TreeIter();
            var als = albums.buscar_albums_por_nombre();

            foreach (AlbumCanciones a in als ) {
                list_store.append (out iter);
                list_store.set (iter, 0, a.nombre, 1, a.id);
            }

            seleccionar_album.changed.connect(()=>{
                seleccionar_album.get_active_iter(out iter);
                Value val1;
                Value val2;

                list_store.get_value (iter, 0, out val1);
                list_store.get_value (iter, 1, out val2);

                album_id =  (int64) val2;
                });

            seleccionar_album.set_model(list_store);

        }

        private void llenar_opciones_artistas(){
            // Create & fill a ListStore:
            Gtk.ListStore list_store = new Gtk.ListStore (2, typeof (string), typeof (int64));
            Gtk.TreeIter iter =  new Gtk.TreeIter();
            var artistas = artistas.buscar_artistas_por_nombre("");
            foreach (Artista a in artistas ) {
                list_store.append (out iter);
                list_store.set (iter, 0, a.nombre, 1, a.id);
            }

            seleccionar_artista.changed.connect(()=>{
                seleccionar_artista.get_active_iter(out iter);
                Value val1;
                Value val2;

                list_store.get_value (iter, 0, out val1);
                list_store.get_value (iter, 1, out val2);

                artista_id =  (int64) val2;
                });

        
            seleccionar_artista.set_model(list_store);

        }



        [GtkCallback]
        public void on_cambiar_imagen_clicked() {
            string ubicacion  = seleccionar_ubicacion("Seleccionar ubicacion del archivo");

            descripcion.set_text(ubicacion);
            descripcion.set_editable(false);
            string[] detalles = ubicacion.split("/");
            nombre_archivo.set_text(detalles[detalles.length-1]);
            guardar.sensitive |= true;
        }

        [GtkCallback]
        private void guardar_archivo() {

            valida_archivo(); 
            tmp.nombre = nombre_archivo.get_text();
            tmp.ubicacion = descripcion.get_text();
            tmp.actualizar_u_acceso();

            canciones.agregar(tmp as Cancion);

            if (artista_id > 0 && album_id > 0) {
                var ar = artistas.get_artista_por_id(artista_id);
                var al = albums.get_album_por_id(album_id);
                artistas.agregar_album_artista(ar, al);
                
                albums.agregar_cancion_album(tmp as Cancion, al);
            }

            
            guardar.sensitive = false;

        }

        public Archivo get_archivo() {
            return tmp;
        }


        private string seleccionar_ubicacion(string titulo) {
            var dialogo = new Gtk.FileChooserDialog(titulo, this,
                                Gtk.FileChooserAction.OPEN,
                                 _("_Cancelar"), Gtk.ResponseType.CANCEL,
                                _("_Abrir"), Gtk.ResponseType.ACCEPT);

            int res = dialogo.run();
            string archivo = dialogo.get_filename();
            ruta_imagen = archivo;
            dialogo.destroy();

            if (res != Gtk.ResponseType.ACCEPT)
                archivo = "";
            return archivo;

        }

        private void cargar_archivo(Archivo p) {

            nombre_archivo.set_text(p.nombre);
            descripcion.set_text(p.ubicacion);
            
        }
    }



}