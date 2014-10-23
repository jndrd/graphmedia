using Gee;

namespace GraphMedia{
	public class Localizador : Object {

		public LinkedList<string> archivos { get; private set;}

		public Localizador() {
			this.archivos = new LinkedList<string>();
			ejecutar_comando("locate *.mp3");
		} 

		public LinkedList<Cancion> buscar_canciones() {
			LinkedList<Cancion> canciones =  new LinkedList<Cancion>();
			ejecutar_comando("locate *.mp3 *.acc *.ogg");
			foreach (string s in archivos ) {
				if(s != "")
					canciones.add(new Cancion(s));
			}
			return canciones;	
		}

		private void ejecutar_comando(string cmd) {
			try {
				string salida, error;
				int estado;
				Process.spawn_command_line_sync(cmd, out salida, out error, out estado);
				string [] arch = salida.split("\n");
				foreach (unowned string s in arch ) {
					archivos.add(s);
				}

			} catch (Error e) {
				
			}
		}


	}
}