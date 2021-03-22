using { cuid , managed } from '@sap/cds/common';

namespace miSuperLiga;

type Fecha : Date;

entity Partidos : cuid, managed{
    cantidadEspectadores : Integer;
    arbitro  : String;
    relator : String;
    clasico : Boolean;
    fecha : Fecha;
    resultado : Composition of Resultados;
    estadio : Association to Estadios;
    equipoLocal : Association to Equipos;
    equipoVisitante : Association to Equipos;
    puntajes : Association to many Puntajes on puntajes.partido = $self;
}
entity Equipos : cuid{
    nombre : String;
    division : String;
    puntos : Integer;
    cantidadJugadores : Integer;
    presupuesto : Integer64;
    jugadores : Composition of many Jugadores on jugadores.equipo = $self;
    partidos : Association to many Partidos on partidos.equipoLocal  = $self or partidos.equipoVisitante = $self;
    estadio : Association to Estadios;
}

entity Jugadores : cuid{

    nombre : String;
    valorMercado : Integer;
    apodo : String;
    posicion : String;
    pais : String;
    numeroRemera : Integer;
    equipo : Association to Equipos;
    puntajes : Association to many Puntajes on puntajes.jugador = $self;
}

entity Estadios : cuid{
    nombre : String;
    direccion : String;
    capacidad : Integer;
    partidos : Association to many Partidos on partidos.estadio = $self;
    equipos : Association to many Equipos on equipos.estadio = $self;
}

entity Puntajes : cuid{
    goles : Integer;
    asistencias : Integer;
    salvadas : Integer;
    partido : Association to Partidos;
    jugador : Association to Jugadores;
}

entity Resultados : cuid{
    partido : Association to Partidos;
    local : Integer;
    visitante : Integer;
}


