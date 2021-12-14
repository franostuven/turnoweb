<template>
    <div class="container mt-3">
      
      <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-indicators">
          <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
          <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
          <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
        </div>
        <div class="carousel-inner">
            <div class="carousel-item active">
              <img src="../assets/img/slider-1.jpg" class="d-block w-100" alt="Gym 1">
                <div class="carousel-caption d-none d-md-block">
                  <h5>Todo el Deporte en un solo lugar</h5>
                  <p>Clases de Golf - Football - Natacion.</p>
                </div>
            </div>
            <div class="carousel-item">
              <img src="../assets/img/slider-2.jpg" class="d-block w-100" alt="Gym 2">
                <div class="carousel-caption d-none d-md-block">
                  <h5>Todo el Deporte en un solo lugar</h5>
                  <p>Paddle - Tenis - Paleta - Gimnasio</p>
                </div>              
            </div>
            <div class="carousel-item">
              <img src="../assets/img/slider-1.jpg" class="d-block w-100" alt="Gym 3">
                <div class="carousel-caption d-none d-md-block">
                  <h5>Todo el Deporte en un solo lugar</h5>
                  <p>Juegos para chicos, todo al aire libre</p>
                </div>              
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Next</span>
        </button>
      </div>
    
    </div>
</template>


