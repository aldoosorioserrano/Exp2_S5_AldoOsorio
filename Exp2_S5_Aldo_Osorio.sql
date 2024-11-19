--DESAFIO UNO 


SELECT 
     case when length(Cliente.Numrun) = 7 then
    substr(Cliente.Numrun,1,1) || '.'|| substr(Cliente.Numrun,2,3) || '.'|| substr(Cliente.Numrun,5,3) || '-' ||  Cliente.Dvrun
    when length(Cliente.Numrun) = 8 then
    substr(Cliente.Numrun,1,2) || '.'|| substr(Cliente.Numrun,3,3) || '.'|| substr(Cliente.Numrun,6,3) || '-' ||  Cliente.Dvrun
    else 
    'Formato invalido'
    end AS Rut_Cliente,
     INITCAP(Cliente.Pnombre) || ' ' ||  INITCAP(Cliente.ApPaterno) AS Nombre_Cliente,
     UPPER(PROFESION_OFICIO.Nombre_Prof_Ofic) AS PROFESION,
     TO_CHAR(Cliente.Fecha_Inscripcion, 'DD-MM-YYYY'  ) AS FECHA_INSCRIP,
     Cliente.Direccion
FROM Cliente 
JOIN Profesion_Oficio ON  Profesion_Oficio.cod_prof_ofic = Cliente.cod_prof_ofic
WHERE Profesion_Oficio.Cod_Prof_Ofic IN(5,18) AND Cliente.cod_Tipo_Cliente = 10 and 
TO_CHAR(Cliente.fecha_inscripcion, 'YYYY') > (Select ROUND(AVG( TO_CHAR(Cliente.fecha_inscripcion, 'YYYY'))) as fecha_promedio
from Cliente)
ORDER BY RUT_CLIENTE DESC



---DESAFIO 2

CREATE TABLE CLIENTES_CUPOS_COMPRA2
as SELECT 
    case when length(Cliente.Numrun) = 7 then
    substr(Cliente.Numrun,1,1) || '.'|| substr(Cliente.Numrun,2,3) || '.'|| substr(Cliente.Numrun,5,3) || '-' ||  Cliente.Dvrun
    when length(Cliente.Numrun) = 8 then
    substr(Cliente.Numrun,1,2) || '.'|| substr(Cliente.Numrun,3,3) || '.'|| substr(Cliente.Numrun,6,3) || '-' ||  Cliente.Dvrun
    else 
    'Formato invalido'
    end AS Rut_Cliente,
    TRUNC( ( TO_NUMBER(TO_CHAR(SYSDATE,'YYYYMMDD')) -  TO_NUMBER(TO_CHAR(Fecha_Nacimiento,'YYYYMMDD') ) ) / 10000) AS Edad,
    TARJETA_CLIENTE.cupo_compra AS Cupo_Disponible_Compra,
    UPPER(Tipo_Cliente.nombre_tipo_Cliente) as Tipo_Cliente
    FROM Cliente      
    JOIN Tipo_Cliente ON  Tipo_Cliente.cod_tipo_Cliente = Cliente.cod_tipo_Cliente
    JOIN TARJETA_CLIENTE ON TARJETA_CLIENTE.numrun = Cliente.numrun
    JOIN transaccion_tarjeta_cliente on tarjeta_cliente.nro_tarjeta = transaccion_tarjeta_cliente.nro_tarjeta
    where tarjeta_cliente.cupo_disp_compra <=  (
            Select MAX(monto_total_transaccion) 
            from transaccion_tarjeta_cliente
            where  TO_NUMBER(TO_CHAR(fecha_transaccion,'YYYY')) = TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))-1);



 
    
   


