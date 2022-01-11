<template>
<Toast />
  <h1>Configuración de Dias Cerrados</h1>
  <hr>
  
  <div class="container-fluid surface-100 p-2" >
      <div class="row align-items-evenly shadow-7  pb-4">
          <div class="col-sm-4 my-1">
              <Dropdown  class="w-full inputfield ml-1 my-2" id='idDeporte' v-model="selecDeporte" :options="deportes" :style="{width: '150px'}"
                          optionLabel="descripcion" optionValue="id_deporte" @hide="cambioDeporte" placeholder="Seleccione una actividad" />  
          </div>
 
          <div class="col-sm-4 my-2 pb-2 border-700 shadow-7" v-show="disbledPantalla" @click="muestro">
              <h5>Marque los dias que <b>NO</b> Atiede</h5>
              <div class="p-field-checkbox">
                  <Checkbox id="dia1" name="dia" value=0 v-model="dias" />
                  <label class="ml-1" for="dia1">Domingo</label>
              </div>

              <div class="p-field-checkbox">
                  <Checkbox id="dias2" name="dia" value=1 v-model="dias" />
                  <label class="ml-1" for="dias2">Lunes</label>
              </div>

              <div class="p-field-checkbox">
                  <Checkbox id="dia3" name="dia" value=2 v-model="dias" />
                  <label class="ml-1" for="dia3">Martes</label>
              </div>

              <div class="p-field-checkbox">
                  <Checkbox id="dia4" name="dia" value=3 v-model="dias" />
                  <label class="ml-1" for="dia4">Miercoles</label>
              </div>

              <div class="p-field-checkbox">
                <Checkbox id="dia5" name="dia" value=4 v-model="dias" />
                <label class="ml-1" for="dia5">Jueves</label>
              </div>

              <div class="p-field-checkbox">
                  <Checkbox id="dia6" name="dia" value=5 v-model="dias" />
                  <label class="ml-1" for="citdia6y4">Viernes</label>
              </div>

              <div class="p-field-checkbox ">
                  <Checkbox id="dia7" name="dia" value=6 v-model="dias" />
                  <label class="ml-1" for="dia7">Sábado</label>
              </div>
              <hr >
              <div  class="card-containe flex align-content-center" >
                  <div class="p-field p-md-3 inline-block">
                      <strong>Anticipación</strong>
                      <label for="vertical" style="display: block">Dias</label>
                      <InputNumber v-model="diasAnticipados" mode="decimal" showButtons buttonLayout="vertical" style="width:4rem" :min="0" :max="360"
                          decrementButtonClass="p-button-secondary" incrementButtonClass="p-button-secondary" incrementButtonIcon="pi pi-plus" 
                          decrementButtonIcon="pi pi-minus" />                      
                  </div>  
 
                  <div class="p-field p-md-3 inline-block">
                  <strong>Usuarios por Turno</strong>
                      <label for="vertical" style="display: block">cantidad</label>
                      <InputNumber v-model="usuariosTurno" mode="decimal" showButtons buttonLayout="vertical" style="width:4rem" :min="0" :max="360"
                          decrementButtonClass="p-button-secondary" incrementButtonClass="p-button-secondary" incrementButtonIcon="pi pi-plus" 
                          decrementButtonIcon="pi pi-minus"/>               
                  </div>               
               
              </div>
          </div>

          <div class="col-sm-4 my-1" v-show="disbledPantalla">
              <h5>Tipo de Horario</h5>
              <div class="radios" @click="verHorario"> 
                  <div class="p-field-radiobutton">
                      <RadioButton id="Hoario1" name="horario" value='1' v-model="tipoHorario" />
                      <label class="ml-1"  for="De corrido">De Corrido</label>
                  </div>
                  <div class="p-field-radiobutton">
                      <RadioButton id="Hoario2" name="horario" value='2' v-model="tipoHorario" />
                      <label class="ml-1"  for="Hoario2">Cortado</label>
                  </div>

              </div>

              <div class="card-container p-0" v-if="cortado || corrido">
                  <div class="p-field p-md-3 inline-block ">
                      <label for="vertical" style="display: block">desde</label>
                      <InputNumber v-model="d_hora" mode="decimal" showButtons buttonLayout="vertical" style="width:4rem" :min="0" :max="24"
                          decrementButtonClass="p-button-secondary" incrementButtonClass="p-button-secondary" incrementButtonIcon="pi pi-plus" 
                          decrementButtonIcon="pi pi-minus" />
                  </div>

                  <div class="p-field p-md-3 inline-block">
                      <label for="vertical" style="display: block">Hasta</label>
                      <InputNumber v-model="h_hora" mode="decimal" showButtons buttonLayout="vertical" style="width:4rem" :min="d_hora" :max="60"
                          decrementButtonClass="p-button-secondary" incrementButtonClass="p-button-secondary" incrementButtonIcon="pi pi-plus" 
                          decrementButtonIcon="pi pi-minus" />                      
                  </div>  
 
                  <div class="p-field p-md-3 inline-block">
                      <label for="vertical" style="display: block">Intervalo Min</label>
                      <InputNumber v-model="inter1" mode="decimal" showButtons buttonLayout="vertical" style="width:4rem" :min="0" :max="60"
                          decrementButtonClass="p-button-secondary" incrementButtonClass="p-button-secondary" incrementButtonIcon="pi pi-plus" 
                          decrementButtonIcon="pi pi-minus" :step="10"/>               
                  </div>                    
              </div>

             <div class="card-container p-0"  v-if="cortado">
                  <div class="p-field p-md-3 inline-block ">
                      <label for="vertical" style="display: block">desde</label>
                      <InputNumber v-model="d_hora2" mode="decimal" showButtons buttonLayout="vertical" style="width:4rem" :min="h_hora" :max="24"
                          decrementButtonClass="p-button-secondary" incrementButtonClass="p-button-secondary" incrementButtonIcon="pi pi-plus" 
                          decrementButtonIcon="pi pi-minus" />
                  </div>

                  <div class="p-field p-md-3 inline-block">
                      <label for="vertical" style="display: block">Hasta</label>
                      <InputNumber v-model="h_hora2" mode="decimal" showButtons buttonLayout="vertical" style="width:4rem" :min="d_hora2" :max="60"
                          decrementButtonClass="p-button-secondary" incrementButtonClass="p-button-secondary" incrementButtonIcon="pi pi-plus" 
                          decrementButtonIcon="pi pi-minus" />                      
                  </div>  

                  <div class="p-field p-md-3 inline-block">
                      <label for="vertical" style="display: block">Intervalo Min</label>
                      <InputNumber v-model="inter2" mode="decimal" showButtons buttonLayout="vertical" style="width:4rem" :min="0" :max="60"
                          decrementButtonClass="p-button-secondary" incrementButtonClass="p-button-secondary" incrementButtonIcon="pi pi-plus" 
                          decrementButtonIcon="pi pi-minus" :step="10" />                   
                  </div>                     
              </div>
          </div>
      </div>
      <div class="row mb-1 mt-2" >
          <button class="btn btn-primary" @click="salirSinGrabar">Salir sin Gaabar</button>
      </div>      
      <div class="row mb-3 pb-2" >
          <button class="btn btn-primary" @click="actulizoConfig" :disabled="!disbledPantalla">Actualizar Congiguración</button>
      </div>
  </div>
