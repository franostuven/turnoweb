<template>
  <header role="banner">
    <nav class="navbar navbar-expand-md navbar-dark bg-dark">
      <div class="container">
        <router-link class="navbar-brand" href="index.html">Gym Benahabi<span>sss</span></router-link>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample05" aria-controls="navbarsExample05" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarsExample05">
          <ul class="navbar-nav mr-auto pl-lg-5 pl-0">
            <li class="nav-item">
              <router-link class="nav-link" to="/">Inicio</router-link> 

              <!-- <a class="nav-link active" href="index.html">Home</a> -->
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/">Acerca de...</router-link> 
              <!-- <a class="nav-link" href="about.html">About</a> -->
            </li>
            
            <li class="nav-item">
              <router-link class="nav-link" to="/turnos">Turnos</router-link> 
              <!-- <a class="nav-link" href="about.html">About</a> -->
            </li>
        
          
            <li class="nav-item">
              <router-link class="nav-link" to="/news">Turnos</router-link> 
            </li>

            <li class="nav-item">
              <router-link class="nav-link" to="/news">Contactenos</router-link> 
            </li>
          </ul>

          <ul class="navbar-nav ml-auto">
            <li class="nav-item cta-btn">
              <router-link class="nav-link" to="/member">Ingresar</router-link> 
            </li>
          </ul>
          
        </div>
      </div>
    </nav>
  </header>
  <!-- END header -->
  
  <section class="home-slider owl-carousel">
    <div class="slider-item" style="background-image: url('img/slider-1.jpg');">
      
      <div class="container">
        <div class="row slider-text align-items-center justify-content-center">
          <div class="col-md-8 text-center col-sm-12 element-animate">
            <h1>Health is wealth</h1>
            <p class="mb-5">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Commodi unde impedit, necessitatibus, soluta sit quam minima expedita atque corrupti reiciendis.</p>
            <p><a href="#" class="btn btn-white btn-outline-white">Get Started</a> <a href="#" class="btn btn-link btn-white">Download</a></p>
          </div>
        </div>
      </div>

    </div>

    <div class="slider-item" style="background-image: url('img/slider-2.jpg');">
      <div class="container">
        <div class="row slider-text align-items-center justify-content-center">
          <div class="col-md-8 text-center col-sm-12 element-animate">
            <h1>Join Fitnezz Today</h1>
            <p class="mb-5">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Commodi unde impedit, necessitatibus, soluta sit quam minima expedita atque corrupti reiciendis.</p>
            <p><a href="#" class="btn btn-white btn-outline-white">Get Started</a> <a href="#" class="btn btn-link btn-white">Download</a></p>
          </div>
        </div>
      </div>
      
    </div>

  </section>
  <!-- END slider -->

  <footer class="site-footer" role="contentinfo">
    <div class="container">
      <div class="row mb-5">
        <div class="col-md-4 mb-5">
          <h3>Nosotros</h3>
          <p class="mb-5">Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptatibus et dolor blanditiis consequuntur ex voluptates perspiciatis omnis unde minima expedita.</p>
          <ul class="list-unstyled footer-link d-flex footer-social">
            <li><a href="#" class="p-2"><span class="fa fa-twitter"></span></a></li>
            <li><a href="#" class="p-2"><span class="fa fa-facebook"></span></a></li>
            <li><a href="#" class="p-2"><span class="fa fa-linkedin"></span></a></li>
            <li><a href="#" class="p-2"><span class="fa fa-instagram"></span></a></li>
          </ul>

        </div>
        <div class="col-md-5 mb-5">
          <h3>Contactenos</h3>
          <ul class="list-unstyled footer-link">
            <li class="d-block">
              <span class="d-block">Direccion:</span>
              <span class="text-white">Centro deportivo de Benahavis</span></li>
            <li class="d-block"><span class="d-block">Telefono:</span><span class="text-white">+34 999 999 999</span></li>
            <li class="d-block"><span class="d-block">Email:</span><span class="text-white">gym@benahavis.es</span></li>
          </ul>
        </div>
        <div class="col-md-3 mb-5">
          <h3>Quick Links</h3>
          <ul class="list-unstyled footer-link">
            <li><a href="#">Nosotros</a></li>
            <li><a href="#">Terminos de uso</a></li>
            <li><a href="#">Contactenos</a></li>
          </ul>
        </div>
        <div class="col-md-3">
        
        </div>
      </div>
      <div class="row">
        <div class="col-12 text-md-center text-left">
          <p>&copy; <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --> Copyright &copy;
          <script>document.write(new Date().getFullYear());</script> 
          All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by 
          <a href="https://colorlib.com" target="_blank">Colorlib</a>
          <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --> <br> Fsc Soft &copy; - 2021</p>
        </div>
      </div>
    </div>
  </footer>
  <!-- END footer -->

  <!-- loader -->
  <div id="loader" class="show fullscreen">
    <svg class="circular" width="48px" height="48px">
      <circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/>
      <circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#f4b214"/>
    </svg>
  </div>
  <router-view/>
</template>


<script>
  export default {
    name: 'App',
  /* para usar esta metadata y que se inserte en la cabecera html al ejecutarse se debe
      instalar primero :  npm i vue-meta - Luego se importa en el main.js las sig. lineas
        import VueMeta from 'vue-meta';
        app.use(VueMeta) ;
       
       Uso:
       metaInfo: {
        title: 'Horarios Web',
        script: [
          { src: '../src/assets/js/bootstrap.js', body: true },
          { src: '../src/assets/js/moment.js', body: true },

        ]
    }, 
    
    Tambien se puede usar directamente en el main.js de la sig. forma
          app.use(VueMeta, {
            keyName: 'metaInfo',
            attribute: 'data-vue-meta',
            ssrAttribute: 'data-vue-meta-server-rendered',
            tagIDKeyName: 'vmid',
            refreshOnceOnNavigation: true
          })
    */
    setup() {
      
    },
  }
</script>