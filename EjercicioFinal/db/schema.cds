namespace miEjercicioFinal;

using { cuid } from '@sap/cds/common';


    //uso integer en los ID porque northwind me muestra que usa enteros y no el UUID, sino hubiera usado el otro
    //https://services.odata.org/Experimental/Northwind/Northwind.svc/Products

entity Orders {
    key ID : Integer;
    IDdatos : String; //ID adicional, nombre horrible pero no se me ocurrio otro, antes de cargarlo concateno los dos campos
    @mandatory region : String;
    @mandatory orderDate : DateTime;
    creationDate : DateTime;
    requiredDate : DateTime;
    shippedDate : DateTime;
    shipName : String;
    shipAddress : String;
    shipCity : String;
    shipPostalCode : String;
    ShipCountry : String;
}

entity OrderDetails {
    key Order : Association to Orders;
    key Product : Association to Products; 
    @mandatory unitPrice : Decimal(11,4);
    @mandatory quantity : Integer; 
    @mandatory discount : Decimal(4,2);
}

entity Products {
    key ID : Integer;
    name : String;
    quantityPerUnit : String;
    @mandatory unitPrice: Decimal(10,4);
    @mandatory unitsInStock: Integer;
    @mandatory unitsOnOrder: Integer;
    reorderLevel: Integer;
    discontinued: Boolean;
}
