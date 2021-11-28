<template>
    <div class="card">
        <Button class="p-button-md" label="Menu"  icon="pi pi-arrow-right" @click="visibleLeft = true" /> 
        <Sidebar v-model:visible="visibleLeft" style="background-color:green: font-size: 24pt">
           
            <h2 class="p-text-center"><router-link to="/"><i class="pi pi-calendar-times"></i></router-link></h2>

            <div class="containe"  style="font-size:18pt;">

                <div class="p-m-1 p-p-1 estriboMenu">
                    <router-link to="/Registros" >Registros</router-link>
                </div>
                <hr>
                <div class="p-m-1 p-p-1 estriboMenu">
                    <router-link to="/Sura">Sura</router-link>
                </div>
                <hr>
                <div class="p-m-1 p-p-1 estriboMenu">
                     <router-link to="/Gestores">Gestores</router-link>
                </div>
                <hr>
                <div class="p-m-1 p-p-1 estriboMenu">
                     <router-link to="/Formularios">Formularios</router-link>
                </div>
                <hr>
                <div class="p-m-1 p-p-1 estriboMenu">
                     <router-link to="/Sellados">Sellados</router-link>
                </div>
                <hr>
            </div>
       
        
            
        </Sidebar>

    </div>
</template>

<script>
export default {
setup (){
    const visible = false;

    console.log(visible)
    return{visible}
}
}
</script>
