<template>
  <div class="container">
    <h1 class="mt-2">
      POLIDEPORTIVO MUNICIPAL
    </h1>

    <hr>

    <h3>
      Cuenta con las siguientes instalaciones:
    </h3> 

    <!-- <div class="card my-5"> -->
          <Accordion>
            <AccordionTab>
                <template #header>
                  <img src="https://img.icons8.com/metro/26/000000/world-cup.png"/>
                  <span class="ml-2">Campo de fútbol :</span>
                </template>

                <h4>Campo de fútbol:</h4>
                <ul>
                  <li>
                    Con una superficie de juego de 6.000 metros cuadrados.
                  </li>
                  <li>
                      Hierba natural
                  </li>
                  <li>
                    Asientos individuales en toda la grada

                  </li>
                  <li>
                    Vestuarios, baños
                  </li>
                </ul>             

            </AccordionTab>

            <AccordionTab>
                <template #header>
                    <img src="https://img.icons8.com/ios-glyphs/30/000000/basketball--v2.png"/>
                    <span class="ml-2">Pista polideportiva :</span>
                    
                </template>
                <ul>
                  <li>Grada con capacidad para casi 400 espectadores sentados</li>
                  <li>Zona de futbol sala</li>
                  <li>Tenis</li>
                  <li>Baloncesto (2 pistas)</li>
                  <li>Balonmano</li>
                </ul>
            </AccordionTab>

            <AccordionTab>
                <template #header>
                    <img src="https://img.icons8.com/metro/26/000000/tennis.png"/>
                    <span class="ml-2">2 Pistas de padel :</span>
                </template>
                <ul>
                  <li>Homologadas</li>
                  <li>Hierba sintética</li>
                  <li>Valla electro soldada</li>
                  <li>Iluminación por leds</li>
                </ul>
            </AccordionTab>      

            <AccordionTab>
                <template #header>
                    <img src="https://img.icons8.com/ios-filled/50/000000/rod-barbells.png"/>
                    <span class="ml-2">Gimnasio :</span>
                </template>
                <p>
                Compuesto por 2 salas, una zona de cardio y otra de musculación.También posee una sala de fitness anexa. Recepción, taquillas y aseo.
                </p>
                <p>
                  <b> Horario apertura</b>
                </p>
                <p>  
                  De 9 a 14 y de 17 a 20:00 h.
                </p>
                <p>
                  De lunes a viernes. 
                </p>

            </AccordionTab>        

            <AccordionTab>
                <template #header>
                    <img src="https://img.icons8.com/material-outlined/24/000000/toilet.png"/>
                    <span class="ml-2">Servicios :</span>
                    
                </template>
                <ul>
                  <li>Vestuarios, servicios y duchas</li>
                  <li>Recepción y conserjería</li>
                  <li>Datos generales</li>
                </ul>
              </AccordionTab>
          </Accordion>
 
    <!-- </div> -->

  </div>
</template>