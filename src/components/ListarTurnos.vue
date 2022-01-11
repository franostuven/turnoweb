<template>
    <Toast/>
    <div >
        <h4 class="m-3 text-center">Horarios</h4>

        <div class="p-col-12 p-md-2 mb-2">
            <InlineMessage severity="success" class='mr-2'>Libre</InlineMessage>
            <InlineMessage severity="warn" class='mr-2'>Algunos Libres</InlineMessage>
            <InlineMessage severity="error">Completo</InlineMessage>

        </div>
        <strong class="mt-2">Los turnos son de 1 por dia.</strong>

        <div class="grid flex align-content-center mt-3" v-if="displayCargaTurno" id="horarios">     <!--@click="marcoTurno(hora.id)-->
            <div v-for="(hora, index) in horarios" :key="index"  :class="[colorDeTurno(hora)]"   @click="marcoTurno(hora.id)" :id="hora.id"
                  class="col-12 md:col-6 lg:col-2 align-content-center border-white-alpha-90 border-3 h-3rem"  >
                  <div  class="col-12 md:col-4 lg:col-4 flex"  >
                      <strong>{{hora.turno}}</strong>                      <!-- :id="'list-' + index" :disabled="desabilito === 'list-' + index ? true : false" -->
                  </div>
            </div>
             
        </div>

        <h4><b> Hora seleccionada </b></h4>
        <div class="card border-200 shadow-8 ">
              <div class="flex flex-wrap card-container surface-100" v-for="(miTurno, f_ind) in f_turno_dh" :key="f_ind">
                    <p class="align-content-center ml-2 mt-2">Turno Desde: {{miTurno.turno}} - Hasta las : {{miTurno.hasta}}</p>
                    <Button icon="pi pi-times" class="p-button-rounded p-button-danger p-button-text" @click="borro(miTurno.id)" />
              </div>
        </div>
    </div>    

</template>

<script>
import {toRef, inject, onMounted, ref, computed, provide} from 'vue';
import { useToast } from 'primevue/usetoast';

