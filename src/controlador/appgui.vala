namespace GraphMedia.Modelos {

     [GtkTemplate (ui = "/org/gtk/graphmedia/window.ui")]
    public class AppGUI : Gtk.ApplicationWindow {

        [GtkChild]
        private Gtk.Stack stack;
        [GtkChild]
        private Gtk.ToggleButton search;
        [GtkChild]
        private Gtk.StackSwitcher tabs;
        [GtkChild]
        private Gtk.SearchBar searchbar;
        [GtkChild]
        private Gtk.SearchEntry busqueda;
        [GtkChild]
        private Gtk.Revealer sidebar;
        [GtkChild]
        private Gtk.Box hbox;
        [GtkChild]
        private Gtk.Button next;
        [GtkChild]
        private Gtk.Button previous;
        [GtkChild]
        private Gtk.Box sidebar_container;
        

        private Gtk.ListBox consultas;

        private GLib.Settings settings;
        private BaseDatos base_de_datos;
        
        private Artistas artistas;
        private Imagenes imagenes;
        private Canciones canciones;
        private Sentimientos sentimientos;
        private AlbumsMusicales albums_musicales;
        private AlbumsImagenes albums_imagenes;

        private Gee.ArrayList<AlbumCanciones> v_albums_canciones;
        private Gee.ArrayList<Persona> v_personas;
        private Gee.ArrayList<Imagen>  v_imagenes;

        private Queue<Gtk.IconView> vistas;
        private Filtrable vista_actual;

        private Generador gen;
        public static int64 index_actual;
        public static const int TAM_ICONO = 170;
        private const int LIM = 20;

        private string [] pestanias;
        private string ubicacion_actual;

        public static Persona persona_actual;
        public static Album album_actual;
        public static Archivo archivo_actual;

        public AppGUI (Gtk.Application application) {
            GLib.Object (application: application);
                         
            base_de_datos = new BaseDatos();
            base_de_datos.seleccionar_archivo(GraphMediaApp.ubicacion_bd);
            base_de_datos.inicializar();

            artistas = base_de_datos.get_artistas();
            imagenes = base_de_datos.get_imagenes();
            canciones = base_de_datos.get_canciones();
            sentimientos = base_de_datos.get_sentimientos();
            albums_musicales = base_de_datos.get_albums_musicales();
            albums_imagenes = base_de_datos.get_albums_imagenes();

            vistas = new Queue<Gtk.IconView>();
            pestanias = {"Inicio", "Música", "Imágenes", "Sentimientos"};
            iniciar_interfaz();
       }

        public void open (GLib.File file) {

            base_de_datos = new BaseDatos();
            base_de_datos.seleccionar_archivo(GraphMediaApp.ubicacion_bd);
            base_de_datos.inicializar();

            artistas = base_de_datos.get_artistas();
            imagenes = base_de_datos.get_imagenes();
            canciones = base_de_datos.get_canciones();
            sentimientos = base_de_datos.get_sentimientos();
            albums_musicales = base_de_datos.get_albums_musicales();
            albums_imagenes = base_de_datos.get_albums_imagenes();

            vistas = new Queue<Gtk.IconView>();
            pestanias = {"Inicio", "Música", "Imágenes", "Sentimientos"};
            iniciar_interfaz();

        }

        private void musica_mostrar_albums () {
            limpiar_lienzo();
            var v = vista_albums("", 20);
            ubicacion_actual = "Música.albums";
            vista_actual = albums_musicales;
            llenar_pestania(stack.get_visible_child() as Gtk.Box,v );
        } 


        private void musica_mostrar_artistas () {
            limpiar_lienzo();
            var v = vista_artistas("", 20);
            ubicacion_actual = "Música.artistas";
            vista_actual = artistas;
            llenar_pestania(stack.get_visible_child() as Gtk.Box,v );
        }

        private void musica_mostrar_canciones () {
            limpiar_lienzo();
            var v = vista_canciones("",20);
            vista_actual = canciones;
            ubicacion_actual = "Música.canciones";
            llenar_pestania(stack.get_visible_child() as Gtk.Box,v );
        }

        private void musica_eliminar () {
            if(index_actual == -1)
                return;
            GLib.warning("Musica.eliminar %s".printf(ubicacion_actual));
            switch (ubicacion_actual) {
                case "Música.albums":
                    eliminar_albums();
                    musica_mostrar_albums();
                    break;

                case "Música.artistas":
                    eliminar_artista();
                    musica_mostrar_artistas();
                    break;

                case "Música.canciones":
                    eliminar_cancion();
                    musica_mostrar_canciones();
                    break;
                
                
            }
        }

        private void musica_editar () {
            if(index_actual == -1)
                return;
            try {
                switch (ubicacion_actual) {
                case "Música.albums":
                    editar_album();
                    musica_mostrar_albums();
                    break;

                case "Música.artistas":
                    editar_artista();
                    musica_mostrar_artistas();
                    break;

                case "Música.canciones":
                    editar_cancion();
                    musica_mostrar_canciones();
                    break;
              
                }
                
            } catch (Error e) {
                GLib.warning("Musica.editar %s".printf(ubicacion_actual));

            }
            
        }

        private void musica_agregar () {
            switch (ubicacion_actual) {
                case "Música.albums":
                    agregar_album();
                    musica_mostrar_albums();
                    break;

                case "Música.artistas":
                    agregar_artistas();
                    musica_mostrar_artistas();
                    break;

                case "Música.canciones":
                    agregar_canciones();
                    musica_mostrar_canciones();
                    break;
                
                
            }
        }


        [GtkCallback]
        public void visible_child_changed () {
            string pestania = stack.get_visible_child_name();

            if (pestania == "Inicio") 
                sidebar.set_visible(false);
            else
                sidebar.set_visible(true);

            var padre = stack.get_visible_child() as Gtk.Box;
            uint n = padre.get_children().length();

            string nombre = stack.get_visible_child_name();

            if (n == 0) {

                switch (nombre) {   
                    case "Inicio":
                        vista_actual = artistas;
                        cargar_inicio();
                        break;  
                    case "Música":
                        musica_mostrar_albums();
                        ubicacion_actual = nombre;
                        vista_actual = albums_musicales;
                        musica_mostrar_albums();
                        break;
                    case "Imágenes":
                        llenar_pestania(padre, vista_imagenes());
                        ubicacion_actual = nombre;
                        vista_actual = imagenes;
                        break;
                    case "Sentimientos":
                        llenar_pestania(padre, vista_imagenes());
                        ubicacion_actual = nombre;
                        vista_actual = sentimientos;
                        break;
                    
                }

            }

            switch (nombre) {
                case "Inicio":
                    break;
                case "Música":
                    cargar_contexto_musica();
                    break;
                case "Imágenes":
                    cargar_contexto_imagenes();
                    break;
                case "Sentimientos":
                    cargar_contexto_sentimientos();
                    break;
                
            }
        }

        [GtkCallback]
        public void search_text_changed () {
            var consulta = busqueda.get_text ();
            if (consulta == "")
                return;
            consulta = limpiar_sql(consulta);
            filtrar_vista(consulta);
            update_navigation();
        }

       [GtkCallback]
        public void on_previous_clicked () {
            var box = vistas.pop_head();
            
            if(box == null)
                previous.sensitive = false;

            limpiar_lienzo();
            var padre = stack.get_visible_child() as Gtk.Box;
            llenar_pestania(padre, box);

            update_navigation();
        }

        [GtkCallback]
        public void on_next_clicked () {
        }

        private void update_navigation () {
            if (vistas.is_empty())
                next.sensitive = previous.sensitive  = false;
            else if (vistas.get_length() == 1)
                previous.sensitive = true;
            else if (vistas.get_length() > 1)
                previous.sensitive = next.sensitive = true; 
        }

        public void musica_registar_cancion() {

        }

        private void cargar_contexto_musica() {
            limpiar_contexto();
            var builder = new Gtk.Builder.from_resource ("/org/gtk/graphmedia/context.ui");
            var inicio = builder.get_object ("contexto_musica") as Gtk.Box;
            
            var b1 = builder.get_object("mostrar_albums") as Gtk.Button;
            b1.clicked.connect(musica_mostrar_albums);

            var b2 = builder.get_object("mostrar_artistas") as Gtk.Button;
            b2.clicked.connect(musica_mostrar_artistas);

            var b3 = builder.get_object("mostrar_canciones") as Gtk.Button;
            b3.clicked.connect(musica_mostrar_canciones);

            var a1 = builder.get_object("registrar") as Gtk.Button;
            a1.clicked.connect(musica_agregar);

            var a2 = builder.get_object("editar") as Gtk.Button;
            a2.clicked.connect(musica_editar);

            var a3 = builder.get_object("eliminar") as Gtk.Button;
            a3.clicked.connect(musica_eliminar);

            inicio.show();
            sidebar_container.add(inicio);
        }

         private void cargar_contexto_imagenes() {
            limpiar_contexto();

            var builder = new Gtk.Builder.from_resource ("/org/gtk/graphmedia/context.ui");
            var im = builder.get_object ("contexto_imagenes") as Gtk.Box;

            //inicio.show();
            sidebar_container.add(im);
        }

        private void cargar_contexto_sentimientos() {
            limpiar_contexto();

            var builder = new Gtk.Builder.from_resource ("/org/gtk/graphmedia/context.ui");
            var stm = builder.get_object ("contexto_sentimientos") as Gtk.Box;

            stm.show();
            sidebar_container.add(stm);
        }

        private void limpiar_contexto() {
            var hijos = sidebar_container.get_children().nth_data(0);
            assert (hijos != null);
            sidebar_container.remove(hijos);
            sidebar_container.show();
        }

       
        private void crear_pestanias (string nombre) {

            Gtk.Box box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            box.show();
            stack.add_titled (box, nombre, nombre);
        }

        private void llenar_pestania(Gtk.Box contenedor, Gtk.IconView vistas){
            var scrolled = new Gtk.ScrolledWindow (null, null);
            scrolled.show ();
            scrolled.hexpand = true;
            scrolled.vexpand = true;

            vistas.show ();

            scrolled.add (vistas);
            contenedor.add(scrolled);
        }

        private void cargar_inicio() {
            var contenedor = stack.get_visible_child() as Gtk.Box;
            
            var albums = vista_albums("",6);
            var artistas = vista_artistas("",6);
            var canciones = vista_canciones("",6);
            var imagenes = vista_imagenes("",6);

            sidebar.set_visible(false);

            var builder = new Gtk.Builder.from_resource ("/org/gtk/graphmedia/home.ui");
            var inicio = builder.get_object ("contenedor_inicio") as Gtk.ScrolledWindow;
            inicio.show();

            var inicio_artistas = builder.get_object("inicio_artistas") as Gtk.ScrolledWindow;
            inicio_artistas.add(artistas);
            artistas.show();

            var inicio_canciones = builder.get_object("inicio_canciones") as Gtk.ScrolledWindow;
            inicio_canciones.add(canciones);
            canciones.show();

            var inicio_imagenes = builder.get_object("inicio_imagenes") as Gtk.ScrolledWindow;
            inicio_imagenes.add(imagenes);
            imagenes.show();


            var inicio_albums = builder.get_object("inicio_albums") as Gtk.ScrolledWindow;
            inicio_albums.add(albums);
            albums.show();

            contenedor.add(inicio);

        }

        private void iniciar_interfaz() {

            settings = new GLib.Settings ("org.gtk.graphmedia");

            var setting = Gtk.Settings.get_default();
            setting.gtk_application_prefer_dark_theme = true;

            settings.bind ("transition", stack, "transition-type",
                           GLib.SettingsBindFlags.DEFAULT);

            search.bind_property ("active", searchbar, "search-mode-enabled",
                                              GLib.BindingFlags.BIDIRECTIONAL);

            var builder = new Gtk.Builder.from_resource ("/org/gtk/graphmedia/home.ui");
            consultas = builder.get_object ("consultas") as Gtk.ListBox;


            sidebar.set_visible(false);
            search.sensitive = true;

            foreach (string nombre in pestanias ) {
                crear_pestanias(nombre);
            }

            vista_actual = null;
            cargar_inicio();  
            update_navigation();
        }

        private  Gtk.IconView vista_albums(string filtro= "", int lim=LIM) {
            assert (albums_musicales != null);
            var z =  albums_musicales.filtrar(filtro, lim);

            var model = z.get_model();
            z.selection_changed.connect (() => {

                Gtk.TreeIter iter = new Gtk.TreeIter();
                
                List<Gtk.TreePath> paths = z.get_selected_items ();
                if (paths == null)
                    return;
                var path = paths.nth_data(0);

                Value title;
                Value icon;
                Value index;
                
                bool tmp = model.get_iter (out iter, path);
                model.get_value (iter, 2, out index); 
                AppGUI.index_actual = (int64) index;

                detalles_album(index_actual);
            
            });
            return z;
        }

        private Gtk.IconView vista_artistas(string filtro="", int lim=LIM) {
            assert (artistas != null);
            var z =  artistas.filtrar(filtro,lim);

            var model = z.get_model();
            z.selection_changed.connect (() => {

                Gtk.TreeIter iter = new Gtk.TreeIter();
                
                List<Gtk.TreePath> paths = z.get_selected_items ();
                if (paths == null)
                    return;
                var path = paths.nth_data(0);

                Value title;
                Value icon;
                Value index;
                
                bool tmp = model.get_iter (out iter, path);
                model.get_value (iter, 2, out index); 
                AppGUI.index_actual = (int64) index;

                detalles_artistas(index_actual);
            
            });

            return z;
            
        }

        private Gtk.IconView vista_canciones(string filtro="", int lim=LIM) {
            assert (canciones != null);
            return canciones.filtrar(filtro,lim);
        }

        private Gtk.IconView vista_imagenes(string filtro="", int lim=LIM) {
            assert (imagenes != null);
            return imagenes.filtrar(filtro,lim);
        }

        private void detalles_album(int64 id) {
            var v = vista_albums("");
            vistas.push_head(v);

            limpiar_lienzo();
            update_navigation();
        }

        private void detalles_artistas(int64 id) {
            var v = vista_artistas("");
            vistas.push_head(v);

            var artista = artistas.get_artista_por_id(id);
            var albums  = artistas.get_albums_artista(artista);

            limpiar_lienzo();
            update_navigation();
        }



        private void agregar_artistas() {
            Artista a = new Artista();
            var dialogo = new Dialogo (this,a,true);
            int res = dialogo.run ();
            dialogo.destroy();

            var p = persona_actual;
            assert(p != null);
            persona_actual = artistas.agregar(Persona.cast_artista(p));
        }

         private void agregar_album() {
            AlbumCanciones albums = new AlbumCanciones();
            var dialogo = new DialogoAlbum(this,albums, true );
            dialogo.run();
            dialogo.destroy();
            albums = album_actual as AlbumCanciones;
            albums_musicales.registrar(albums);
            musica_mostrar_albums();
        }

         private void agregar_canciones() {
            Cancion cancion = new Cancion();
            var dialogo = new DialogoArchivo(this,cancion, true );
            dialogo.run();
            dialogo.destroy();
            cancion = archivo_actual as Cancion;
            canciones.agregar(cancion);
            musica_mostrar_canciones();
        }

        private bool confirmar(string proposision) {
            var dialog_question = new Gtk.MessageDialog(null,Gtk.DialogFlags.MODAL,Gtk.MessageType.QUESTION, Gtk.ButtonsType.YES_NO, proposision);
            int respuesta = dialog_question.run();
            if (respuesta == -8) {
                dialog_question.destroy();
                return true;
            }
            dialog_question.destroy();
            return false;
        }

        private void eliminar_artista() {
            Artista a = artistas.get_artista_por_id(index_actual);
            if (confirmar("Deseas eliminar al artista %s".printf(a.nombre)));
                artistas.eliminar(a);
        }

        private void eliminar_cancion () {
             Cancion a = canciones.get_cancion_por_id(index_actual);
            if (confirmar("Deseas eliminar la cancion %s ?".printf(a.nombre)))
                canciones.eliminar(a);
        }

        private void eliminar_albums () {
            AlbumCanciones a = albums_musicales.get_album_por_id(index_actual);
            if (confirmar("Deseas eliminar el albúm %s ?".printf(a.nombre)))
                albums_musicales.eliminar(a);
        }

        private void editar_artista() {
             assert (index_actual != -1);
            Artista a = artistas.get_artista_por_id(index_actual);

            var dialogo = new Dialogo (this,a,true);
            dialogo.run ();
            dialogo.destroy ();
     
            a = Persona.cast_artista(persona_actual);
           
            artistas.editar(a);
        }

        private void editar_cancion() {
            if (index_actual != -1)
                alerta("Selecciona una cancion");

            Cancion cancion = canciones.get_cancion_por_id(index_actual);
            var dialogo = new DialogoArchivo(this,cancion, true );
            dialogo.run();
            dialogo.destroy();
            musica_mostrar_canciones();
        }

        private void editar_album() {
            if(index_actual == -1)
                alerta("Selecciona un album");
            AlbumCanciones albums = albums_musicales.get_album_por_id(index_actual);
            if (albums == null)
                alerta("Album no encontrado");
            var dialogo = new DialogoAlbum(this,albums, true );
            dialogo.run();
            dialogo.destroy();
            albums = album_actual as AlbumCanciones;
            albums_musicales.editar(albums);
            musica_mostrar_albums();

        }

        private void filtrar_vista(string consulta) {
            if  (consulta.size() < 1)
                return;
            limpiar_lienzo();
            llenar_pestania(stack.get_visible_child() as Gtk.Box, vista_actual.filtrar(consulta, LIM));

        }

        private string limpiar_sql(string s) {
            s.down();
            var forbbiden = new Gee.HashMap<string,string>();

            forbbiden["drop"] = "drop";
            forbbiden["truncate"] = "truncate";
            forbbiden["delete"] = "delete";
            forbbiden["select"] = "select";

            string [] partes = s.split(" ");

            for (int i = 0; i < partes.length; i++) 
                if(partes[i] in forbbiden)
                    partes[i] = "";
            
            string limpio = string.joinv (" ", partes);
            limpio.replace("'", "\'");
            return limpio;
        }

        private void limpiar_lienzo() {
            var padre = stack.get_visible_child() as Gtk.Box;
            var hijos = padre.get_children();

            foreach (var hijo in hijos) {
                padre.remove(hijo);
            }
        } 

        private void recargar_lienzo() {
            var padre = stack.get_visible_child() as Gtk.Box;
            var hijos = padre.get_children();

            foreach (var hijo in hijos) {
                padre.remove(hijo);
            }

            var vista =  vista_albums("", 30);
            llenar_pestania(padre, vista);
        }

        private void alerta (string mensaje) {
            var dialog_warning = new Gtk.MessageDialog(null,Gtk.DialogFlags.MODAL,Gtk.MessageType.WARNING, Gtk.ButtonsType.OK, mensaje);
            dialog_warning.run();
            dialog_warning.destroy();
        }
    }

    public interface Filtrable : Object {

        public abstract Gtk.IconView filtrar(string consulta, int lim);

        public Gdk.Pixbuf cargar_icono_ubicacion(string ubicacion, int h, int w) {
            string u = ubicacion;
            if (!FileUtils.test(u, FileTest.IS_REGULAR))
                u = "src/ui/images/175.jpg";
            return new Gdk.Pixbuf.from_file_at_size (u, h, w);
        }
    }
    
}
