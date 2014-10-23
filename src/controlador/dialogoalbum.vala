namespace GraphMedia.Modelos {
    
    [GtkTemplate (ui = "/org/gtk/graphmedia/dialogoalbums.ui")]
    public class DialogoAlbum: Gtk.Dialog {

        [GtkChild]
        Gtk.Entry nombre_albums;
        [GtkChild]
        Gtk.Entry descripcion;
        
        [GtkChild]
        Gtk.Image album_imagen;
        [GtkChild]
        Gtk.Button guardar;

        private Album tmp;
        private string ruta_imagen;


        private const int TAM_ICONO = 170;
            
        public DialogoAlbum(AppGUI window, Album p, bool generico) {
            GLib.Object (transient_for: window,
                        use_header_bar: 1 );
                ruta_imagen  = "src/ui/images/0.jpg";

            if (p.es_valido())
                cargar_albums(p);
            GLib.warning(p.id.to_string() + " --- " + p.nombre);

            AppGUI.album_actual = tmp = p;

            guardar.sensitive = false;
        }

        [GtkCallback]
        public void valida_albums() {
            guardar.sensitive |= true;
        }


        [GtkCallback]
        public void on_cambiar_imagen_clicked() {
            album_imagen.set_from_pixbuf(cargar_imagen("Seleccionar imagen para la persona"));
            guardar.sensitive |= true;
        }

        [GtkCallback]
        private void guardar_albums() {

            valida_albums();
            tmp.nombre = nombre_albums.get_text();
            tmp.descripcion = descripcion.get_text();
            if (tmp is AlbumCanciones)
                (tmp as AlbumCanciones).caratula = ruta_imagen;

            AppGUI.album_actual = tmp;
            
            guardar.sensitive = false;

        }

        public Album get_albums() {
            return tmp;
        }


        private Gdk.Pixbuf? cargar_imagen(string titulo) {
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

            if (!FileUtils.test(archivo, FileTest.IS_REGULAR))
                archivo = "src/ui/images/0.jpg";
            return new Gdk.Pixbuf.from_file_at_size (archivo, TAM_ICONO, TAM_ICONO);
        }

        private void cargar_albums(Album p) {

            nombre_albums.set_text(p.nombre);
            descripcion.set_text(p.descripcion);
            
            if (p is AlbumCanciones)
                album_imagen.set_from_pixbuf(new Gdk.Pixbuf.from_file_at_size((p as AlbumCanciones).caratula, 
                                            TAM_ICONO, TAM_ICONO));

        }
    }



}