using { cuid,Country } from '@sap/cds/common';

namespace misVeterinarias;

aspect Raza{
    especie : String;
    raza : String;
}

entity Sucursales : cuid{
    nombre : String;
    direccion : String;
    ciudad : String;
    pais : Country;
    medicos_Veterinarios : Association to many Medicos_Veterinarios on medicos_Veterinarios.sucursal = $self;
}

entity Medicos_Veterinarios : cuid{
    nombre : String;
    fechaNacimiento : Date;
    cuil : String;
    sucursal : Association to Sucursales;
    pacientes : Association to many Mascotas on pacientes.medico_Veterinario = $self;
}

entity Mascotas : cuid,Raza{
    nombre : String;
    fechaNacimiento : Date;
    sexo : String;
    vacunas : array of {
        nombre : String;
        fechaVacunacion : Date; 
    };
    duenios : Association to many Mascotas_Duenios on duenios.mascota = $self;
    medico_Veterinario : Association to Medicos_Veterinarios;
}

entity Duenios : cuid{
    nombre : String;
    telefono : String;
    dni : String;
    mascotas : Association to many Mascotas_Duenios on mascotas.duenio = $self;
}

entity Mascotas_Duenios : cuid{
    duenio : Association to Duenios;
    mascota : Association to Mascotas;
}