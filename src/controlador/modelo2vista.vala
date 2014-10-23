namespace GraphMedia.Modelos {

	internal class Modelo2Vista {
		
		public static Gtk.IconView lista_artistas(Gee.ArrayList<Artista> lista_artistas, void) {

            Gtk.ListStore model = new Gtk.ListStore (3, typeof (Gdk.Pixbuf), typeof (string), typeof (int64));
            
            Gtk.IconView vista = new Gtk.IconView.with_model (model);
            vista.set_pixbuf_column (0);
            vista.set_text_column (1);
            vista.set_item_width(120);

            Gtk.TreeIter iter =  new Gtk.TreeIter();

            for (int i = 0; i < 20; i++) {
                model.append (out iter);
                model.set (iter, 0, cargar_icono_ubicacion("",170,170),
                                1, "asdasdsd",
                                2, 123132132);
            }

            foreach (Artista a in lista_artistas ) {
            	model.append (out iter);
                model.set (iter, 0, cargar_icono_ubicacion(a.imagen,TAM_ICONO, TAM_ICONO),
                                1, a.nombre,
                                2, a.id);

            }

            vista.selection_changed.connect (() => {
                List<Gtk.TreePath> paths = vista.get_selected_items ();
                var path = paths.nth_data(0);

                Value title;
                Value icon;
                Value index;
                
                bool tmp = model.get_iter (out iter, path);
                assert (tmp == true);

                    model.get_value (iter, 0, out icon); 
                    model.get_value (iter, 1, out title); 
                    model.get_value (iter, 2, out index); 

                    stdout.printf ("%s: %p - %lld \n", (string) title, ((Gdk.Pixbuf) icon), (int64) index);
            
            });

            return vista;
        
		}

	}

}