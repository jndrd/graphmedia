/* main.c generated by valac 0.26.0, the Vala compiler
 * generated from main.vala, do not modify */


#include <glib.h>
#include <glib-object.h>
#include <stdlib.h>
#include <string.h>


#define GRAPH_MEDIA_TYPE_TESTS (graph_media_tests_get_type ())
#define GRAPH_MEDIA_TESTS(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GRAPH_MEDIA_TYPE_TESTS, GraphMediaTests))
#define GRAPH_MEDIA_TESTS_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GRAPH_MEDIA_TYPE_TESTS, GraphMediaTestsClass))
#define GRAPH_MEDIA_IS_TESTS(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GRAPH_MEDIA_TYPE_TESTS))
#define GRAPH_MEDIA_IS_TESTS_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GRAPH_MEDIA_TYPE_TESTS))
#define GRAPH_MEDIA_TESTS_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GRAPH_MEDIA_TYPE_TESTS, GraphMediaTestsClass))

typedef struct _GraphMediaTests GraphMediaTests;
typedef struct _GraphMediaTestsClass GraphMediaTestsClass;
typedef struct _GraphMediaTestsPrivate GraphMediaTestsPrivate;

#define GEE_TYPE_TEST_CASE (gee_test_case_get_type ())
#define GEE_TEST_CASE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GEE_TYPE_TEST_CASE, GeeTestCase))
#define GEE_TEST_CASE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GEE_TYPE_TEST_CASE, GeeTestCaseClass))
#define GEE_IS_TEST_CASE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GEE_TYPE_TEST_CASE))
#define GEE_IS_TEST_CASE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GEE_TYPE_TEST_CASE))
#define GEE_TEST_CASE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GEE_TYPE_TEST_CASE, GeeTestCaseClass))

typedef struct _GeeTestCase GeeTestCase;
typedef struct _GeeTestCaseClass GeeTestCaseClass;

#define GRAPH_MEDIA_TYPE_TEST_GENERADOR (graph_media_test_generador_get_type ())
#define GRAPH_MEDIA_TEST_GENERADOR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GRAPH_MEDIA_TYPE_TEST_GENERADOR, GraphMediaTestGenerador))
#define GRAPH_MEDIA_TEST_GENERADOR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GRAPH_MEDIA_TYPE_TEST_GENERADOR, GraphMediaTestGeneradorClass))
#define GRAPH_MEDIA_IS_TEST_GENERADOR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GRAPH_MEDIA_TYPE_TEST_GENERADOR))
#define GRAPH_MEDIA_IS_TEST_GENERADOR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GRAPH_MEDIA_TYPE_TEST_GENERADOR))
#define GRAPH_MEDIA_TEST_GENERADOR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GRAPH_MEDIA_TYPE_TEST_GENERADOR, GraphMediaTestGeneradorClass))

typedef struct _GraphMediaTestGenerador GraphMediaTestGenerador;
typedef struct _GraphMediaTestGeneradorClass GraphMediaTestGeneradorClass;
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))

#define GRAPH_MEDIA_TYPE_TEST_PERSONA (graph_media_test_persona_get_type ())
#define GRAPH_MEDIA_TEST_PERSONA(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GRAPH_MEDIA_TYPE_TEST_PERSONA, GraphMediaTestPersona))
#define GRAPH_MEDIA_TEST_PERSONA_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GRAPH_MEDIA_TYPE_TEST_PERSONA, GraphMediaTestPersonaClass))
#define GRAPH_MEDIA_IS_TEST_PERSONA(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GRAPH_MEDIA_TYPE_TEST_PERSONA))
#define GRAPH_MEDIA_IS_TEST_PERSONA_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GRAPH_MEDIA_TYPE_TEST_PERSONA))
#define GRAPH_MEDIA_TEST_PERSONA_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GRAPH_MEDIA_TYPE_TEST_PERSONA, GraphMediaTestPersonaClass))

typedef struct _GraphMediaTestPersona GraphMediaTestPersona;
typedef struct _GraphMediaTestPersonaClass GraphMediaTestPersonaClass;

