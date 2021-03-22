using { redSocial as redSocial} from '../db/schema';

service apiService{

    entity Usuarios as projection on redSocial.Usuarios;
    entity Mensajes as projection on redSocial.Mensajes;
    entity Perfiles as projection on redSocial.Perfiles;
    entity Comentarios as projection on redSocial.Comentarios;
    entity Publicaciones as projection on redSocial.Publicaciones;

    entity vistaPerfilPublicaciones as select from Perfiles{
        *,
        usuario.username as nombreUsuario,
        publicaciones.titulo as titulo,
        publicaciones.cantidadCompartido as cantidadCompartido,
        publicaciones.tipo as tipo,
        publicaciones.likes as likes
    };

    entity vistaUsuariosArgentinos as select from Usuarios{
        *
    }where paisOrigen = 'ARG';
    
    entity vistaMuchosCompartidos as select from Publicaciones{
        *,
        usuario.username as username,
    }where cantidadCompartido >= 100;
}