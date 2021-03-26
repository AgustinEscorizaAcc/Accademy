const cds = require('@sap/cds');


const { Orders, OrderDetails, Products} = cds.entities;

module.exports = cds.service.impl(async (srv)=>{
    srv.on('CargarOrden', async (req)=>{
        const {productId, orderId, quantity} = req.data;

        try{
            let producto = await cds.run(SELECT.one(Products).where({ID: productId}))

            if(producto){ //valido existencia producto

                let order = await cds.run(SELECT.one(Orders).where({ID: orderId}))
                if(order){ //valido existencia orden
                    if(quantity <= producto.unitsInStock){  //valido la cantidad recibida y cargo los datos que voy a modificar en las tablas
                        let unitsOnOrder = producto.unitsOnOrder + quantity;
                        let unitsInStock = producto.unitsInStock - quantity;
                        let unitPrice = producto.unitPrice;
                        // AHORA ACTUALIZO LAS TABLAS

                        try{
                            await cds.run(INSERT.into(OrderDetails).columns(
                                'Order_ID','Product_ID','unitPrice','quantity'
                            ).values(orderId,productId,unitPrice,quantity));
                            await cds.run(UPDATE(Products).set({unitsInStock : unitsInStock, unitsOnOrder: unitsOnOrder}).where({ID: productId}));

                            console.log("exitoo");
                        }catch(err){
                            console.log(err);
                            console.log("error en la actualizacion de tablas")
                            return "error en la actualizacion de tablas";
                        }

                    }else{
                        console.log("fallo en la validacion de cantidad")
                        return "Cantidad invalida";
                    }

                }else{
                    console.log("esa orden no existe");
                    return "esa orden no existe";
                }
            }else{
                console.log("ese producto no existe");
                return "ese producto no existe";
            }


        }catch(err){
            console.log(err);
            console.log("error en la validacion de datos de CargarOrden")
        }
        return "EXITO";
    })
})



