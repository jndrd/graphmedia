using Gee;

namespace GraphMedia {
	
	public class Tests: Object {

		public static void main(string[] args) {
			Test.init (ref args);
	 
		    TestSuite.get_root ().add_suite (new TestGenerador().get_suite ());
		    TestSuite.get_root ().add_suite (new TestPersona().get_suite ());
		    TestSuite.get_root ().add_suite (new TestBaseDeDatos().get_suite ());
   		    TestSuite.get_root ().add_suite (new TestArtistas().get_suite ());
   		    TestSuite.get_root ().add_suite (new TestAlbumsMusicales().get_suite ());
   		    TestSuite.get_root ().add_suite (new TestAlbumsImagenes().get_suite ());
   		    TestSuite.get_root ().add_suite (new TestSentimientos().get_suite ());
   		    TestSuite.get_root ().add_suite (new TestCanciones().get_suite ());
   		    TestSuite.get_root ().add_suite (new TestImagenes().get_suite ());

		    Test.run ();
		}

	}
}