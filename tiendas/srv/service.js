const cds = require('@sap/cds');
const { Tiendas ,Productos,Tiendas_Duenios,Tiendas_Productos} = cds.entities;

module.exports = cds.service.impl(async (srv)=>{

    srv.on('ActualizarPrecios',async (req)=>{
        
        const productoID = req.data.ID;
        const productoPrecio = req.data.precio;
        console.log("entro al update");

        try{  
            if(await cds.run(UPDATE(Productos).set({precio: productoPrecio}).where({ID: productoID}))){
                console.log("exito!!");
            }

        }catch(error){
            console.log("No anda el update");
            console.log(error);
        }
    })

    srv.after('CREATE','Duenios', async(data,req)=>{

        const duenioID = req.data.ID;
        const {tiendas} = req._.req.query;

        if(tiendas){

            console.log("Tiendas esta cargado");
            let IDs = tiendas.split(',');
            try{
                let arrayTiendas_Duenios = [];
                let i = 0;

                await IDs.forEach(element => {
                    
                //    cds.run(INSERT.into(Tiendas_Duenios).columns('tiendas_ID','duenios_ID').values(element,duenioID))
                    
                    arrayTiendas_Duenios.push( {
                        duenio_ID: duenioID ,
                        tienda_ID: element
                    });
                });
                await cds.run(INSERT.into(Tiendas_Duenios).entries(arrayTiendas_Duenios))
                // await cds.run(INSERT.into(Tiendas_Duenios).columns('tiendas_ID','duenios_ID').values())
            }catch(err){
                console.log(err);
                console.log("Fallo en la insercion de tabla intermedia")
            }
        }
        else{
            console.log("Esta vacio, Veeeees")
        }
    })
    srv.on('ControlDeStock',async (req)=>{
        const IDProducto = req.data.ID;
        const cantidad = req.data.cantidad;

        try{
            console.log("entrando select de tiendas_Productos");
            const tiendasProductos = await cds.run(SELECT.from(Tiendas_Productos).where({producto_ID: IDProducto}));
            console.log("entrando select de Productos");
            const producto = await cds.run(SELECT.one(Productos).where({ID : IDProducto}));

            try{
                console.log("entrando validacion de stock");
                let vCantidad = producto.cantidad;
                tiendasProductos.forEach(element =>{
                    let vStock = element.stock + cantidad; //Stock es lo que quiero sumar en tienda_Productos
                    vCantidad = vCantidad - cantidad;  //vCantidad es cantidad que tengo en productos
                    if(vStock >= producto.min){
                        if(vStock <= producto.max){
                            if(vCantidad >= 0){
                                element.stock = vStock;

                            }else{
                                console.log("no se tiene esa cantidad de productos en el sistema")
                            }
                        }else{
                            console.log("me pase del maximo");
                        }
                    }else{
                        console.log("no llego al minimo")
                    }
                });

                console.log("validacion completa, pasamos a insert");
                await tiendasProductos.forEach(element=>{
                     cds.run(UPDATE(Tiendas_Productos).set({stock : element.stock}).where({ID : element.ID}));
                });
                
                await cds.run(UPDATE(Productos).set({cantidad: vCantidad}).where({ID : IDProducto}));
                return "todo barbaro";
            }catch(err){
                console.log(err);
                console.log("fallo la validacion o el insert");
                return "fallo la validacion o el insert";
            }

        }catch(err){
            console.log(err);
        }
    })
})