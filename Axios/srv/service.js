const cds = require('@sap/cds');
const axios = require('axios').default;
const schedule = require('node-schedule');
const https = require('https');
const agent = new https.Agent({
    rejectUnauthorized: false,
});

const { Tecnologias } = cds.entities;

const job = schedule.scheduleJob('10 * * * * *', ()=>{
    axios.get('https://discovery-center.cloud.sap/platformx/Services',{
        headers: {
            "Accept" : "application/json",
            "Content-Type" : "application/json"
        },
        httpsAgent : agent,
        rejectUnauthorized : false
    })
    .then(async (resp)=>{
        let resultado = resp.data.d.results;
        let aCargar = [];
        
        resultado.forEach(element => {
            aCargar.push({
                name: element.ShortName,
                description: element.ShortDesc
            });
        });
        try{
            await cds.run(DELETE.from(Tecnologias))
            await cds.run(INSERT.into(Tecnologias).entries(aCargar));
            console.log("EXITOOOOO");
        }catch(err){
            console.log(err);
            console.log("error cargando Tecnologias");
        }
    })
    .catch((err)=>{
        console.log(err);
        console.log("ERRORRRRR");
    })
})