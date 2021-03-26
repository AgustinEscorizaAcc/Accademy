const cds = require('@sap/cds');

const { Proyectos, Tecnologias,Proyectos_Tecnologias} = cds.entities;


module.exports = cds.service.impl( (srv)=>{
    srv.after('CREATE',"Proyectos",async ( data , req ) =>{
        const { params } = req._.req.query;
        const idProyecto = req.data.ID;
        
        let tecnologiasDificultades = params.split(',');

        console.log(tecnologiasDificultades);

        // SE VA A CALCULAR CON LA FORMULA PERT EL ESTIMADO TE = (O + 4T + P) / 6, el estimado es en dias
        let estimadoPert = 0;
        let proyectosTecnologias = [];

        try{
            tecnologiasDificultades.forEach(element => {
                let array = element.split(':');
                let tecnologia = array[0];
                let dificultad = array[1];

                //multiplico por 2 para tener dias masomenos coherentes, si es facil tardo 2, si es medio 6 y si es dificil 10

                let tiempoOptimo = dificultad * 2;  //optimista es multiplicado por 2
                let tiempoPesimista = (dificultad + 2) * 2; //Pesimista me lo lleva al valor de la dificultad siguiente y multiplico por 2
                let masProbable = Math.round(tiempoPesimista * 0.75); //el mas probable 

                estimadoPert += (tiempoOptimo + 4*masProbable + tiempoPesimista)/6;

                proyectosTecnologias.push({
                    proyecto_ID: idProyecto,
                    tecnologia_ID: tecnologia,
                    dificultad: dificultad
                })

            });
            estimadoPert = Math.round(estimadoPert);
            try{
                await cds.run(INSERT.into(Proyectos_Tecnologias).entries(proyectosTecnologias));
                await cds.run(UPDATE(Proyectos).set({estimado: estimadoPert}).where({ID : idProyecto}));

            }catch(err){
                console.log(err);
                console.log("fallo en la actualizacion de tablas")
            }
        }catch(err){
            console.log(err);
            console.log("error en foreach de proyectoTecnologia");
        }

        estimadoPert = Math.round(estimadoPert); // si me quedo en decimal lo redondeo para abajo

    })

})