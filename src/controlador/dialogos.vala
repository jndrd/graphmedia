namespace GraphMedia.Modelos {
    
    [GtkTemplate (ui = "/org/gtk/graphmedia/dialogs.ui")]
    public class Dialogo: Gtk.Dialog {

        [GtkChild]
        Gtk.Entry nombre_persona;
        [GtkChild]
        Gtk.Entry nacionalidad;
        [GtkChild]
        Gtk.Entry rol;
        [GtkChild]
        Gtk.SpinButton edad;
        [GtkChild]
        Gtk.Image persona_imagen;
        [GtkChild]
        Gtk.Button guardar;

        private Persona tmp;
        private string ruta_imagen;


        private const int TAM_ICONO = 170;
            
        public Dialogo(AppGUI window, Persona p, bool generico) {
            GLib.Object (transient_for: window,
                        use_header_bar: 1 );
                ruta_imagen  = "src/ui/images/0.jpg";

            if (p.es_valida())
                cargar_persona(p);

            if (generico)
                rol.set_visible(true);

            AppGUI.persona_actual = tmp = p;

            guardar.sensitive = false;
        }

        [GtkCallback]
        public void valida_persona() {
            guardar.sensitive |= true;
        }


        [GtkCallback]
        public void on_cambiar_imagen_clicked() {
            persona_imagen.set_from_pixbuf(cargar_imagen("Seleccionar imagen para la persona"));
            guardar.sensitive |= true;
        }

        [GtkCallback]
        private void guardar_persona() {

            valida_persona();
            tmp.nombre = nombre_persona.get_text();
            tmp.edad = (int) edad.get_value();
            tmp.nacionalidad = nacionalidad.get_text();
            tmp.imagen = ruta_imagen;

            AppGUI.persona_actual = tmp;
            
            guardar.sensitive = false;

        }

        public Persona get_persona() {
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

        private void cargar_persona(Persona p) {
            persona_imagen.set_from_pixbuf(new Gdk.Pixbuf.from_file_at_size(p.imagen, 
                                            TAM_ICONO, TAM_ICONO));
            nombre_persona.set_text(p.nombre);
            nacionalidad.set_text(p.nacionalidad);
            edad.set_value(p.edad);

        }
    }

}