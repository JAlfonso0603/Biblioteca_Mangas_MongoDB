-- ----------------------------------------------------------------------------------------------------

-- Proyecto: Control de Informacion para una Biblioteca de Mangas
-- Equipo: Jose Antonio Gonzalez Cardenas | Emmanuel Saldaña Alvarez | Jesus Alfonso Cuevas Avila

-- ----------------------------------------------------------------------------------------------------

USE Biblioteca_Mangas;

-- ------------------------------------------------------------------------
--							MANGAS
-- ------------------------------------------------------------------------

SELECT 
    M.idManga,
	M.idTraductor,
    M.nombreManga,
    M.capituloManga,
    M.paginasManga,
    M.imagenManga,
    M.stock,
    M.habilitado,
    M.disponible,
    (
        SELECT 
            G.idGenero,
            G.nombreGen,
            G.descripcionGen
        FROM Generos G
        WHERE G.idGenero = M.idGenero
        FOR JSON PATH
    ) AS Genero,
    (
        SELECT 
            E.idEditorial,
            E.nombreEdit,
            E.paisEdit
        FROM Editoriales E
        WHERE E.idEditorial = M.idEditorial
        FOR JSON PATH
    ) AS Editorial,
    (
        SELECT 
            A.idAutor
        FROM Autores A
        WHERE A.idAutor = M.idAutor
        FOR JSON PATH
    ) AS Autor,
    (
        SELECT 
            G.idGuionista,
            G.nombreGui,
			G.numeroObrasGui,
            G.nacionalidadGui
        FROM Guionistas G
        WHERE G.idGuionista = 
            (SELECT A.idGuionista FROM Autores A WHERE A.idAutor = M.idAutor)
        FOR JSON PATH
    ) AS Guionistas,
    (
        SELECT 
            Art.idArtista,
            Art.nombreArt,
			Art.numeroObrasArt,
            Art.nacionalidadArt
        FROM Artistas Art
        WHERE Art.idArtista = 
            (SELECT A.idArtista FROM Autores A WHERE A.idAutor = M.idAutor)
        FOR JSON PATH
    ) AS Artistas

FROM Mangas M
FOR JSON PATH;

-- ------------------------------------------------------------------------
--							TRADUCTORES
-- ------------------------------------------------------------------------

SELECT 
    T.idTraductor,
    T.nombreTrad,
    T.idiomas,
    T.idEditorial  
FROM Traductores T
FOR JSON PATH;