#define GRAPH_MEDIA_TYPE_TEST_BASE_DE_DATOS (graph_media_test_base_de_datos_get_type ())
#define GRAPH_MEDIA_TEST_BASE_DE_DATOS(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GRAPH_MEDIA_TYPE_TEST_BASE_DE_DATOS, GraphMediaTestBaseDeDatos))
#define GRAPH_MEDIA_TEST_BASE_DE_DATOS_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GRAPH_MEDIA_TYPE_TEST_BASE_DE_DATOS, GraphMediaTestBaseDeDatosClass))
#define GRAPH_MEDIA_IS_TEST_BASE_DE_DATOS(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GRAPH_MEDIA_TYPE_TEST_BASE_DE_DATOS))
#define GRAPH_MEDIA_IS_TEST_BASE_DE_DATOS_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GRAPH_MEDIA_TYPE_TEST_BASE_DE_DATOS))
#define GRAPH_MEDIA_TEST_BASE_DE_DATOS_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GRAPH_MEDIA_TYPE_TEST_BASE_DE_DATOS, GraphMediaTestBaseDeDatosClass))

typedef struct _GraphMediaTestBaseDeDatos GraphMediaTestBaseDeDatos;
typedef struct _GraphMediaTestBaseDeDatosClass GraphMediaTestBaseDeDatosClass;

#define GRAPH_MEDIA_TYPE_TEST_ARTISTAS (graph_media_test_artistas_get_type ())
#define GRAPH_MEDIA_TEST_ARTISTAS(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GRAPH_MEDIA_TYPE_TEST_ARTISTAS, GraphMediaTestArtistas))
#define GRAPH_MEDIA_TEST_ARTISTAS_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GRAPH_MEDIA_TYPE_TEST_ARTISTAS, GraphMediaTestArtistasClass))
#define GRAPH_MEDIA_IS_TEST_ARTISTAS(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GRAPH_MEDIA_TYPE_TEST_ARTISTAS))
#define GRAPH_MEDIA_IS_TEST_ARTISTAS_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GRAPH_MEDIA_TYPE_TEST_ARTISTAS))
#define GRAPH_MEDIA_TEST_ARTISTAS_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GRAPH_MEDIA_TYPE_TEST_ARTISTAS, GraphMediaTestArtistasClass))

typedef struct _GraphMediaTestArtistas GraphMediaTestArtistas;
typedef struct _GraphMediaTestArtistasClass GraphMediaTestArtistasClass;

#define GRAPH_MEDIA_TYPE_TEST_ALBUMS_MUSICALES (graph_media_test_albums_musicales_get_type ())
#define GRAPH_MEDIA_TEST_ALBUMS_MUSICALES(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GRAPH_MEDIA_TYPE_TEST_ALBUMS_MUSICALES, GraphMediaTestAlbumsMusicales))
#define GRAPH_MEDIA_TEST_ALBUMS_MUSICALES_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GRAPH_MEDIA_TYPE_TEST_ALBUMS_MUSICALES, GraphMediaTestAlbumsMusicalesClass))
#define GRAPH_MEDIA_IS_TEST_ALBUMS_MUSICALES(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GRAPH_MEDIA_TYPE_TEST_ALBUMS_MUSICALES))
#define GRAPH_MEDIA_IS_TEST_ALBUMS_MUSICALES_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GRAPH_MEDIA_TYPE_TEST_ALBUMS_MUSICALES))
#define GRAPH_MEDIA_TEST_ALBUMS_MUSICALES_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GRAPH_MEDIA_TYPE_TEST_ALBUMS_MUSICALES, GraphMediaTestAlbumsMusicalesClass))

typedef struct _GraphMediaTestAlbumsMusicales GraphMediaTestAlbumsMusicales;
typedef struct _GraphMediaTestAlbumsMusicalesClass GraphMediaTestAlbumsMusicalesClass;

#define GRAPH_MEDIA_TYPE_TEST_ALBUMS_IMAGENES (graph_media_test_albums_imagenes_get_type ())
#define GRAPH_MEDIA_TEST_ALBUMS_IMAGENES(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GRAPH_MEDIA_TYPE_TEST_ALBUMS_IMAGENES, GraphMediaTestAlbumsImagenes))
#define GRAPH_MEDIA_TEST_ALBUMS_IMAGENES_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GRAPH_MEDIA_TYPE_TEST_ALBUMS_IMAGENES, GraphMediaTestAlbumsImagenesClass))
#define GRAPH_MEDIA_IS_TEST_ALBUMS_IMAGENES(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GRAPH_MEDIA_TYPE_TEST_ALBUMS_IMAGENES))
#define GRAPH_MEDIA_IS_TEST_ALBUMS_IMAGENES_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GRAPH_MEDIA_TYPE_TEST_ALBUMS_IMAGENES))
#define GRAPH_MEDIA_TEST_ALBUMS_IMAGENES_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GRAPH_MEDIA_TYPE_TEST_ALBUMS_IMAGENES, GraphMediaTestAlbumsImagenesClass))

