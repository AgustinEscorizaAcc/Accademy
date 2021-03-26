using {cuid, managed} from '@sap/cds/common';

namespace miEjercicioAngelo;

entity Proyectos : cuid,managed{
    nombre : String;
    estimado : String;
    cliente : Association to Clientes;
    tecnologias : Association to many Proyectos_Tecnologias on tecnologias.proyecto = $self;
}
entity Proyectos_Tecnologias : cuid{
    proyecto : Association to Proyectos;
    tecnologia : Association to Tecnologias;
    dificultad : String enum{
        facil = 1;
        medio = 3;
        dificil = 5;
    };    
}

entity Tecnologias{
    key ID : Integer;
    nombre : String;
    proyectos : Association to many Proyectos_Tecnologias on proyectos.tecnologia = $self;
}

entity Clientes : cuid{
    nombre : String;
    dni : String;
    proyectos : Association to many Proyectos on proyectos.cliente = $self;
}