export default {
    props: {
      selecDeporte: Number
    }, 
    setup(props){
        onMounted(() =>{
           horioPorFecha()
        });

        // let selDeporte = ref(props.selecDeporte);
         
        let configuraHorarios = ref();
        let indice = ref(0);  // usado en el for de hoarios.
        const toast = useToast();
        let hora_ant = ref('') ;  // guarda la primer hora seleccionada, (se puede hacer en un array de 2 elem.)
        let bloqueoHorarios = ref(false)   // bloquea el DIV de horios cuando toco 2 turnos
        const horarios = ref([]);
        let nuevoArray = ref([]);             // array consolo las fechas de los turnos
        let repetidos = ref([]);              // array con las fechas repetidas

        let btnDesabilitado = inject('btnDesabilitado');  // para habilitar el boton SUBMIT  (LO HABILITA marcoTurno)
        const fechaTurno = inject('fechaTurno');
        const displayCargaTurno = inject("displayCargaTurno");
        const url = inject("url");
        const PlaniTurnos = inject("PlaniTurnos");       
        const f_turno_dh = inject("f_turno_dh");   // Array con los turnos que tomo
        const config_deporte = inject("config_deporte");  // cofig- dias de anticipacion y usuarios_turno
 
        //  RUTINA QUE RECUPERA LOS HORARIOS DE UN  DEPORTE (HORA INICIO - HORA DE FIN Y SU INTERVALO) (TABLA HORARIOS)
        // PARA SER USADA EN EL FOR DE ABAJO.  !!!!!  NO LA LLAMA NADIE AUN!!!!
        // CAMBIAR EN ESTE PROG. =  INTERVALO, D_TURNO, H_TURNO, HORADETURNO > 3 (por su varible) Y EL FOR DE ABAJO
              // **********************************************

        console.clear();

        const horioPorFecha = async () => {              
          await axios.post(url, {opcion:5, selecDeporte: props.selecDeporte })
            .then(response=>{
              configuraHorarios.value = response.data;
            
              for (const iterator of configuraHorarios.value) {
                  indice.value = generarHorario(iterator, indice.value)
              }

            })
            .catch(function (error) {
              console.log(error);
            });   
        }

        //***********************************************     */

        // PARA SABER SI ES IMPAR UN NRO   = n % 2;  DEVUELVE 1 SI ES IMPAR  / 0 SIE ES PAR
        //GENERAR HORARIOS DE LOS TURNOS
        //Declaras el arreglo donde meteras las fechas
        //*************************************** GENERADOR DE HORARIOS    */
        
        const generarHorario = (horario, a) => {
              let hora_entera = 0;
              let parte_minutos = 0;
              let h_turno = '';
              let hora = '';
              const interval = horario.intervalo / 100;
              let desde_hora = Math.trunc(parseInt(horario.d_hora)); // returns 3 
              let hasta_Hora = Math.trunc(parseInt(horario.h_hora)); // returns 3

              for(  ; desde_hora < hasta_Hora ; ){

                  hora_entera = Math.trunc(desde_hora); // returns 3
                  parte_minutos = Number((desde_hora - hora_entera).toFixed(2)); // return 0.2

                  if(parte_minutos === 0.0){
                      h_turno = hora_entera.toString() + ':00' ;

                  }else if(parte_minutos === 0.60) {
                      desde_hora = hora_entera + 1;
                      h_turno =  desde_hora.toString() +  ':00' ;

                  } else {
                      parte_minutos *= 100;
                      h_turno =  hora_entera.toString() +  ':' + parte_minutos.toString().padStart(2, "0");
                      
                  }

                  hora = h_turno.padStart(2, "0");
                  
                  desde_hora+= interval;
                 
                  horarios.value.push({id: a, turno: hora, ultimo: 0});

                  a++;
              }
              horarios.value[a-1].ultimo = 1;
              return a;
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

        if(PlaniTurnos.value.length > 0){                        // si hay turnos ejecuta esto 
              nuevoArray.value = NuevoArray(PlaniTurnos.value);
              repetidos.value = contarRepetidos(nuevoArray.value);

        }

      // diasRepetidos contiene un array con los nombres de las fechas.
        let keyNames = Object.keys(repetidos.value);
        const diasRepetidos =[];

        for(let d=0; d< keyNames.length; d++){
          diasRepetidos.push(new Date(keyNames[d]))
        }

        // ************ FIN RUTINA CANTIDAD PERS.POR TURNO ************************************
    // ***********************  FIN DE BLOQUE TRAIDO DE CALENDARIOCOMPONENT.VUE  **********************

        // Rellena con ceros a la izquierda
        function padLeadingZeros(num) {
            var s = "0" + num;
            return s.substr(s.length-2);
        }

        // ********************************
        const colorDeTurno = (hora) => {
             
              if(hora.ultimo === 1){
                return "bg-bluegray-400"
              }else{

                  let posicion = hora.turno.indexOf(":");   //1 
                  let largo = hora.turno.length;            // 5
                  let miHora = padLeadingZeros(hora.turno.substr(0, posicion ));
                  let minuto = hora.turno.substr(posicion+1, largo );


                const dia = padLeadingZeros(fechaTurno.value.getDate().toString());
                const mes = padLeadingZeros((fechaTurno.value.getMonth()+1).toString());
             

                const busco = fechaTurno.value.getFullYear().toString() +'-'+ mes +'-'+ dia +' '+ miHora+':'+ minuto + ':00';

                const indiceTurno = keyNames.indexOf(busco);
        //        console.log("BUSCO: ", busco)

                if(indiceTurno>=0){
                  const objeto = Object.getOwnPropertyDescriptor(repetidos.value, busco.trim());

                  const horariosTomados = objeto.value;  // cantidad de personas por turno

                  if(horariosTomados === parseInt(config_deporte.value.usuarios_por_turno)) {
                      return "bg-pink-300"
                    }else if(horariosTomados === parseInt(config_deporte.value.usuarios_por_turno)-1){
                      return 'bg-yellow-300';
                    }else{
                      return 'bg-green-300';    
                    }
                }else{
                  return 'bg-green-300';
                }
              }
        };
    
  
        // RUTINA QUE CONTROLA QUE ELIGIO UN TURNO Y HABILITA EL BOTON DE SUBMIT
        const marcoTurno = (indice) => {
            
            if(document.getElementById(indice).classList.contains("bg-pink-300")){
              toast.add({severity:'warn', summary: 'Turno Completo', detail: 'Este horario ya esta completo', life: 3000});
              return 
            }
            
            if(horarios.value[indice].ultimo === 1){
                toast.add({severity:'warn', summary: 'Fuera de Hora', detail: 'Es la hora de cierre, no hay turno', life: 3000});
                return          
            }

            if(f_turno_dh.value.length === 1){
                toast.add({severity:'warn', summary: 'Exceso de turnos', detail: 'Solo se puede tomar 1 turno.', life: 3000});
                return
            }
                 //  ESTAS 2 SE REEMPLAZARON POR EL IF DE ARRIBA, ESTO ERA CUANDO SE PODIA SELECCIONAR 2 TURNOS.
            // if(f_turno_dh.value.length === 2){
            //     toast.add({severity:'warn', summary: 'Exceso de turnos', detail: 'Solo se pueden tomar 2 turnos de 30 minutos', life: 3000});
            //     return
            // }

            // if(f_turno_dh.value.length === 1){   // estoy ingresando el segundo turno, comparo
            //       if(f_turno_dh.value[0].id > indice){
            //         toast.add({severity:'warn', summary: 'Turno inválido', detail: 'No puede seleccionar un Turno Menor al anterior', life: 3000});
            //         return                   
            //       }
            // }

            

            const newId = ( indice + 1 > horarios.value.length -1) ? indice : indice + 1 ;
            f_turno_dh.value.push({turno: horarios.value[indice].turno, hasta: horarios.value[newId].turno, id: indice });   // Inserta un truno


            if(f_turno_dh.value.length>0){
                  btnDesabilitado.value = false;

                  if(  f_turno_dh.value[0].turno === horarios.value[indice].turno ){
                    return
                  }
            }else{
                  btnDesabilitado.value = true;
            }

            // nuevoTurno = horarios.value[indice].turno + configuraHorarios.value[0].intervalo ;
            // f_turno_dh.value.push({turno: horarios.value[indice].turno, hasta: nuevoTurno, id: indice });   // Inserta un truno




            f_turno_dh.value.sort(function (a, b) {
            if (a.turno > b.turno) {
              return 1;
            }
            if (a.turno < b.turno) {
              return -1;
            }
            // a must be equal to b
            return 0;
            });

           // console.log('Horaiors que Tomo : ',f_turno_dh.value)
        }

        const borro = (idx) =>{
            f_turno_dh.value = f_turno_dh.value.filter(item => item.id !== idx);   // los 2 turnos que puede tomar
        }

        return {displayCargaTurno, horarios, btnDesabilitado, colorDeTurno, marcoTurno, bloqueoHorarios, f_turno_dh, hora_ant, borro,
                 }
    }
}
</script>