</template>


<script>
import { computed } from '@vue/reactivity';
import { ref, onMounted, inject } from 'vue';
import { useToast } from 'primevue/usetoast';
import { useRouter } from "vue-router";

export default {
  setup(){
    onMounted(() => {
          listarDeportes();
      });

    const toast = useToast();
    const router = useRouter();


    let id_horario = ref();
    let id_horario2 = ref();
    let d_hora = ref(0);
    let h_hora = ref(0);

    let d_hora2 = ref(0);
    let h_hora2= ref(0);
    let inter1 = ref(0);
    let inter2 = ref(0);
        
    const config_deporte = ref();
    let dias = ref(null);
    let arrayMostrar = [];
    let selecDeporte = ref();              // usada en el DropDown 
    let deportes = ref();
    let datosConfiguracion = ref();
    const url = inject("url");
    const tipoHorario = ref();
    let cortado = ref(false);
    let corrido = ref(false);
    let disbledPantalla  = ref(false)
    let diasAnticipados = ref(0);
    let usuariosTurno = ref(0);

    const cambioDeporte =   () => {
        if(selecDeporte.value === '' || selecDeporte.value === undefined){
            toast.add({severity:'warn', summary: 'Error en Ingreso', detail: 'Debe Seleccionar una Actividad', life: 3000});
            disbledPantalla.value = false ;
            return false
        }else{
            recuperarConfig( selecDeporte.value);
            config_deporte.value = deportes.value.find( ele => ele.id_deporte === selecDeporte.value );
          //  console.log("CONFIG ", config_deporte.value)
            usuariosTurno.value =  parseInt(config_deporte.value.usuarios_por_turno);
            diasAnticipados.value =  parseInt(config_deporte.value.anticipacion);

            disbledPantalla.value = true ;
        }
    }


    const recuperarConfig = async (deporteSeleccionado) => {
      await axios.post(url, {opcion:5, selecDeporte: deporteSeleccionado})
        .then(response =>{
            datosConfiguracion.value = response.data;       
            
            // llenar datos de pantalla fran
            id_horario.value = d_hora.value = h_hora.value = inter1.value = dias.value = d_hora2.value = h_hora2.value = inter2.value = null;
            tipoHorario.value ="1";

            corrido.value =  cortado.value = null;
            
        
            if(datosConfiguracion.value.length > 0){
              for (let index = 0; index < datosConfiguracion.value.length; index++) {
                
                if(index===0){
                  id_horario.value = datosConfiguracion.value[index].id_horario;
                  d_hora.value =  parseInt(datosConfiguracion.value[index].d_hora.substring(0,2));
                  h_hora.value =  parseInt(datosConfiguracion.value[index].h_hora.substring(0,2));
                  inter1.value =  parseInt(datosConfiguracion.value[index].intervalo);
                  dias.value   =  datosConfiguracion.value[index].dias_sin_atencion.split(",");
                  corrido.value = true;
                  tipoHorario.value ="1";

                }else{
                  id_horario2.value = datosConfiguracion.value[index].id_horario;
                  if(parseInt(datosConfiguracion.value[index].d_hora.substring(0,2)) > 0){
                    d_hora2.value =  parseInt(datosConfiguracion.value[index].d_hora.substring(0,2));
                    h_hora2.value =  parseInt(datosConfiguracion.value[index].h_hora.substring(0,2));
                    inter2.value  =  parseInt(datosConfiguracion.value[index].intervalo);
                    cortado.value = true;        
                    tipoHorario.value ="2";
                  }
                }
                
              }  // fin del for

            } //fin del if
        })
        .catch(function (error) {
          console.log(error);
        });   
    }    

    // Esta rutina sirva para ponerla en el CALENDARIO Cuando recupere la configurancion.
    const clonaArray = () => {
      let nuevoArray = [];

      for (let index = 0; index < dias.value.length; index++) {
        nuevoArray[index] = parseInt(dias.value[index]);
      }
      console.log("Nuevo array ",nuevoArray);
    }
    // *******************************************************************************

    const actulizoConfig = async () => {

      // **************  conversion de datos
      const desde_hora = String(d_hora.value) + ':00:00';
      const hasta_hora = String(h_hora.value) + ':00:00';
      const desde_hora2 = String(d_hora2.value) + ':00:00';
      const hasta_hora2 = String(h_hora2.value) + ':00:00';
  

      // console.log("dias anterior: ",dias.value)
      // console.log("dias a string: ",String(dias.value))

      dias.value[0] === '' ? dias.value.splice(0, 1) : dias.value
      // if(dias.value[0]===''){

      // }
      const diasCerrados = dias.value.toString();
      // console.log("dias a toString: ",diasCerrados)

      
      // console.log("tipo de horario: ",tipoHorario.value)
      // console.log("desde hora 2: ",d_hora2.value)
      // console.log("hasta Hora 2: ",h_hora2.value)
      // console.log("Intervalo 2: ",inter2.value)


 //     console.log("dias cerrado: ", diasCerrados);
      // ************** 
      await axios.post(url, {opcion:14, selecDeporte: selecDeporte.value, dias_sin_atencion: diasCerrados, d_hora: desde_hora, h_hora: hasta_hora,
                                        intervalo: inter1.value, d_hora2: desde_hora2, h_hora2: hasta_hora2, intervalo2: inter2.value, 
                                        id_horario: id_horario.value, id_horario2: id_horario2.value, diasAnticipados:   diasAnticipados.value, 
                                        usuariosTurno: usuariosTurno.value  })
        .then(response =>{
            const ok = response.data;       
            console.log("resultado update: ", ok);
        })
        .catch(function (error) {
          console.log(error);
        });   

        location.reload();
    }

    const verHorario = () =>{
        switch (tipoHorario.value) {
          case "1":                       // de corrido
            corrido.value = true;
            cortado.value = false;
            d_hora2.value = 0;
            h_hora2.value = 0;
            inter2.value = 0;
            break;

           case "2":                      // cortado
            corrido.value = true;
            cortado.value = true;

            break;
               
          default:
            corrido.value = false;
            cortado.value = false;         
            break;
        }
    };

    const salirSinGrabar = () => {
        router.push("/");
    }

    const listarDeportes = async () => {              
          await axios.post(url, {opcion:2})
          .then(response=>{
            deportes.value = response.data;
          })
          .catch(function (error) {
            console.log(error);
          });   
    }

    const muestro = ()=>{
      console.log("DIAS: ", dias.value)
    }

    return {dias, actulizoConfig, cambioDeporte, recuperarConfig, arrayMostrar, deportes, selecDeporte,tipoHorario, muestro,
            cortado, corrido, verHorario, d_hora, h_hora, d_hora2, h_hora2, inter1, inter2, disbledPantalla, salirSinGrabar,
            diasAnticipados, usuariosTurno }
  }
}
</script>

<style>

</style>