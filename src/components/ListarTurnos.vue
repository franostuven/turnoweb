<template>
    <Toast/>
    <div >
        <h4 class="m-3 text-center">Horarios</h4>

        <div class="p-col-12 p-md-2 mb-2">
            <InlineMessage severity="success" class='mr-2'>Libre</InlineMessage>
            <InlineMessage severity="warn" class='mr-2'>Algunos Libres</InlineMessage>
            <InlineMessage severity="error">Completo</InlineMessage>

        </div>
        <strong class="mt-2">Los turnos son de 30 minutos, para tener 1 hora, son 2 turnos.</strong>

        <div class="grid flex align-content-center mt-3" v-if="displayCargaTurno" >     <!--:disabled="bloqueoHorarios" -->

            <div v-for="(hora, index) in horarios" :key="index"  :class="[colorDeTurno]"   @click="marcoTurno(hora.id)"
                  class="col-12 md:col-6 lg:col-2 align-content-center border-white-alpha-90 border-3 h-3rem"  >
                  <div  class="col-12 md:col-4 lg:col-4 flex"  >
                      <strong>{{hora.turno}}</strong>                      <!-- :id="'list-' + index" :disabled="desabilito === 'list-' + index ? true : false" -->
                  </div>
            </div>
             
        </div>

        <h4><b> Hora seleccionada </b></h4>
        <div class="card border-200 shadow-8 ">
              <div class="flex flex-wrap card-container surface-100" v-for="(miTurno, f_ind) in f_turno_dh" :key="f_ind">
                    <p class="align-content-center ml-2 mt-3">Turno Desde: {{miTurno.turno}} </p>
                    <Button icon="pi pi-times" class="p-button-rounded p-button-danger p-button-text my-2" @click="borro(miTurno.id)" />
              </div>
        </div>
    </div>    

</template>

<script>
import {toRef, inject, onMounted, ref, computed, provide} from 'vue';
import { useToast } from 'primevue/usetoast';

