using { cuid , managed ,Country} from '@sap/cds/common';

namespace redSocial;


aspect Usuario_Humano {
    nombre : String;
    apellido : String;
    paisOrigen : String;
    genero : Integer enum{
        masculino = 2;
        femenino = 1;
        otro = 3;
    };
    telefono : String;
    fechaNacimiento : Date;
    email : {
        usuario : String;
        dominio : String;
        direccion : String;
    };

}
entity Usuarios : cuid,Usuario_Humano{
    username : String;
    password : String;
    amigos : Integer;
    status : Boolean;
    mensajes : Composition of many Mensajes on mensajes.usuario = $self;
    publicaciones : Association to many Publicaciones on publicaciones.usuario = $self;
    comentarios : Association to many Comentarios on comentarios.usuario = $self;
    perfil : Association to Perfiles;
}

entity Mensajes : cuid{
    nombreRemitente : String;
    contenido : String;
    leido : Boolean;
    multimedia : Array of{
        tipo : String;
        tamanio : Decimal(7,3);
    };
    usuario : Association to Usuarios;
}

entity Perfiles : cuid{
    titulo : String;
    descripcion : String;
    visualizaciones : Integer;
    categoria : Integer enum{
        bronce = 1;
        plate = 2;
        oro = 3;
        diamante = 4;
        carbon = 0;
    };
    usuario: Association to Usuarios;
    publicaciones : Association to many Publicaciones on publicaciones.perfil = $self;
}

entity Publicaciones : cuid , managed{
    titulo : String default 'Titulo';
    cantidadCompartido : Integer;
    tipo : Integer enum{
        texto = 1;
        foto = 2;
        video = 3;
        url = 4;
    };
    likes : Integer;
    usuario : Association to Usuarios;
    perfil : Association to Perfiles;
    comentarios : Association to many Comentarios on comentarios.publicacion = $self;
}

entity Comentarios : cuid, managed{
    contenido : String;
    usuario : Association to Usuarios;
    publicacion : Association to Publicaciones;
}