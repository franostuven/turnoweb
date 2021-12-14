<template>
 <!--  <div id="nav">
    <router-link to="/">Home</router-link> |
    <router-link to="/about">About</router-link>
      <navbar/>
  </div> -->
  <Navbar/>
  <router-view/>
</template>

<script>
// @ is an alias to /src
import Navbar from '@/components/Navbar.vue'
//import { usePrimeVue } from "primevue/config";
import { provide, ref, onMounted, watchEffect } from 'vue';

export default {
  name: 'App',
  components: {
    Navbar
  },
  setup() {

      onMounted(() => {
            cargarLocalStorage();
      })

     let url ="http://localhost/turno-web/src/libreries/crud.php"; // DESARROLLO
     let logueado = ref(false);
     // const url = "crud.php";  // produccion // DESARROLLO

      provide('url', url);
      provide('logueado', logueado);

      const cargarLocalStorage = () => {

          if (localStorage.getItem('turnos')) {
            logueado.value = localStorage.getItem('turnos')
          }
      };
      
     //  watchEffect(() => logueado.value);

/*       onMounted(() => {
            changeToSpanish();
      })

      const changeToSpanish = () => {
          const primevue = usePrimeVue();
          primevue.config.locale.accept = 'Aceptar';
          primevue.config.locale.reject = 'Rechazar';
      } */

  }
}
</script>