typedef struct _GraphMediaTestAlbumsImagenes GraphMediaTestAlbumsImagenes;
typedef struct _GraphMediaTestAlbumsImagenesClass GraphMediaTestAlbumsImagenesClass;

#define GRAPH_MEDIA_TYPE_TEST_SENTIMIENTOS (graph_media_test_sentimientos_get_type ())
#define GRAPH_MEDIA_TEST_SENTIMIENTOS(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GRAPH_MEDIA_TYPE_TEST_SENTIMIENTOS, GraphMediaTestSentimientos))
#define GRAPH_MEDIA_TEST_SENTIMIENTOS_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GRAPH_MEDIA_TYPE_TEST_SENTIMIENTOS, GraphMediaTestSentimientosClass))
#define GRAPH_MEDIA_IS_TEST_SENTIMIENTOS(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GRAPH_MEDIA_TYPE_TEST_SENTIMIENTOS))
#define GRAPH_MEDIA_IS_TEST_SENTIMIENTOS_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GRAPH_MEDIA_TYPE_TEST_SENTIMIENTOS))
#define GRAPH_MEDIA_TEST_SENTIMIENTOS_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GRAPH_MEDIA_TYPE_TEST_SENTIMIENTOS, GraphMediaTestSentimientosClass))

typedef struct _GraphMediaTestSentimientos GraphMediaTestSentimientos;
typedef struct _GraphMediaTestSentimientosClass GraphMediaTestSentimientosClass;

#define GRAPH_MEDIA_TYPE_TEST_CANCIONES (graph_media_test_canciones_get_type ())
#define GRAPH_MEDIA_TEST_CANCIONES(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GRAPH_MEDIA_TYPE_TEST_CANCIONES, GraphMediaTestCanciones))
#define GRAPH_MEDIA_TEST_CANCIONES_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GRAPH_MEDIA_TYPE_TEST_CANCIONES, GraphMediaTestCancionesClass))
#define GRAPH_MEDIA_IS_TEST_CANCIONES(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GRAPH_MEDIA_TYPE_TEST_CANCIONES))
#define GRAPH_MEDIA_IS_TEST_CANCIONES_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GRAPH_MEDIA_TYPE_TEST_CANCIONES))
#define GRAPH_MEDIA_TEST_CANCIONES_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GRAPH_MEDIA_TYPE_TEST_CANCIONES, GraphMediaTestCancionesClass))

typedef struct _GraphMediaTestCanciones GraphMediaTestCanciones;
typedef struct _GraphMediaTestCancionesClass GraphMediaTestCancionesClass;

#define GRAPH_MEDIA_TYPE_TEST_IMAGENES (graph_media_test_imagenes_get_type ())
#define GRAPH_MEDIA_TEST_IMAGENES(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GRAPH_MEDIA_TYPE_TEST_IMAGENES, GraphMediaTestImagenes))
#define GRAPH_MEDIA_TEST_IMAGENES_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GRAPH_MEDIA_TYPE_TEST_IMAGENES, GraphMediaTestImagenesClass))
#define GRAPH_MEDIA_IS_TEST_IMAGENES(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GRAPH_MEDIA_TYPE_TEST_IMAGENES))
#define GRAPH_MEDIA_IS_TEST_IMAGENES_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GRAPH_MEDIA_TYPE_TEST_IMAGENES))
#define GRAPH_MEDIA_TEST_IMAGENES_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GRAPH_MEDIA_TYPE_TEST_IMAGENES, GraphMediaTestImagenesClass))

typedef struct _GraphMediaTestImagenes GraphMediaTestImagenes;
typedef struct _GraphMediaTestImagenesClass GraphMediaTestImagenesClass;

struct _GraphMediaTests {
	GObject parent_instance;
	GraphMediaTestsPrivate * priv;
};

struct _GraphMediaTestsClass {
	GObjectClass parent_class;
};


static gpointer graph_media_tests_parent_class = NULL;

