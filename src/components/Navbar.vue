 <template>
 <!-- <header role="banner"> -->
    <nav class="navbar navbar-expand-md navbar-dark bg-dark mb-2" >
      <div class="container-fluid">
        <img alt="Gym" src="../assets/img/Calendario.png">
        <router-link class="navbar-brand" to="/">Gym Benahavi<span>s</span></router-link>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsExample05" aria-controls="navbarsExample05" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarsExample05">
          <ul class="navbar-nav me-auto mb-2 mb-lg-0 mt-2">
            <li class="nav-item">
              <router-link class="nav-link" to="/">Inicio</router-link> 

              <!-- <a class="nav-link active" href="index.html">Home</a> -->
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/about">Nosotros</router-link> 
              <!-- <a class="nav-link" href="about.html">About</a> -->
            </li>
            
            <li class="nav-item">
              <router-link class="nav-link" to="/turnos">Turnos</router-link> 
              <!-- <a class="nav-link" href="about.html">About</a> -->
            </li>

            <li class="nav-item">
              <router-link class="nav-link" to="/contacto">Contactenos</router-link> 
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/news">Novedades</router-link> 
            </li>

            <li class="nav-item dropdown" v-if="logueado">
              <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" 
                 data-bs-toggle="dropdown" aria-expanded="false">
                Administrador
              </a>
              <!-- <router-link class="nav-link" to="/usuarios">Alta Usuarios</router-link>  -->
              <ul class="dropdown-menu " aria-labelledby="navbarDropdown">
                <li><router-link class="dropdown-item" to="/usuarios">Administrar Usuarios</router-link></li>
                <li><router-link class="dropdown-item" to="/adminturnos">Administrar Turnos</router-link></li>
                <li><hr class="dropdown-divider"></li>
                <li><router-link class="dropdown-item" to="/adminfechas">Fechas de Cierre</router-link></li>
                <li><router-link class="dropdown-item" to="/configuracion">Configuración</router-link></li>
              </ul>
            </li>
          </ul>

          <ul class="navbar-nav ml-auto">
            <li class="nav-item cta-btn">
              <router-link class="btn btn-warning" to="/member" v-if="!logueado"><i class="pi pi-user-plus mr-2"></i>Ingresar</router-link> 

              <Button label="Cerrar Session" icon="pi pi-power-off" v-if="logueado" 
                        class="p-button-raised p-button-rounded p-button-success" 
                        @click="cerrarSesion"/>             

            </li>
          </ul>
 
          
        </div>
      </div>
    </nav>
  <!-- </header> -->
  <!-- END header -->
</template>

<script>
  import {inject} from 'vue';
  import {useRouter} from 'vue-router';

  export default {
    setup (){

        const logueado = inject('logueado');
        const router = useRouter();

        const cerrarSesion = () => {
          logueado.value = false;
          localStorage.removeItem('turnos')
          router.push('/')
        }

        return{logueado, cerrarSesion}
    }
  }
</script>



