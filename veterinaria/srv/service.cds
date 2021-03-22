using {misVeterinarias as misVeterinarias} from '../db/schema';

service apiService{
    entity Mascotas as projection on misVeterinarias.Mascotas;
    entity Medicos_Veterinarios as projection on misVeterinarias.Medicos_Veterinarios;
    entity Sucursales as projection on misVeterinarias.Sucursales;
    entity Mascotas_Duenios as projection on misVeterinarias.Mascotas_Duenios;
    entity Duenios as projection on misVeterinarias.Duenios;

    entity Vista as select from Mascotas{
        *,
        duenios.duenio.nombre as nombreDuenio,
        medico_Veterinario.nombre as nombreVeterinario,
        medico_Veterinario.sucursal.nombre as nombreSucursal,
        medico_Veterinario.sucursal.direccion as direccionSucursal
    }

}