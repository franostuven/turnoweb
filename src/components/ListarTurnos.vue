<template>

    <!-- <Dialog header="Header" v-model:visible="displayCargaTurno" :style="{width: '50vw'}"> -->
    <div >
        <h4 class="m-3 text-center">Horarios</h4>

        <div class="p-col-12 p-md-2 mb-2">
            <InlineMessage severity="success" class='mr-2'>Libre</InlineMessage>
            <InlineMessage severity="warn" class='mr-2'>Algunos Libres</InlineMessage>
            <InlineMessage severity="error">Completo</InlineMessage>

        </div>

        <div class="grid flex" v-for="(hora, index) in horarios" :key="index">  
            <div class="col bg-pink-300 border-white-alpha-90 border-3 h-3rem">8:00</div>
            <div class="col bg-pink-300  border-white-alpha-90 border-3 h-3rem">8:30 </div>
            <div class="col bg-green-300  border-white-alpha-90 border-3 h-3rem">9:00 </div>
            <div class="col bg-yellow-300  border-white-alpha-90 border-3 h-3rem">9:30 </div>
        </div>

        <div class="grid">
            <div class="col bg-green-300  border-white-alpha-90 border-3 h-3rem">10:00 </div>
            <div class="col bg-pink-300 border-white-alpha-90 border-3 h-3rem">10:30 </div>
            <div class="col bg-yellow-300 border-white-alpha-90 border-3 h-3rem">11:00 </div>
            <div class="col bg-pink-300 border-white-alpha-90 border-3 h-3rem">11:30 </div>
        </div>               
        <div class="grid">
            <div class="col bg-green-300 border-white-alpha-90 border-3 h-3rem">12:00 </div>
            <div class="col bg-pink-300 border-white-alpha-90 border-3 h-3rem">12:30 </div>
            <div class="col bg-yellow-300 border-white-alpha-90 border-3 h-3rem">13:00 </div>
            <div class="col bg-pink-300 border-white-alpha-90 border-3 h-3rem">13:30 </div>
        </div>         
        <div class="grid">
            <div class="col bg-surface-400 border-white-alpha-90 border-3 h-3rem"></div>
        </div>  

        <div class="grid">
            <div class="col bg-green-300 border-white-alpha-90 border-3 h-3rem">16:00 </div>
            <div class="col bg-pink-300 border-white-alpha-90 border-3 h-3rem">16:30 </div>
            <div class="col bg-yellow-300 border-white-alpha-90 border-3 h-3rem">17:00 </div>
            <div class="col bg-pink-300 border-white-alpha-90 border-3 h-3rem">17:30 </div>
        </div>    

        <div class="grid">
            <div class="col bg-green-300 border-white-alpha-90 border-3 h-3rem">18:00 </div>
            <div class="col bg-pink-300 border-white-alpha-90 border-3 h-3rem">18:30 </div>
            <div class="col bg-green-300 border-white-alpha-90 border-3 h-3rem">191:00 </div>
            <div class="col bg-pink-300 border-white-alpha-90 border-3 h-3rem">19:30 </div>
        </div>                       

        <div class="grid mr-3 botonEnviar" >
            <Button label="Hacer Reserva" icon="pi pi-check" class="p-button-lg ml-3 " type="submit" />
        </div>
    <!--                      <template #footer>
            <Button label="No" icon="pi pi-times" @click="CerrarTurno" class="p-button-text"/>
            <Button label="Yes" icon="pi pi-check" @click="CerrarTurno" autofocus />
        </template> -->
    </div>    
</template>

<script>
import {toRef} from 'vue';

export default {
   
    setup(props){

        const displayCargaTurno = toRef(props, 'displayCargaTurno');



        return {displayCargaTurno}
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