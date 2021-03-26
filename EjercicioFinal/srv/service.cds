using { miEjercicioFinal as my } from '../db/schema';


service api {
    entity Orders as projection on my.Orders;
    @readonly entity OrderDetails as projection on my.OrderDetails;
    entity Products as projection on my.Products;

    entity vistaDetalle as select from OrderDetails{
        *,
        Product.name as nombreProducto,
        Product.quantityPerUnit as cantidadPorUnidad,
        Product.unitPrice as precioPorUnidad,
        Product.unitsInStock as unidadesEnStock,
        Product.unitsInStock as unidadesEnOden
    };

    action CargarOrden(productId: Integer,orderId: Integer,unitPrice: Decimal(11,4),quantity: Integer,discount: Decimal(4,2)) returns String;
}
