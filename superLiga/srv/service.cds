using { miSuperLiga as miSuperLiga} from '../db/schema';

service apiService {

    entity Equipos as projection on miSuperLiga.Equipos;
    entity Partidos @cds.autoexpose as projection on miSuperLiga.Partidos;
    entity Estadios as projection on miSuperLiga.Estadios;
    entity Jugadores as projection on miSuperLiga.Jugadores;
    entity Resultados as projection on miSuperLiga.Resultados;
    entity Puntajes as projection on miSuperLiga.Puntajes;
    
    entity vista1 as select from Jugadores{
        *,
        puntajes.goles as goles,
        puntajes.asistencias as asistencias,
        puntajes.partido.fecha as fecha,
        puntajes.partido.arbitro as arbitro,
        puntajes.partido.equipoLocal.nombre as equipoLocal,
        puntajes.partido.equipoVisitante.nombre as equipoVisitante
    }where puntajes.goles >=3;

    entity vista2 as select from Resultados[(local - visitante) >= 3 or (visitante - local) >= 3]{
        *,
        partido.equipoLocal.nombre as equipoLocal,
        partido.equipoVisitante.nombre as equipoVisitante,
        partido.cantidadEspectadores as cantidadEspectadores,
        partido.estadio.nombre as estadio,
        partido.arbitro as arbitro 
    };

    entity mejorArquero as select from Jugadores{
        nombre as nombre,
        puntajes.salvadas as salvadas
    }order by salvadas desc
    limit 1;

    entity vista4 as select  from Jugadores{
        *,
        avg(puntajes.goles) as golPromedio : Decimal(6,3)
    }group by ID,nombre
    order by golPromedio desc; 

    entity golesDeEquipo as select from Partidos{
        *,
        
    };
    
}