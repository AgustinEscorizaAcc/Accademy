using{ miEjercicio as miEjercicio } from '../db/schema';

service api @(requires:'scope'){
    @readonly entity Tecnologias as projection on miEjercicio.Tecnologias;

}

service admin @(requires:'admin'){
    entity Tecnologias as projection on miEjercicio.Tecnologias
}