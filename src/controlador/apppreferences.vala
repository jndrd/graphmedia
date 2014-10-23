namespace GraphMedia.Modelos {
	
	[GtkTemplate (ui = "/org/gtk/graphmedia/prefs.ui")]
    public class AppPreferences : Gtk.Dialog {

        private GLib.Settings settings;

        [GtkChild]
        private Gtk.FontButton font;

        [GtkChild]
        private Gtk.ComboBoxText transition;

        public AppPreferences (AppGUI window) {
            GLib.Object (transient_for: window);

            settings = new GLib.Settings ("org.gtk.graphmedia");
            settings.bind ("font", font, "font",
                           GLib.SettingsBindFlags.DEFAULT);
            settings.bind ("transition", transition, "active-id",
                           GLib.SettingsBindFlags.DEFAULT);


        }
    }


}