export default {
    props: {
      selectDeporte: Number
    }, 
    setup(props){
        onMounted(() =>{
   //       horioPorFecha()
        });

        const selDeporte = toRef(props, 'selectDeporte');
        const toast = useToast();

        let d_hora = 8;
        let h_hora = 14;
        let h_turno = '';
        let i = 0;
        let hora = '';
        let hora_ant = ref('') ;  // guarda la primer hora seleccionada, (se puede hacer en un array de 2 elem.)
        let kont = 0 ;
        let colorDeTurno = ref('');   // indica cuantas personas hay por turno
        let bloqueoHorarios = ref(false)   // bloquea el DIV de horios cuando toco 2 turnos
        const intervalo = '30';
        const horarios = ref([]);
        const horariosTomados = ref();
        let nuevoArray = ref([]);             // array consolo las fechas de los turnos
        let repetidos = ref([]);              // array con las fechas repetidas
            
        let btnDesabilitado = inject('btnDesabilitado');  // para habilitar el boton SUBMIT  (LO HABILITA marcoTurno)
        const fTurno = inject('fechaTurno');
        const displayCargaTurno = inject("displayCargaTurno");
        const url = inject("url");
        const PlaniTurnos = inject("PlaniTurnos");
        
        const f_turno_dh = inject("f_turno_dh");   // Array con los turnos que tomo

// dd@dd.ci
      //  console.log("DISPLAY DE TURNOS: ",displayCargaTurno.value);


        //  RUTINA QUE RECUPERA LOS HORARIOS DE UN  DEPORTE (HORA INICIO - HORA DE FIN Y SU INTERVALO) (TABLA HORARIOS)
        // PARA SER USADA EN EL FOR DE ABAJO.  !!!!!  NO LA LLAMA NADIE AUN!!!!
        // CAMBIAR EN ESTE PROG. =  INTERVALO, D_TURNO, H_TURNO, HORADETURNO > 3 (por su varible) Y EL FOR DE ABAJO
              // **********************************************

          // const horioPorFecha = async () => {              
          //   await axios.post(url, {opcion:5, selecDeporte: selDeporte.value, fTurno: fTurno.value })
          //   .then(response=>{
          //     horariosTomados.value = response.data;

          //     console.log('HORARIOS de Inicio y cierre: ',horariosTomados.value);
        
          //   })
          //   .catch(function (error) {
          //     console.log(error);
          //   });   
          // }

        //***********************************************     */

        // PARA SABER SI ES IMPAR UN NRO   = n % 2;  DEVUELVE 1 SI ES IMPAR  / 0 SIE ES PAR
        //GENERAR HORARIOS DE LOS TURNOS
        //Declaras el arreglo donde meteras las fechas
        //*************************************** GENERADOR DE HORARIOS    */
  
          let a= 0;
          for ( let z=0; z<2; z++) {
              for(  ; d_hora < h_hora;  ){

                  if( (i % 2) === 0){
                    h_turno = d_hora.toString() + ':00';
                    i=1;            
                  }else{
                    h_turno =  d_hora.toString() + ':' + intervalo ;
                    d_hora++;
                    i=0;
                  }

                  hora = h_turno.padStart(2, "0");

                  console.log(hora);


                  horarios.value.push( {id: a, turno: hora});
            
                 // console.log('HORARIOS ARRAY: ',horarios.value)
                  a++;
              }
              //horarios.value.push(' ');
              d_hora = 17;
              h_hora = 20;
          }
          // ************************************************ 
    // *********************** INICIO DE BLOQUE TRAIDO DE CALENDARIOCOMPONENT.VUE  ********************** 
   // RUTINA QUE EXTRAE SOLO FECHAS Y HORAS  DE LOS TURNOS EN UN ARRAY
          const NuevoArray =  (array) => {
                return array.map(({f_turno}) => f_turno);
          }

          // RUTINA QUE CUENTA CUANTAS FECHAS REPETIDAS HAY DESDE EL NuevoArray (rut. de arriba)
          const contarRepetidos = (datos) => {
                    return datos.reduce(( a, d) =>  (a[d] ? a[d]  += 1 : a[d] = 1, a), {});
          }

         // console.log("QUE TRAE PLANI TURNOS length: ",PlaniTurnos.value.length);

          if(PlaniTurnos.value.length > 0){                        // si hay turnos ejecuta esto 
                nuevoArray.value = NuevoArray(PlaniTurnos.value);
                //console.log('ARRAY SOLO FECHAS: ',nuevoArray.value);
  
                repetidos.value = contarRepetidos(nuevoArray.value);
                // array repetidos tiene fecha y cantidad de veces.

                console.log('REPETIDOS: ',repetidos.value)
  

              // diasRepetidos contiene un array con los nombres de las fechas.
                let keyNames = Object.keys(repetidos.value);
                const diasRepetidos =[];
                console.log('COPIA DE REPETIDOS: ',keyNames)

                for(let d=0; d< keyNames.length; d++){
                  diasRepetidos.push(new Date(keyNames[d]))
                }
          }

     
        // ************ FIN RUTINA CANTIDAD PERS.POR TURNO ************************************
    // ***********************  FIN DE BLOQUE TRAIDO DE CALENDARIOCOMPONENT.VUE  **********************

          // DEVUELVE EL COLOR QUE TENDRA EL CASILLERO CON LA HORA DE ESE TURNO: 
          // VERDE = VACIO
          // AMARILLO = POCA GENTE
          // VERDE = COMPLETO

          colorDeTurno = computed (() => {
 
            //console.log('Evento del ccompute',e)
            if (horariosTomados.value > 3 ){
              return "bg-pink-300"
            }else{
              if(horariosTomados.value > 0 && horariosTomados.value < 3){
                 return "bg-yellow-300"
              }
              return "bg-green-300"
            }

          });
  
        // RUTINA QUE CONTROLA QUE ELIGIO UN TURNO Y HABILITA EL BOTON DE SUBMIT
          const marcoTurno = (indice) => {
        console.log("Hora Select: ",horarios.value[indice].turno, ' indice: ',indice)


            if(f_turno_dh.value.length>0){
                  btnDesabilitado.value = false;

                  if(  f_turno_dh.value[0].turno === horarios.value[indice].turno ){
                    return
                  }
            }else{
                  btnDesabilitado.value = true;
            }

            if(f_turno_dh.value.length === 2){
                toast.add({severity:'warn', summary: 'Exceso de turnos', detail: 'Solo se pueden tomar 2 turnos de 30 minutos', life: 3000});
                return
            }
            //hora_ant.value = horarios.value[indice].turno ;

            f_turno_dh.value.push({turno: horarios.value[indice].turno, id: f_turno_dh.value.length +1});   // Inserta un truno
  
            console.log('Horaiors que Tomo : ',f_turno_dh.value)
          }

         const borro = (idx) =>{
              f_turno_dh.value = f_turno_dh.value.filter(item => item.id !== idx);   // los 2 turnos que puede tomar
          }

        return {displayCargaTurno, horarios, btnDesabilitado, colorDeTurno, marcoTurno, bloqueoHorarios, f_turno_dh, hora_ant, borro}
    }
}
</script>

