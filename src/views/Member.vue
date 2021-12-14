<template>
  <div class="container surface-200 p-3 ">
    <div class="flex  justify-content-center align-content-center">      
        <div class="col-8 col-offset-3">
          <login/>

        </div>
    </div>
  </div>
  
</template>

<script>
import {inject, onMounted, ref} from 'vue';
import Login from '../components/Login.vue';

export default {
  components:{
    Login
  },
  setup(){


  }
     
}
</script>
