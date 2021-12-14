<template>
    
</template>
<script>

//let url = "src/libreries/crud.php";
//let url ="http://localhost/estribo/src/libreries/crud.php" // DESARROLLO
let url = '../components/crud.php';   // PRODUCCION y desarrollo


import { defineComponent } from '@vue/composition-api'
import { onMounted } from '@vue/runtime-core'

export default defineComponent({
    setup() {
        onMounted(() => {
              listarTurnos()
        });

       const  listarTurnos =  async  () =>{
                await axios.post(url, {opcion:2, id_turno: selecDeporte.value})
                .then(response =>{
                    this.pantallas = response.data;       
                //console.log('Datos de pantalla: ',this.pantallas)
                })
                .catch(function (error) {
                    console.log(error);
                });
                // Segunda peticion traigo titulos de cada zona de pantalla
                await axios.post(url, {opcion:5, id_menu:this.id})
                .then(response =>{
                    this.titulos = response.data;       
               // console.log('Datos de titulos: ',this.titulos)
                })
                .catch(function (error) {
                    console.log(error);
                });
                // Tercer peticion traigo items de cada menu
                await axios.post(url, {opcion:6, id_menu:this.id})
                .then(response =>{
                    this.links = response.data;       
                 //console.log('Datos de links: ',this.links)
                })
                .catch(function (error) {
                    console.log(error);
                });
             
            }
    }

})
</script>

 