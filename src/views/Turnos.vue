<template>
  <Toast />
    <h1 class="text-center my-4">Sistema de Turnos</h1>
      
    <form @submit.prevent="enviarTurno">
        <div class="container surface-100" style="height: 70%;" >
            <div class="formgrid grid">
              <div class="field col-12 md:col-6">
                  <div class="p-float-label mt-5">
                      <InputText  type="email"  id="mailUsuario" v-model.trim="mailUsuario" class="w-full inputfield" 
                                  :class="{'p-invalid': focusOut}"  @blur="validoMail"/>
                      <label  for="mailUsuario"> Ingrese mail Autorizado para reserva</label>
                     

                  </div>
                  <small v-show="focusOut" class="p-error">El Mail NO puede estar vacio y debe ser Válido.</small>
                  
                  <CalendarioComponent :selecDeporte="selecDeporte" v-if="mostrarCalendario"></CalendarioComponent>
                  
              </div>

              <div class="field col-12 md:col-6 mt-5" >
                  <div class="p-float-label">
                      <!--  <h5>Seleccione una Opción</h5> -->
                      <Dropdown  class="w-full inputfield" id='idDeporte' v-model="selecDeporte" :options="deportes" :disabled="habilitoDrop"
                                optionLabel="descripcion" optionValue="id_deporte" @hide="cambioDeporte"  />   <!--:tabindex="dropIndex"  -->
                      <label  for="idDeporte"> Seleccione una opcion para un turno</label>

                  </div>
                    
                  <listar-turnos :selecDeporte="selecDeporte" v-if="mostrarCalendario"></listar-turnos> 
            
                  <div class="grid my-4 " >
                      <Button label="Hacer Reserva" icon="pi pi-check" class="p-button-lg ml-3 " type="submit" :disabled="btnDesabilitado" />
                      <Button label="Cancelar" icon="pi pi-times" class="p-button-lg ml-3 p-button-warning " @click="RecargaPagina" />
                  </div>  
              </div>
      
            </div>
                
            
        </div>

    </form>
</template>

