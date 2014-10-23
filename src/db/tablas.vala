/**
* Clase que permite establecer una BaseDatos con la base de 
* datos de sqlite y ejecutar consultas
*/

using Sqlite;
using Gee;

namespace GraphMedia.Modelos {

	public errordomain ErrorBaseDatos {
		ARCHIVO_NO_ENCONTRADO,
		ARCHIVO_INVALIDO,
		CONSULTA
	}

	public abstract class Tablas : Object {

		protected static Sqlite.Database bd;

		public string nombre_tabla;
	

		private static void abrir_base_datos ( string nombre_archivo) throws ErrorBaseDatos {
	      int celdas = 0;
			if (!FileUtils.test(nombre_archivo, FileTest.IS_REGULAR))
				throw new ErrorBaseDatos.ARCHIVO_NO_ENCONTRADO("No se encontro el arhivo");
			/* Abrimos el archivo despues de ver que era valido */
			celdas = Database.open(nombre_archivo, out bd);
			
			if (celdas != Sqlite.OK)
				throw new ErrorBaseDatos.ARCHIVO_INVALIDO("El archivo " + nombre_archivo + " no es válido");
		}

		public static void inicializar ( string archivo) {
			abrir_base_datos (archivo);
		}

		protected bool existe_id (int64 id) {
			Sqlite.Statement query;
	        int res = bd.prepare_v2 ("SELECT id FROM %s WHERE id=?".printf (nombre_tabla), -1, out query);
	        assert (res == Sqlite.OK);
	        
	        res = query.bind_int64 (1, id);
	        assert (res == Sqlite.OK);
	        
	        res = query.step ();
	        
	        return (res == Sqlite.ROW);
		}


		protected bool actualizar_celda_por_id (int64 id, string columnas) {
			Sqlite.Statement query;

			string sql = "UPDATE %s SET %s WHERE id=?".printf(nombre_tabla, columnas);
			stdout.printf(sql);

			int res = bd.prepare_v2(sql, -1, out query);
			assert(res == Sqlite.OK);

			res = query.bind_int64(2, id);
			assert(res == Sqlite.OK);

			res =  query.step();
			return (res == Sqlite.DONE);
		}

		protected bool eliminar_celda_por_id (int64 id) {
			Sqlite.Statement query;
			int res = bd.prepare_v2("DELETE FROM %s WHERE id=? ".printf(nombre_tabla), -1, out query);
			assert(res == Sqlite.OK);

			res = query.bind_int64(1, id);
			assert(res == Sqlite.OK);

			res = query.step();
			return (res == Sqlite.DONE);
		}

		protected int get_total_celdas (string columna = "1") {
			Sqlite.Statement query; 
			string sql = "SELECT COUNT(id) AS total FROM %s WHERE %s".printf(nombre_tabla, columna);

			int res = bd.prepare_v2(sql, -1, out query);
			assert(res == Sqlite.OK);

			res = query.step();
			if (res != Sqlite.ROW)
				return -1;
			return query.column_int(0);
		}

		protected bool insertar_celda (string columnas, string valores, out Sqlite.Statement query) {
			return false;
		}

		protected bool buscar_celdas (string colunmnas, string condiciones, out Sqlite.Statement query) {
			return false;
		}

		protected void set_nombre_tabla(string nombre_tabla) {
			this.nombre_tabla =  nombre_tabla;
		}
	}


	public abstract class Relacion : Tablas {

		protected string llave;
		protected string puerta;
		protected string tabla_llave;
		protected string tabla_puerta;
		
		private bool existe_relacion (int64 id1, int64 id2) {
			Sqlite.Statement query;
	        int res = bd.prepare_v2 ("SELECT %s,%s FROM %s WHERE %s=? AND %s=?".printf (llave, puerta, nombre_tabla, 
	        	llave, puerta), -1, out query);
	        assert (res == Sqlite.OK);
	        
	        res = query.bind_int64 (1, id1);
	        assert (res == Sqlite.OK);

	        res = query.bind_int64 (2, id2);
	        assert (res == Sqlite.OK);
	        
	        
	        res = query.step ();
	        return ( res == Sqlite.ROW);
		}

		protected void set_tabla_puerta(string columna) {
			this.tabla_puerta = columna;
		}

		protected void set_tabla_llave(string columna) {
			this.tabla_puerta = columna;
		}

		protected void set_llave(string columna) {
			this.llave = columna;
		}

		protected void set_puerta(string columna) {
			this.puerta = columna;
		}

		protected bool relaciona_ids(int64 id1, int64 id2) {

			Sqlite.Statement query;

			if (existe_relacion(id1, id2))
				return false;

			int res = bd.prepare_v2(
				"INSERT INTO %s (%s, %s) values (?,?)".printf(nombre_tabla, llave, puerta),
	           -1, out query);
			assert(res == Sqlite.OK);
       		
       		res = query.bind_int64(1, id1);
			assert(res == Sqlite.OK);

			res = query.bind_int64(2, id2);
			assert(res == Sqlite.OK);

			res = query.step();
			return (res == Sqlite.ROW);
		}

		protected void eliminar_relaciones_id (int64 id) {
			if(!eliminar_celda_por_columna(id, llave))
				throw new ErrorBaseDatos.CONSULTA("No se pudo eliminar de la relacion %s".printf(llave));
		}

		protected void eliminar_relaciones_secundarias_id (int64 id) {
			if(!eliminar_celda_por_columna(id, puerta))
				throw new ErrorBaseDatos.CONSULTA("No se pudo eliminar de la relacion %s".printf(puerta));
		}

		protected bool eliminar_relacion(int64 id_llave, int64 id_puerta) {
			if (!existe_relacion(id_llave, id_puerta))
				return false;
				
			Sqlite.Statement query;
			string sql = "DELETE FROM %s WHERE %s=? AND %s=?".printf(nombre_tabla, llave, puerta);
			int res = bd.prepare_v2(sql, -1, out query);
			assert(res == Sqlite.OK);

			res = query.bind_int64(1, id_llave);
			assert(res == Sqlite.OK);

			res = query.bind_int64(2, id_puerta);
			assert(res == Sqlite.OK);

			res = query.step();
			return (res == Sqlite.DONE);
		}


		private bool eliminar_celda_por_columna (int64 id, string columna) {
			Sqlite.Statement query;
			string sql = "DELETE FROM %s WHERE %s=?".printf(nombre_tabla, columna);
			int res = bd.prepare_v2(sql, -1, out query);
			assert(res == Sqlite.OK);

			res = query.bind_int64(1, id);
			assert(res == Sqlite.OK);

			res = query.step();
			return (res == Sqlite.DONE);
		}

		protected int total_relaciones_llave(int64 id) {
			return get_total_celdas("%s = %lld".printf(llave, id));
		}

		protected int total_relaciones_puerta(int64 id) {
			return get_total_celdas("%s = %lld".printf(puerta, id));
		}

	}


}