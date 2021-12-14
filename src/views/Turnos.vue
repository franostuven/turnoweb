<template>
    <h1 class="text-center my-4">Sistema de Turnos</h1>
      
    <form @submit.prevent="enviarTurno">
        <div class="container surface-100" style="height: 70%;" >
            <div class="formgrid grid">
              <div class="field col-12 md:col-6">
                  <div class="p-float-labe mt-5">
                      <InputText  type="email"  id="mailUsuario" v-model.trim="mailUsuario" class="w-full inputfield"/>
                      <label  for="mailUsuario"> Ingrese mail Autorizado para reserva</label>
                  </div>
                  
                  <CalendarioComponent :selecDeporte="selecDeporte" v-if="mostrarCalendario"></CalendarioComponent>
                  
              </div>

              <div class="field col-12 md:col-6 mt-5" >
                  <div class="p-float-label">
                      <!--  <h5>Seleccione una Opción</h5> -->
                      <Dropdown  class="w-full inputfield" id='idDeporte' v-model="selecDeporte" :options="deportes" :disabled="habilitoDrop"
                                optionLabel="descripcion" optionValue="id_deporte" @hide="cambioDeporte"  />   <!--:tabindex="dropIndex"  -->
                      <label  for="idDeporte"> Seleccione una opcion para un turno</label>

                  </div>
                    
                  <listar-turnos v-if="displayCargaTurno"></listar-turnos>
            
              </div>
      
            </div>
                
            
        </div>

    </form>
</template>

<script>
  

  //let url = "crud.php";  // produccion

  import {ref, computed, onMounted, inject } from 'vue';
  import { useStore } from "vuex";
  import { useToast } from 'primevue/usetoast';
  import {useRouter} from 'vue-router';
  import ListarTurnos from '../components/ListarTurnos.vue'
  import CalendarioComponent from '../components/CalendarioComponent'

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
      const url = inject("url");


        //  USO DEL ROUTER  Y DEL TOAST
      //  router.push('/'),
      //   toast.add({severity:'success', summary: 'Successful', detail: 'Link Actualizado', life: 3000});


      // VARIABLES

      let mailUsuario = ref('');              // usurio de reserva
      let selecDeporte = ref();              // usada en el DropDown 
      let habilitoDrop = ref(true);          //swich que habilta o deshabilita el DropD
      const displayCargaTurno = ref(false);  //swich que abre ventana carga de turnos
      const mostrarCalendario = ref(false);  //swich que muestra el calendario

      const deportes =ref();               // Array con las disciplinas
             
      //  ***************************  RUTINAS ******************************
      //     maxDate.value = computed (() => maximoDia.value.setDate(today.getDate() + diaProximo.value));

     // Recupera todos los deportes para el DropDown  (usado en el onMounted) (TABLA TURNOS)
     // ADEMAS LOS DIAS DE ANTICIP. Y CANT. DE PERSONAS POR TURNO
      const listarDeportes = async () => {              
          await axios.post(url, {opcion:2})
          .then(response=>{
            deportes.value = response.data;
         //   console.log('CONFIGURACION DEPORTE: ',deportes.value);
          })
          .catch(function (error) {
            console.log(error);
          });   
      }
      // **************************

        habilitoDrop = computed(() => {
          console.log("computed: ", habilitoDrop)
          if(mailUsuario.value !== ''){
            return false
          } else{
            return true
          }
        })
      // **************************

      const cambioDeporte =  () => console.log(selecDeporte.value);
           
     // *********************   SUBMIT   **************
      const enviarTurno = () => {

        console.log( 'FECHA DE TURNO: ',fechaTurno.value);
        console.log('DEPORTE: ',selecDeporte.value);
        toast.add({severity:'success', summary: 'Turno Agendado', detail: 'El turno se Agrego Satisfactoriamente.', life: 3000});

        fechaTurno.value = new Date();
        selecDeporte.value = '';
        
        displayCargaTurno.value = false;
        mostrarCalendario.value = false;

      };

      // **************************


      // RETORNO DE VARIABLES (celeste) Y RUTINAS (amarillas)
      return{ deportes, selecDeporte, displayCargaTurno, mailUsuario, mostrarCalendario, habilitoDrop,
              enviarTurno, cambioDeporte }
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