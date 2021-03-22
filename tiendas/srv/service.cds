using { gestionTiendas as gestionTiendas} from '../db/schema';

service apiService{

    entity Tiendas      as Select From gestionTiendas.Tiendas{*};
    entity Duenios      as Select From gestionTiendas.Duenios{*};
    entity Productos    as Select From gestionTiendas.Productos{*};
    entity Tiendas_Duenios as select from gestionTiendas.Tiendas_Duenios{*};
    entity Tiendas_Productos as Select from gestionTiendas.Tiendas_Productos{*};

    entity VistaTotal as select from gestionTiendas.Tiendas{
        nombre as nombreTienda,
        productos.producto.nombre as productoNombre,
        productos.producto.precio as precioProducto,
        duenios.duenio.nombre as Duenio
    };
    action ActualizarPrecios(ID: UUID,precio: Integer) returns String;
    action ControlDeStock(ID: UUID, cantidad: Integer) returns String;
}