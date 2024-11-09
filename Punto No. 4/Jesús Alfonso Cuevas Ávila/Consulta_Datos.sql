SELECT 
    U.idUsuario,
    U.usuario,
    U.password,
    (
        SELECT 
            U.nombrePila AS nombrePila,
            U.apePat AS apePat,
            U.apeMat AS apeMat
        FOR JSON PATH
    ) AS nombre,
    U.habilitado,
    (
        SELECT 
            G.nombreGrupo AS nombreGrupo,
            G.habilitado AS habilitado,
            (
                SELECT 
                    P.idPermiso AS idPermiso,
                    P.nombrePermiso AS nombrePermiso
                FROM Permisos P
                WHERE P.idPermiso = G.idPermiso  -- Relacionar Permisos con Grupos
                FOR JSON PATH
            ) AS permisos
        FROM Grupos G
        WHERE G.idGrupo = U.idGrupo  -- Relacionar Grupos con Usuarios
        FOR JSON PATH
    ) AS grupo
FROM Usuarios U
FOR JSON PATH;

SELECT 
    P.idPrestamo,
    P.idSucursal,
    P.idUsuario,
    P.totalMangas,
    P.fechaPres,
    P.fechaDevSR,
    P.fechaDev,
    P.estadoPre,
    (
        SELECT 
            DP.idDetallePrestamo,
            (
                SELECT idManga 
                FROM Mangas M
                WHERE M.idManga = DP.idManga
                FOR JSON PATH
            ) AS idManga
        FROM DetallePrestamos DP
        WHERE DP.idPrestamo = P.idPrestamo
        FOR JSON PATH
    ) AS detallePrestamos
FROM Prestamos P
FOR JSON PATH;

SELECT 
    A.idApartado,
    A.idUsuario,
    A.idManga,
    A.fechaApartado,
    A.fechaLimite,
    A.estado
FROM Apartados A
FOR JSON PATH;