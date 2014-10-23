CREATE TABLE "Archivos" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "nombre" TEXT NOT NULL,
    "ubicacion" TEXT NOT NULL,
    "tipo" INTEGER NOT NULL,
    "ultimoAcceso" TEXT,
    "popularidad" REAL DEFAULT (0),
    "disponible" INTEGER DEFAULT (1)
);
CREATE TABLE sqlite_sequence(name,seq);
CREATE TABLE "sentimientos" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "nombre" TEXT,
    "descripcion" TEXT
);
CREATE TABLE "r_album_cancion" (
    "id_album" INTEGER NOT NULL,
    "id_cancion" INTEGER NOT NULL
);
CREATE TABLE "r_artista_album" (
    "id_artista" INTEGER NOT NULL,
    "id_album" INTEGER
);
CREATE TABLE "r_archivo_sentimiento" (
    "id_archivo" INTEGER NOT NULL,
    "id_etiqueta" INTEGER NOT NULL
);
CREATE TABLE "album_imagenes" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "nombre" TEXT NOT NULL,
    "descripcion" TEXT,
    "fecha" TEXT
);
CREATE TABLE "r_foto_albumFoto" (
    "id_foto" INTEGER NOT NULL,
    "id_album" INTEGER NOT NULL
);
CREATE TABLE personas (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "nombre" TEXT NOT NULL,
    "rol" TEXT NOT NULL,
    "edad" INTEGER DEFAULT (20),
    "popularidad" REAL DEFAULT (0),
    "nacionalidad" TEXT,
    "imagen" BLOB
);
CREATE UNIQUE INDEX "nombres" on archivos (id ASC, nombre DESC);
CREATE TABLE r_persona_archivo (
    "id_persona" INTEGER NOT NULL,
    "id_archivo" INTEGER NOT NULL
);
CREATE TABLE "album_cancion" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "nombre" TEXT NOT NULL,
    "caratula" BLOB NOT NULL,
    "popularidad" REAL,
    "descripcion" TEXT
);