<script>
  

  //let url = "crud.php";  // produccion

  import {ref, computed, onMounted, inject, provide } from 'vue';
  import { useStore } from "vuex";
  import { useToast } from 'primevue/usetoast';
  import {useRouter} from 'vue-router';
  import ListarTurnos from '../components/ListarTurnos.vue'
  import CalendarioComponent from '../components/CalendarioComponent.vue'

  export default {

    components:{
      ListarTurnos,
      CalendarioComponent
    },
    setup(context){
      onMounted(() => {
              listarDeportes();
      });

      // IMPORTACIONES
      //const store = useStore();
      const toast = useToast();
      const router = useRouter();
      const valEmail = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      const focusOut = ref(true);
      const displayCargaTurno = ref(false);  //swich que abre ventana carga de turnos

      //  USO DEL ROUTER  Y DEL TOAST
      //  router.push('/'),
      //   toast.add({severity:'success', summary: 'Successful', detail: 'Link Actualizado', life: 3000});

      

     
      let fechaTurno = ref(new Date())
     
      // VARIABLES
      let btnDesabilitado = ref(true);       // deshabilita el boton de Enviar Reserva
      let mailUsuario = ref('');              // usurio de reserva
      let selecDeporte = ref();              // usada en el DropDown 
      let habilitoDrop = ref(true);          //swich que habilta o deshabilita el DropD
      const mostrarCalendario = ref(false);  //swich que muestra el calendario
      let f_turno_dh = ref([])               // Definicion array de horas seleccionadas. (ListarTurnos.vue)
      let id_Usuario = null ;

      const deportes =ref();               // Array con las disciplinas
      const PlaniTurnos = ref([]);            // Array de fechas con turnos       
      
      provide("f_turno_dh", f_turno_dh);   // Array con los turnos que tomo (usada en ListarTurnos.vue)
      provide('btnDesabilitado', btnDesabilitado); // BOTON DE SUBMIT DESHABILITADO
      provide('displayCargaTurno', displayCargaTurno);  // SWICH PARA HABILITAR HORARIOS
      provide('fechaTurno', fechaTurno); // FECHA DEL TURNO SELECCIONADO
      provide('PlaniTurnos', PlaniTurnos); // Comportir a los 2 componentes 
      const url = inject("url");

      //  ***************************  RUTINAS ******************************
      //     maxDate.value = computed (() => maximoDia.value.setDate(today.getDate() + diaProximo.value));

     // Recupera todos los deportes para el DropDown  (usado en el onMounted) (TABLA TURNOS)
     // ADEMAS LOS DIAS DE ANTICIP. Y CANT. DE PERSONAS POR TURNO
      const listarDeportes = async () => {              
          await axios.post(url, {opcion:2})
          .then(response=>{
            deportes.value = response.data;
          })
          .catch(function (error) {
            console.log(error);
          });   
      }
      // **************************  VALIDA QUE EL MAIL DEL USUARIO DEL TURNO EXISTA EN LA BASE. RECUPERA ID.
      const validoMail = async (e) => {

          if(e.target.value){
              if(valEmail.test(mailUsuario.value)){
                focusOut.value = false ;
              } else{
                focusOut.value = true
                habilitoDrop.value = true ;
              }  

              let verif_mail = '';
              await axios.post( url, {opcion: 0, mail: e.target.value})
                .then( response =>{
                  verif_mail = response.data ;  
                })
                .catch(function (error) {
                  console.log(error);
                });   
      

              if(verif_mail.length > 0){
                
                id_Usuario = verif_mail[0].id_cliente ;
                habilitoDrop.value = false ;

              }else{
                  toast.add({severity:'error', summary: 'ERROR USUARIO', detail: 'El Usuario ingresado No esta Registrado', life: 3000});
                  habilitoDrop.value = true ;
                  return false
              }
        
          }else{
              console.log('blur vacio');
          }
      }

// **************************

        // habilitoDrop = computed(() => {
        //  // console.log("computed: ", habilitoDrop)
        //   if( mailUsuario.value !== '' && valEmail.test(mailUsuario.value)){
        //     focusOut.value = false
        //  //   console.log("validador: ",focusOut.value)
        //     return false
        //   } else{
        //     focusOut.value = true
        //  //   console.log("validador: ",focusOut.value)

        //     return true
        //   }
        // })
      // **************************

      const cambioDeporte =   async () => {
        
        if(selecDeporte.value === '' || selecDeporte.value === undefined){
            return false
        }
        habilitoDrop.value = true ;

      //   console.log("QUE TIENE DEPORTE ?: ",selecDeporte.value)
 // *********************** ARRAY CON LOS TURNOS QUE HAY DESDE HOY EN ADELANTE DE 1 DEPORTE PARTIC. (TABLA TURNOS) **********
        await axios.post(url, {opcion:4, selecDeporte: selecDeporte.value})
          .then(response =>{
              PlaniTurnos.value = response.data;       
              
             //   console.log('Datos de PlaniTurnos en calendar: ',PlaniTurnos.value)
          })
          .catch(function (error) {
            console.log(error);
          });   
  
      
        // **************************************************  FIN RUTINA DE CARGA INICIAL MOUNTED

          mostrarCalendario.value = true
      }
           
     // *********************   SUBMIT   **************
      const enviarTurno = async () => {

        if(f_turno_dh.value.length === 0 ){
          toast.add({severity:'error', summary: 'Hora de Turno', detail: 'No ha seleccionado horario del turno', life: 3000});
          return 
        }

          // probar el for of
          // for (const iterator of f_turno_dh.value) {
            
          // }

          // ninguno de los 2 for funciona no espera el async - await
 //       f_turno_dh.value.forEach(element => {
      //  for(let i=0; i<f_turno_dh.value.length; i++){


            let i=0
            let posicion = f_turno_dh.value[i].turno.indexOf(":");   //1 
            let largo = f_turno_dh.value[i].turno.length;            // 4
            let hora = f_turno_dh.value[i].turno.substr(0, posicion );
            let minuto = f_turno_dh.value[i].turno.substr(posicion+1, largo );

            fechaTurno.value.setHours(hora, minuto, 0);
            // ************************************************ 
                  let ok = '';

            await axios.post(url, {opcion:8, id_usuario : id_Usuario, selecDeporte : selecDeporte.value, fturno: fechaTurno.value })
                  .then( response => {
                    ok = response.data

                    i=1
                    posicion = f_turno_dh.value[i].turno.indexOf(":");   //1 
                    largo = f_turno_dh.value[i].turno.length;            // 4
                    hora = f_turno_dh.value[i].turno.substr(0, posicion );
                    minuto = f_turno_dh.value[i].turno.substr(posicion+1, largo );

                    fechaTurno.value.setHours(hora, minuto, 0);
                  
                    actualizoTurno(id_Usuario, selecDeporte.value, fechaTurno.value)            

                  })

                  .catch(function (error) {
                  console.log(error);
                });                   
 

   //     };


        // f_turno_dh.value.forEach(element => {
        //   actualizoTurno(mailUsuario.value, selecDeporte.value, element.turno)
        // });
        

        toast.add({severity:'success', summary: 'Turno Agendado', detail: 'El turno se Agrego Satisfactoriamente.', life: 3000});

        RecargaPagina();
      };
       // *********************************************

      const RecargaPagina = () => {
          location.reload();
      }

      // *********************************************
      const actualizoTurno = async (a,b,c) => {
          let ok = '';

          console.log("A GAURDAR:", c)
          await axios.post(url, {opcion:8, id_usuario : a, selecDeporte : b, fturno: c })
                .then( response => {
                  ok = response.data
                })

                .catch(function (error) {
                  console.log(error);
                });                   
      };
      // **************************


      // RETORNO DE VARIABLES (celeste) Y RUTINAS (amarillas)
      return{ deportes, selecDeporte, displayCargaTurno, mailUsuario, mostrarCalendario, habilitoDrop, focusOut, fechaTurno, btnDesabilitado,
              enviarTurno, cambioDeporte, validoMail, RecargaPagina}
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

  .turnosVacio {
    background-color: aqua;
  }

  .turnoMedio{
    background-color:gold ;
  }

  .turnoCompleto{
    background-color:red ;
  }
</style>