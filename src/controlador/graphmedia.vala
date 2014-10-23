namespace GraphMedia.Modelos {
	
	public class GraphMediaApp : Gtk.Application {

		public static string ubicacion_bd = "src/test/base_prueba.db";
		private AppGUI window;

		public GraphMediaApp () { 
			application_id = "org.gtk.graphmedia";
			flags |= ApplicationFlags.HANDLES_OPEN;
		}

		public override void activate () {
			window = new AppGUI (this);
			window.present();
		}

		public override void open (File[] files,
									string 	hint) {
			if (window == null)
				window =  new AppGUI (this);

           foreach (var file in files)
                window.open (file);

			window.present	();
		}

		private void preferences () {
            var prefs = new AppPreferences (window);
            prefs.present ();
        }

		public override void startup () {
            base.startup ();

            var action = new GLib.SimpleAction ("preferences", null);
            action.activate.connect (preferences);
            add_action (action);

            action = new GLib.SimpleAction ("quit", null);
            action.activate.connect (quit);
            add_action (action);
            add_accelerator ("<Ctrl>Q", "app.quit", null);
            
            var builder = new Gtk.Builder.from_resource ("/org/gtk/graphmedia/app-menu.ui");
            var app_menu = builder.get_object ("appmenu") as GLib.MenuModel;

            set_app_menu (app_menu);


        }



	}
} 
