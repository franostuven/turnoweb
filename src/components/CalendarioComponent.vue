<template>
    <h5 class="mt-3">Seleccione su fecha de Turno</h5>
    <Calendar id="fecha" v-model="f_Turno" :inline="true" date-format="dd-mm-yy" :disabledDays="[0,6]" @date-select="dateSelect"
            stepMinute='30'  :showTime="false" :minDate="minDate" :maxDate="maxDate"  :disabledDates="invalidDates"
            class="inputfield w-full">    
            <!--  -->
            <template #date="slotProps">
                    <template v-if="verificaDia(slotProps.date.day)" class="turnosVacio">
                            {{slotProps.date.day}}
                    </template>

                    <template v-else-if="verificaDia(slotProps.date.day) >0 && verificaDia(slotProps.date.day)<5" class="turnoMedio">
                            <strong>{{slotProps.date.day}}</strong>
                    </template>
                    
                    <template v-else class="turnoCompleto">{{slotProps.date.day}}</template>
            </template>
    </Calendar>
</template>

<script>
export default {
    props:{
      selecDeporte: String

    },  
    setup(props){

        
        let selDeporte = ref(props.selecDeporte);              // usada en el input
    
    
        let mostrarCalendario = ref( fale);      // muestra u oculta el calendario 
        const PlaniTurnos = ref();            // Array de fechas con turnos
        let repetidos = ref([]);              // array con las fechas repetidas
        let nuevoArray = ref([]);             // array consolo las fechas de los turnos
        const displayCargaTurno = ref(false);  //swich que abre ventana carga de turnos
        const horariosHabilitados = ref([])   //Horaios habilitados para turnos
        let indiceDrop = ref(0);             // Guarda el indice del deporte, dentro del array

        
        const minDate = ref(new Date());     // Min dia para sacar turno
        const maxDate = ref(new Date());      // Maximo dia para pedir turno
        const invalidDates = ref([]);        // dias invalidos cerrado
        //const dropIndex = ref(0);              // indice del dropdown

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


        if(today.getDay() >=4) {     // cae dia jueves
            diaProximo.value = 2 + 2;
        }else{
            if(today.getDay()===0){
                diaProximo.value = 2 + 1;
            }else{
                diaProximo.value= 2;
            }
        }

        diaProximo.value = 2;

        minDate.value.setDate(today.getDate());

        maxDate.value.setDate(today.getDate() + diaProximo.value);

        maxDate.value.setMonth(nextMonth);

        maxDate.value.setFullYear(nextYear);

        maxDate.value.setHours(20);  // sacar el valor desde la tabla horarios

  // RECUPERA HORARIOS DE APERTURA Y CIERRE DEL DEPORTE PARA SOLICITAR TURNOS (TABLA HORARIOS)
       const horioDeTurnos = async () => {              
          await axios.post(url, {opcion:5, selecDeporte: selDeporte.value})
          .then(response=>{
            horariosHabilitados.value = response.data;

            console.log('HORARIOS ACTIVOS: ',horariosHabilitados.value);
       
          })
          .catch(function (error) {
            console.log(error);
          });   
      }

      // Refresca el Calendario con los turnos segun la disciplina elegida   
      const cambioDeporte = async () => {

          indiceDrop = deportes.value.findIndex( element => element.id_deporte === selDeporte.value );

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


            mostrarCalendario.value = true;

        //    console.log('INDICE DEL DROP: ',dropIndex)
            // SACA LOS DIAS FERIADOS O CERRADOS (TABLA: FERIADOS_CERRADO)
            await axios.post(url, {opcion:3, selecDeporte: selDeporte.value})
              .then(response =>{
                res.value = response.data;       
       
                for (let i = 0; i < res.value.length; i++) {
                  invalidDates.value.push( new Date(res.value[i].f_cierre));
                }

                console.log("Fechas CERRADO: ",res.value)

              })
              .catch(function (error) {
                  console.log(error);
              });   

  //             console.log('Datos de invalidDates: ',invalidDates.value)

       // ************* Recupera los trunos que hay para ese deporte (TABLA TURNOS)
            await axios.post(url, {opcion:4, selecDeporte: selDeporte.value})
              .then(response =>{
                  PlaniTurnos.value = response.data;       
                  
                  // console.log('Datos de PlaniTurnos: ',PlaniTurnos.value)

                  nuevoArray.value = NuevoArray(PlaniTurnos.value);
                  //console.log('ARRAY SOLO FECHAS: ',nuevoArray.value);

                  repetidos.value = contarRepetidos(nuevoArray.value);
                  //console.log('Contador de Fechas: ',repetidos.value)

              })
              .catch(function (error) {
                console.log(error);
              });   
      }

      // RUTINA QUE EXTRAE SOLO FECHAS DE LOS TURNOS
      const NuevoArray =  (array) => {
            return array.map(({f_turno}) => f_turno);

       
        }
      // RUTINA QUE CUENTA CUANTAS FECHAS REPETIDAS HAY 
        const contarRepetidos = (datos) => {
                return datos.reduce(( a, d) =>  (a[d] ? a[d]  += 1 : a[d] = 1, a), {});
        }
//         ************ FIN RUTINA CANTIDAD PERS.POR TURNO


      // MEJORAR: (DESPUES FILTAR DESDE EL DIA DE HOY HACIA ADELANTE)
    //SACA LOS TURNOS DE CADA MES 
  




      const verificaDia = (obj) => {
          // for PlaniTurnos.value 
          return 3
      };
    // Rutina que detecta cuando presiono una fecha.
      const dateSelect = ( e ) => {
        displayCargaTurno.value = true;
        console.log(e);
        console.log("estoy saliendo del select");
        console.log('FECHA ', fechaTurno.value);
        return true;
      };

    return {dateSelect, f_Turno }

    }
}
</script>

<style>

</style>