GType graph_media_tests_get_type (void) G_GNUC_CONST;
enum  {
	GRAPH_MEDIA_TESTS_DUMMY_PROPERTY
};
void graph_media_tests_main (gchar** args, int args_length1);
GraphMediaTestGenerador* graph_media_test_generador_new (void);
GraphMediaTestGenerador* graph_media_test_generador_construct (GType object_type);
GType gee_test_case_get_type (void) G_GNUC_CONST;
GType graph_media_test_generador_get_type (void) G_GNUC_CONST;
GTestSuite* gee_test_case_get_suite (GeeTestCase* self);
GraphMediaTestPersona* graph_media_test_persona_new (void);
GraphMediaTestPersona* graph_media_test_persona_construct (GType object_type);
GType graph_media_test_persona_get_type (void) G_GNUC_CONST;
GraphMediaTestBaseDeDatos* graph_media_test_base_de_datos_new (void);
GraphMediaTestBaseDeDatos* graph_media_test_base_de_datos_construct (GType object_type);
GType graph_media_test_base_de_datos_get_type (void) G_GNUC_CONST;
GraphMediaTestArtistas* graph_media_test_artistas_new (void);
GraphMediaTestArtistas* graph_media_test_artistas_construct (GType object_type);
GType graph_media_test_artistas_get_type (void) G_GNUC_CONST;
GraphMediaTestAlbumsMusicales* graph_media_test_albums_musicales_new (void);
GraphMediaTestAlbumsMusicales* graph_media_test_albums_musicales_construct (GType object_type);
GType graph_media_test_albums_musicales_get_type (void) G_GNUC_CONST;
GraphMediaTestAlbumsImagenes* graph_media_test_albums_imagenes_new (void);
GraphMediaTestAlbumsImagenes* graph_media_test_albums_imagenes_construct (GType object_type);
GType graph_media_test_albums_imagenes_get_type (void) G_GNUC_CONST;
GraphMediaTestSentimientos* graph_media_test_sentimientos_new (void);
GraphMediaTestSentimientos* graph_media_test_sentimientos_construct (GType object_type);
GType graph_media_test_sentimientos_get_type (void) G_GNUC_CONST;
GraphMediaTestCanciones* graph_media_test_canciones_new (void);
GraphMediaTestCanciones* graph_media_test_canciones_construct (GType object_type);
GType graph_media_test_canciones_get_type (void) G_GNUC_CONST;
GraphMediaTestImagenes* graph_media_test_imagenes_new (void);
GraphMediaTestImagenes* graph_media_test_imagenes_construct (GType object_type);
GType graph_media_test_imagenes_get_type (void) G_GNUC_CONST;
GraphMediaTests* graph_media_tests_new (void);
GraphMediaTests* graph_media_tests_construct (GType object_type);


