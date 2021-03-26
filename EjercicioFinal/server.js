const cds = require('@sap/cds')
const axios = require('axios').default;
const https = require('https');
const agent = new https.Agent({
    rejectUnauthorized: false,
});

cds.once('served', async ()=>{  //cuando se crea el servicio me carga las entidades 1 sola vez
    const { Orders, OrderDetails, Products} = cds.entities;
    await axios.get('https://services.odata.org/Experimental/Northwind/Northwind.svc/Products?$orderby=ProductID',{
        headers: {
            "Accept" : "application/json",
            "Content-Type" : "application/json"
        },
        httpsAgent : agent,
        rejectUnauthorized : false
    })
    .then( async (resp)=>{
        let resultado = resp.data.value;
        let aCargar = [];
        resultado.forEach(element => {
            aCargar.push({
                ID : element.ProductID,
                name : element.ProductName,
                quantityPerUnit : element.QuantityPerUnit,
                unitPrice: element.UnitPrice,
                unitsInStock: element.UnitsInStock,
                unitsOnOrder: element.UnitsOnOrder,
                reorderLevel: element.ReorderLevel,
                discontinued: element.Discontinued
            })
        });
        try{
            await cds.run(INSERT.into(Products).entries(aCargar));
            console.log("Exito cargando Productos!")
        }catch(err){
            console.log(err);
            console.log("no se pudo cargar Productos");
        }
            
        })
        .catch((err)=>{
            console.log(err);
            console.log("ERRORRRRR cargando products");
        })
    await axios.get('https://services.odata.org/Experimental/Northwind/Northwind.svc/Orders?$orderby=OrderID',{
        headers: {
            "Accept" : "application/json",
            "Content-Type" : "application/json"
        },
        httpsAgent : agent,
        rejectUnauthorized : false
    })
    .then( async (resp)=>{
        let resultado = resp.data.value;
        let aCargar = [];
        let aCargarRegion;
        let aCargarRegFecha;
        resultado.forEach(element => {
            if(element.ShipRegion === null){
                aCargarRegion = '00';   //si viene vacio cargo dos 0
            }else{
                aCargarRegion = element.ShipRegion
            }
            aCargarRegFecha = element.OrderDate + '/' + aCargarRegion;   //concateno la Fecha con la region para generar el ID
            aCargar.push({
                ID: element.OrderID,
                IDdatos: aCargarRegFecha,
                shipName : element.ShipName,
                region : aCargarRegion,
                orderDate : element.OrderDate,
                requiredDate : element.RequiredDate,
                shippedDate : element.ShippedDate,
                creationDate : element.OrderDate,
                shipAddress : element.ShipAddress,
                shipCity : element.ShipCity,
                shipPostalCode : element.ShipPostalCode,
                ShipCountry : element.ShipCountry
            })
        });
        
        await cds.run(INSERT.into(Orders).entries(aCargar));
        console.log("Exito cargando Orders!")
        
    })
    .catch((err)=>{
        console.log(err);
        console.log("ERRORRRRR cargando Orders");
    })
    await axios.get('https://services.odata.org/Experimental/Northwind/Northwind.svc/Order_Details?$filter=ProductID lt 20 and OrderID lt 10447',{
        headers: {
            "Accept" : "application/json",
            "Content-Type" : "application/json"
        },
        httpsAgent : agent,
        rejectUnauthorized : false
    })
    .then( async (resp)=>{
        let resultado = resp.data.value;
        let aCargarOrderDetails = [];
        resultado.forEach(element => {
            
            aCargarOrderDetails.push({
                Order_ID : element.OrderID,
                Product_ID : element.ProductID,
                unitPrice : element.UnitPrice,
                quantity : element.Quantity,
                discount : element.Discount
            })
        });
        
        try{
            await cds.run(INSERT.into(OrderDetails).entries(aCargarOrderDetails));
            console.log("Exito cargando Order_Details!");
        }catch(err){
            console.log(err);
            console.log("no se pudo cargar Order_Details");
        }
    })
    .catch((err)=>{
        console.log(err);
        console.log("ERROR Cargando Order Order_Details");
    })
})

module.exports = cds.server //> delegate to default server.js


