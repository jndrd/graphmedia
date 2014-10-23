namespace GraphMedia.Modelos {
	
	/**
	* Clase que modela las epocas para mejorar la organizacion de archivos
	* asi poder agruparlos por fechas y dar una mejor disposicion de la informacion
	*/
	public struct Epoca {

		private DateTime fecha;

		/**
		* Constructor que recibe un año, mes y dia para crear una nueva fecha
		* y crear relaciones entre los archivos
		*/

		public Epoca(int dia, int mes, int anio) {
			fecha = new DateTime.local(anio, mes, dia, 0, 0, 0);
		}

		public Epoca.cadena(string iso8601) {
			TimeVal t = TimeVal();
			t.from_iso8601 (iso8601);
			fecha = new DateTime.from_timeval_local(t);
		}

	

		/**
		* Compara dos epocas y determina si son del mismo año
		*/
		public bool mismo_anio(Epoca b) {
			return this.fecha.get_year() ==  b.fecha.get_year();
		}

		/**
		* Determina si dos epocas son del mismo mes y por ende, año
		*/
		public bool mismo_mes(Epoca b) {
			return this.fecha.get_month() ==  b.fecha.get_month();
		}

		/**
		* Compara dos fechas y determina si son de la mismo epocas 
		*/
		public bool mismo_dia(Epoca b) {
			return this.fecha.get_day_of_month() ==  b.fecha.get_day_of_month();
		}

		public string to_string() {
			return fecha.to_string();
		}
		

	}
}