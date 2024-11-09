-- ----------------------------------------------------------------------------------------------------

-- Proyecto: Control de Informacion para una Biblioteca de Mangas
-- Equipo: Jose Antonio Gonzalez Cardenas | Emmanuel Saldaña Alvarez | Jesus Alfonso Cuevas Avila

-- ----------------------------------------------------------------------------------------------------

-- Usar la Base de Datos
USE Biblioteca_Mangas;


-- ------------------------------------------------------------------------
--							DETALLE LOTES
-- ------------------------------------------------------------------------
SELECT 
    DL.idDetalleLote,
    JSON_QUERY(
        (
            SELECT 
                D.idDistribuidor,
                D.nombreDistribuidor,
                D.telefonoDist,
                D.emailDist,
                D.direccionDist
            FROM Distribuidores D
            WHERE D.idDistribuidor = DL.idDistribuidor
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        )
    ) AS Distribuidor,
    DL.idLote
FROM DetalleLotes DL
FOR JSON PATH;



-- ------------------------------------------------------------------------
--							LOTES
-- ------------------------------------------------------------------------
SELECT 
    L.idLote,
    L.fechaImpresion,
    L.cantidadMangas,
    JSON_QUERY(
        (
            SELECT 
                I.idImprenta,
                I.nombreImp,
                I.direccionImp,
                I.CP_Imp,
                I.paisImp,
                I.telefonoImp,
                I.emailImp
            FROM Imprentas I
            WHERE I.idImprenta = L.idImprenta
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        )
    ) AS Imprenta
FROM Lotes L
FOR JSON PATH;



-- ------------------------------------------------------------------------
--							SUCURSALES
-- ------------------------------------------------------------------------
SELECT 
    S.idSucursal,
    S.nombreSuc,
    S.direccionSuc,
    S.telefonoSuc,
    JSON_QUERY(
        (
            SELECT 
                U.idUbicacion,
                U.seccion,
                U.pasillo,
                U.estanteria
            FROM UbicacionFisica U
            WHERE U.idUbicacion = S.idUbicacion
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        )
    ) AS UbicacionFisica,
    JSON_QUERY(
        (
            SELECT 
                D.idDistribuidor,
                D.nombreDistribuidor,
                D.telefonoDist,
                D.emailDist,
                D.direccionDist
            FROM Distribuidores D
            WHERE D.idDistribuidor = S.idDistribuidor
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        )
    ) AS Distribuidor
FROM Sucursales S
FOR JSON PATH;

