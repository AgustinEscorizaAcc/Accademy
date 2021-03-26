using { miEjercicioAngelo as miEjercicioAngelo } from '../db/schema';

service apiService{
    entity Proyectos as projection on miEjercicioAngelo.Proyectos;
    entity Clientes as projection on miEjercicioAngelo.Clientes;
    @readonly entity Tecnologias as projection on miEjercicioAngelo.Tecnologias;
    entity Proyectos_Tecnologias as projection on miEjercicioAngelo.Proyectos_Tecnologias;

}