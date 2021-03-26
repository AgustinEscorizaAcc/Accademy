using { cuid , Currency } from '@sap/cds/common';

namespace gestionTiendas;

/*
entity Precios : cuid {
    Productos : Association to many Productos on Productos.precio = $self;
    nombreMoneda : Currency;
    precio : Decimal(6,2);
}
*/
aspect Precio  {
    moneda : Currency;
    precio : Decimal(6,2)
}



entity Tiendas : cuid{
    nombre : String;
    duenios : Association to many Tiendas_Duenios on duenios.tienda = $self;
    productos : Association to many Tiendas_Productos on productos.tienda = $self;
}

entity Productos : cuid, Precio{
    nombre : String;
    minimo : Integer; //que puede tener cada tienda, ej: una tienda no puede tener una leche
    cantidad: Integer; //Cantidad de productos disponibles
    maximo : Integer; //que puede tener cada tienda. EJ: una tienda no puede tener 600 leches
    tiendas : Association to many Tiendas_Productos on tiendas.producto = $self;
    marca : Association to Marcas;
}

entity Duenios : cuid{
    nombre  : String;
    dni     : String;
    tiendas : Association to many Tiendas_Duenios on tiendas.duenio = $self;
}

entity Marcas : cuid{
    nombre : String;
    productos : Association to many Productos on productos.marca = $self;
}

entity Tiendas_Duenios : cuid{
    key tienda : Association to Tiendas;
    key duenio : Association to Duenios;
}

entity Tiendas_Productos : cuid{
    key tienda  : Association to Tiendas;
    key producto : Association to Productos;
    stock : Integer;
}

