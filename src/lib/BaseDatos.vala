/**
* Clase que permite establecer una BaseDatos con la base de 
* datos de sqlite y ejecutar consultas
*/

using Sqlite;
using Gee;
using GraphMedia.Modelos;

namespace GraphMedia {

	public errordomain ErrorBaseDatos {
		ARCHIVO_NO_ENCONTRADO,
		ARCHIVO_INVALIDO,
		ERROR_CONSULTA
	}

	/**
	* Clase encargada  de manejar la conexion entre la base de datos
	* y los modelos del sistema, realiza las consultas, y actualiza los objetos 
	* y registros.
	*/
	public class BaseDatos : Object {
		private string NOMBRE_BDD;
		private Database bdd;

		/**
		* Constructor por defecto, recibe el nombre de un archivo 
		* y crea una nueva BaseDatos con el 
		*/
		public BaseDatos (string nombre_archivo) throws ErrorBaseDatos { 
			int celdas = 0;
			this.NOMBRE_BDD = nombre_archivo;
			
			if (!FileUtils.test(nombre_archivo, FileTest.IS_REGULAR))
				throw new ErrorBaseDatos.ARCHIVO_NO_ENCONTRADO("No se encontro el arhivo");
			/* Abrimos el archivo despues de ver que era valido */
			celdas = Database.open(nombre_archivo, out bdd);
			
			if (celdas != Sqlite.OK)
				throw new ErrorBaseDatos.ARCHIVO_INVALIDO("El archivo " + nombre_archivo + " no es válido");
		}
	}
