<template>
    <h5 class="mt-3">Seleccione su fecha de Turno</h5>
      <!-- <Calendar id="basic" v-model="fechaTurno" autocomplete="off" :inline="true" /> -->
     <Calendar id="fecha" v-model="fechaTurno" :inline="true" date-format="dd-mm-yy" :disabledDays="[0,6]" @date-select="dateSelect"
            :showTime="false" :minDate="minDate" :maxDate="maxDate"  :disabledDates="invalidDates" class="inputfield w-full">    

          <template #date="slotProps">
              <strong v-if="slotProps.date.selectable"  style="color: blue;">{{slotProps.date.day}}</strong>            
              <template v-else style="background: white; color: black;">{{slotProps.date.day}}</template>
          </template>

    </Calendar> 
</template>

<script>
  import {ref, computed, onMounted, provide, inject} from 'vue';

  export default {
    props:{
      selecDeporte: String
    },  
    setup(props){
      
        onMounted (() =>{
          cargarRutinas()
        });

              
        //  ******************************  INJECT DE VARIABLES   **************************************************
        
        let displayCargaTurno = inject("displayCargaTurno");
        const url = inject("url");
        const fechaTurno = inject('fechaTurno');
        const PlaniTurnos = inject("PlaniTurnos");

        //  ******************************  DEFINICION DE VARIABLES  **************************************************
        let selDeporte = ref(props.selecDeporte);              // usada en el input
    
      //  const PlaniTurnos = ref();            // Array de fechas con turnos
    //    let repetidos = ref([]);              // array con las fechas repetidas
    //    let nuevoArray = ref([]);             // array consolo las fechas de los turnos
        const horariosHabilitados = ref([])   //Horaios habilitados para turnos
        let indiceDrop = ref(0);             // Guarda el indice del deporte, dentro del array

        const minDate = ref(new Date());     // Min dia para sacar turno
        const maxDate = ref(new Date());      // Maximo dia para pedir turno
        const invalidDates = ref([]);        // dias invalidos cerrado

        const today = new Date();           // Usado para calcular fechas min y max
        let   diaProximo = ref(0);
        
        let   res = [];                     // array auxiliar de fechas invalidas

        // CALCULOS DE FECHAS PARA EL CALENDARIO
        let month = today.getMonth();
        let year = today.getFullYear();
        let nextMonth = month ;
        let nextYear = (nextMonth === 0) ? year + 1 : year;

        // CAMBIAR LOS DIAS DE PEDIDOS DE TURNO ANTICIPADO CON DATOS DE LA BASE
        //       indiceDrop = deportes.value.findIndex( element => element.id_deporte === selecDeporte.value );

        //  ******************************  PROVIDE DE VARIABLES   **************************************************
        

        //  ****************************** FIN PROVIDE DE VARIABLES   **************************************************

        if(today.getDay() >=4) {     // cae dia jueves
            diaProximo.value = 2 + 2;
        }else{
          if(today.getDay()===0){
            diaProximo.value = 2 + 1;
            }else{
              diaProximo.value= 2;
            }
        }

        minDate.value.setDate(today.getDate());
        maxDate.value.setDate(today.getDate() + diaProximo.value);
        maxDate.value.setMonth(nextMonth);
        maxDate.value.setFullYear(nextYear);
        maxDate.value.setHours(20);  // sacar el valor desde la tabla horarios

      //  ******************************  DEFINICION DE RUTINAS  **************************************************

      const cargarRutinas = async () => {
        
        
        // **********************************************  SACA LOS DIAS QUE NO SE TRABAJAN, DIAS INVALIDOS
        await axios.post(url, {opcion:3, selecDeporte: selDeporte.value})
          .then(response =>{
            res.value = response.data;       
    
            for (let i = 0; i < res.value.length; i++) {
              invalidDates.value.push( new Date(res.value[i].f_cierre));
            }
            //console.log("Fechas invalid dates CERRADO: ",res.value)
          })
          .catch(function (error) {
              console.log(error);
          });   

      }
      //  ESTO SE FUE A TURNOS.VUE
        // *********************** ARRAY CON LOS TURNOS QUE HAY DESDE HOY EN ADELANTE DE 1 DEPORTE PARTIC. (TABLA TURNOS) **********
        // await axios.post(url, {opcion:4, selecDeporte: selDeporte.value})
        //   .then(response =>{
        //       PlaniTurnos.value = response.data;       
              
        //         console.log('Datos de PlaniTurnos en: ',PlaniTurnos.value)
              //  console.log("DIA DE HOY : ", today.getDate(), " y dia ", today.getDay() )
              // console.log("DOS DIAS DESPUES : ", today.getDate()+2 )
          //********************************************************************************* */     
 //// ESTE BLOQUE SE FUE A LISTARTURNOS.VUE
              // if(PlaniTurnos.value.length > 0){                        // si hay turnos ejecuta esto 
              //     nuevoArray.value = NuevoArray(PlaniTurnos.value);
              //     //console.log('ARRAY SOLO FECHAS: ',nuevoArray.value);
    
              //     repetidos.value = contarRepetidos(nuevoArray.value);
              //     //console.log('Contador de Fechas: ',repetidos.value)
              //     // array repetidos tiene fecha y cantidad de veces.
              //     //console.log("Dia de repetidos: ",repetidos.value)
    
              //     var keyNames = Object.keys(repetidos.value);
                
              //     for(let d=0; d< keyNames.length; d++){
              //       diasRepetidos.push(new Date(keyNames[d]))
              //     }
              // }
          // })
          // .catch(function (error) {
          //   console.log(error);
          // });   
  
        // **************************************************  FIN RUTINA DE CARGA INICIAL MOUNTED

          //********************************************************************************* */     
 //// ESTE BLOQUE SE FUE A LISTARTURNOS.VUE
        // // RUTINA QUE EXTRAE SOLO FECHAS Y HORAS  DE LOS TURNOS EN UN ARRAY
        // const NuevoArray =  (array) => {
        //       return array.map(({f_turno}) => f_turno);
        // }

        // // RUTINA QUE CUENTA CUANTAS FECHAS REPETIDAS HAY DESDE EL NuevoArray (rut. de arriba)
        // const contarRepetidos = (datos) => {
        //           return datos.reduce(( a, d) =>  (a[d] ? a[d]  += 1 : a[d] = 1, a), {});
        // }
        // // ************ FIN RUTINA CANTIDAD PERS.POR TURNO ************************************


      // Refresca el Calendario con los turnos segun la disciplina elegida   
      // const refrescar = () => console.log("RUTINA QUE MUESTRA EL CALENDARIO AL ENTRAR");

      // const cambioDeporte = async () => {

      //     indiceDrop = deportes.value.findIndex( element => element.id_deporte === selDeporte.value );

          // diaProximo.value = computed(() => {
          //   if(today.getDay() >=4) {     // cae dia jueves
          //         return deportes.value[indiceDrop].anticipacion + 2;
          //     }else{
          //       if(today.getDay()===0){
          //         return deportes.value[indiceDrop].anticipacion + 1;
          //       }else{
          //         return deportes.value[indiceDrop].anticipacion;
          //       }
          //     }

          // }
      //}


      // MEJORAR: (DESPUES FILTAR DESDE EL DIA DE HOY HACIA ADELANTE)
    //SACA LOS TURNOS DE CADA MES 

    // RUTINA QUE DETECTA CUANDO SELECCIONO UNA FECHA  *********** y habilita las horas listarTurnos.vue
       const dateSelect = ( e ) => {
        displayCargaTurno.value = true;
       // horioPorFecha();                 // SACA SOLO HORARIOS DE UNA FECHA
        console.log(e);  // fecha seleccionada
        console.log("estoy saliendo del select");
        console.log('FECHA turno ', fechaTurno.value);
        console.log("DISPLAY DE TURNOS SALIENDO: ",displayCargaTurno.value)

        return 
      };

      return { fechaTurno, invalidDates, maxDate, minDate, today, 
               dateSelect}

    }
  }
</script>

<style scoped>

  .botonEnviar {
    padding: 10%
  }

  .html {
    min-height: 100%;
    position: relative;
  }

  .body {
    margin: 0;
    margin-bottom: 40px;
    padding-bottom: 70px;
  }

  .footer {
    background-color: white;
    position: absolute;
    bottom: 0;
    width: 100%;
    height: 40px;
    color: white;
  }

</style>