void graph_media_tests_main (gchar** args, int args_length1) {
	GTestSuite* _tmp0_ = NULL;
	GraphMediaTestGenerador* _tmp1_ = NULL;
	GraphMediaTestGenerador* _tmp2_ = NULL;
	GTestSuite* _tmp3_ = NULL;
	GTestSuite* _tmp4_ = NULL;
	GraphMediaTestPersona* _tmp5_ = NULL;
	GraphMediaTestPersona* _tmp6_ = NULL;
	GTestSuite* _tmp7_ = NULL;
	GTestSuite* _tmp8_ = NULL;
	GraphMediaTestBaseDeDatos* _tmp9_ = NULL;
	GraphMediaTestBaseDeDatos* _tmp10_ = NULL;
	GTestSuite* _tmp11_ = NULL;
	GTestSuite* _tmp12_ = NULL;
	GraphMediaTestArtistas* _tmp13_ = NULL;
	GraphMediaTestArtistas* _tmp14_ = NULL;
	GTestSuite* _tmp15_ = NULL;
	GTestSuite* _tmp16_ = NULL;
	GraphMediaTestAlbumsMusicales* _tmp17_ = NULL;
	GraphMediaTestAlbumsMusicales* _tmp18_ = NULL;
	GTestSuite* _tmp19_ = NULL;
	GTestSuite* _tmp20_ = NULL;
	GraphMediaTestAlbumsImagenes* _tmp21_ = NULL;
	GraphMediaTestAlbumsImagenes* _tmp22_ = NULL;
	GTestSuite* _tmp23_ = NULL;
	GTestSuite* _tmp24_ = NULL;
	GraphMediaTestSentimientos* _tmp25_ = NULL;
	GraphMediaTestSentimientos* _tmp26_ = NULL;
	GTestSuite* _tmp27_ = NULL;
	GTestSuite* _tmp28_ = NULL;
	GraphMediaTestCanciones* _tmp29_ = NULL;
	GraphMediaTestCanciones* _tmp30_ = NULL;
	GTestSuite* _tmp31_ = NULL;
	GTestSuite* _tmp32_ = NULL;
	GraphMediaTestImagenes* _tmp33_ = NULL;
	GraphMediaTestImagenes* _tmp34_ = NULL;
	GTestSuite* _tmp35_ = NULL;
	g_test_init (&args_length1, &args, NULL);
	_tmp0_ = g_test_get_root ();
	_tmp1_ = graph_media_test_generador_new ();
	_tmp2_ = _tmp1_;
	_tmp3_ = gee_test_case_get_suite ((GeeTestCase*) _tmp2_);
	g_test_suite_add_suite (_tmp0_, _tmp3_);
	_g_object_unref0 (_tmp2_);
	_tmp4_ = g_test_get_root ();
	_tmp5_ = graph_media_test_persona_new ();
	_tmp6_ = _tmp5_;
	_tmp7_ = gee_test_case_get_suite ((GeeTestCase*) _tmp6_);
	g_test_suite_add_suite (_tmp4_, _tmp7_);
	_g_object_unref0 (_tmp6_);
	_tmp8_ = g_test_get_root ();
	_tmp9_ = graph_media_test_base_de_datos_new ();
	_tmp10_ = _tmp9_;
	_tmp11_ = gee_test_case_get_suite ((GeeTestCase*) _tmp10_);
	g_test_suite_add_suite (_tmp8_, _tmp11_);
	_g_object_unref0 (_tmp10_);
	_tmp12_ = g_test_get_root ();
	_tmp13_ = graph_media_test_artistas_new ();
	_tmp14_ = _tmp13_;
	_tmp15_ = gee_test_case_get_suite ((GeeTestCase*) _tmp14_);
	g_test_suite_add_suite (_tmp12_, _tmp15_);
	_g_object_unref0 (_tmp14_);
	_tmp16_ = g_test_get_root ();
	_tmp17_ = graph_media_test_albums_musicales_new ();
	_tmp18_ = _tmp17_;
	_tmp19_ = gee_test_case_get_suite ((GeeTestCase*) _tmp18_);
	g_test_suite_add_suite (_tmp16_, _tmp19_);
	_g_object_unref0 (_tmp18_);
	_tmp20_ = g_test_get_root ();
	_tmp21_ = graph_media_test_albums_imagenes_new ();
	_tmp22_ = _tmp21_;
	_tmp23_ = gee_test_case_get_suite ((GeeTestCase*) _tmp22_);
	g_test_suite_add_suite (_tmp20_, _tmp23_);
	_g_object_unref0 (_tmp22_);
	_tmp24_ = g_test_get_root ();
	_tmp25_ = graph_media_test_sentimientos_new ();
	_tmp26_ = _tmp25_;
	_tmp27_ = gee_test_case_get_suite ((GeeTestCase*) _tmp26_);
	g_test_suite_add_suite (_tmp24_, _tmp27_);
	_g_object_unref0 (_tmp26_);
	_tmp28_ = g_test_get_root ();
	_tmp29_ = graph_media_test_canciones_new ();
	_tmp30_ = _tmp29_;
	_tmp31_ = gee_test_case_get_suite ((GeeTestCase*) _tmp30_);
	g_test_suite_add_suite (_tmp28_, _tmp31_);
	_g_object_unref0 (_tmp30_);
	_tmp32_ = g_test_get_root ();
	_tmp33_ = graph_media_test_imagenes_new ();
	_tmp34_ = _tmp33_;
	_tmp35_ = gee_test_case_get_suite ((GeeTestCase*) _tmp34_);
	g_test_suite_add_suite (_tmp32_, _tmp35_);
	_g_object_unref0 (_tmp34_);
	g_test_run ();
}


int main (int argc, char ** argv) {
#if !GLIB_CHECK_VERSION (2,35,0)
	g_type_init ();
#endif
	graph_media_tests_main (argv, argc);
	return 0;
}


GraphMediaTests* graph_media_tests_construct (GType object_type) {
	GraphMediaTests * self = NULL;
	self = (GraphMediaTests*) g_object_new (object_type, NULL);
	return self;
}


GraphMediaTests* graph_media_tests_new (void) {
	return graph_media_tests_construct (GRAPH_MEDIA_TYPE_TESTS);
}


static void graph_media_tests_class_init (GraphMediaTestsClass * klass) {
	graph_media_tests_parent_class = g_type_class_peek_parent (klass);
}


static void graph_media_tests_instance_init (GraphMediaTests * self) {
}


GType graph_media_tests_get_type (void) {
	static volatile gsize graph_media_tests_type_id__volatile = 0;
	if (g_once_init_enter (&graph_media_tests_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (GraphMediaTestsClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) graph_media_tests_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (GraphMediaTests), 0, (GInstanceInitFunc) graph_media_tests_instance_init, NULL };
		GType graph_media_tests_type_id;
		graph_media_tests_type_id = g_type_register_static (G_TYPE_OBJECT, "GraphMediaTests", &g_define_type_info, 0);
		g_once_init_leave (&graph_media_tests_type_id__volatile, graph_media_tests_type_id);
	}
	return graph_media_tests_type_id__volatile;
}



