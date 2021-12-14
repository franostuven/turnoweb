<template>
<Toast />
  <div class="container surface-100 card">
      <h1 class="text-center">Preguntas o Consultas</h1>
      <form @submit.prevent="enviarConsulta()">
        <div class="flex justify-content-center flex-wrap card-container yellow-container  p-shadow-23">
            <Card class='flex justify-content-center mt-3' style="width: 60%; margin-bottom: 2em " >

                <template #title>
                    Ingrese sus datos y nos contactamos a la brevedad
                </template>

                <template #content>
                    <div class="p-fluid p-grid">
                        <div class="p-field p-col-12 p-md-4">
                            <span class="p-float-label">
                                <InputText id="nombreUsuario" type="text" v-model.trim="nombre"  />
                                <label for="nombreUsuario">Ingrese su Nombre</label>
                            </span>
                        </div>

                        <div class="p-field p-col-12 p-md-4">
                            <span class="p-float-label">
                                <InputText id="ApellidoUsiario" type="text" v-model.trim="apellido" />
                                <label for="ApellidoUsiario">Ingrese su Apellido</label>
                            </span>
                        </div>

                        <div class="p-field p-col-12 p-md-4">
                            <span class="p-float-label">
                                <InputText id="email1" type="mail" v-model.trim="mail1" />
                                <label for="email1">Ingrese su mail</label>
                            </span>
                        </div>

                        <div class="p-field p-col-12 p-md-4">
                            <span class="p-float-label">
                                <InputText id="email12" type="mail" v-model.trim="mail2" />
                                <label for="email12">Reingrese su email</label>
                            </span>
                        </div>           

                        <div class="p-field p-col-12 p-md-4">
                            <span class="p-float-label">
                                <Textarea id='mensaje' v-model.trim="mensajeUsuario" rows="5" cols="70" />
                                <label for="mensaje">Ingrese su Mensaje</label>
                            </span>
                        </div>                                    
                    </div>
                </template>

                <template #footer>
                    <Button icon="pi pi-check" label="Enviar"  type="submit" />
                    <Button icon="pi pi-times" label="Cancelar" class="p-button-secondary" 
                                  @click="cancelaConsulta" style="margin-left: .5em" />
                </template>
            </Card>
        </div>
      </form>
    </div>

</template>

<script>
import {ref,inject, computed} from 'vue';
import { useRouter } from "vue-router";
import { useToast } from 'primevue/usetoast';

export default {
  setup(){

    const router = useRouter();
    const toast = useToast();
    const url = inject("url");

    let ok = ref('');

    let nombre = ref('');
    let apellido = ref('');
    let mail1 = ref('');
    let mail2 = ref('');
    let mensajeUsuario = ref('');
    const valEmail = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;


    //const upcaseInput  = computed(() => nombre.toUpperCase());

    const enviarConsulta = async () => {
        if(!validoCampos()){
            return
        }

        await axios.post(url, {opcion: 6, nombre: nombre.value, apellido: apellido.value, mail:mail1.value, mensaje:mensajeUsuario.value})
            .then( respuesta=>{
                ok.value = respuesta.data;
                console.log("el php devuelve", ok.value)
            })
            .catch(function (error) {
                console.log(error);
            });   

 
        toast.add({severity:'success', summary: 'Datos Completos', detail: 'Los datos se han enviado con exito'});
        setTimeout(function(){
            router.push("/");

         },3000);       
    }

    const validoCampos = () => {
        if(nombre.value === ''){
            toast.add({severity: 'warn', summary: 'warn', detail: 'El Nombre no puede estar vacio', life: 3000});
            return false
        }

        if(apellido.value === ''){
           toast.add({severity:'warn', summary: 'warn', detail: 'El Apellido no puede estar vacio', life: 3000});
            return false
        }

        if(! valEmail.test(mail1.value)){
            console.log("mal de validacion ",mail1.value)
           toast.add({severity:'warn', summary: 'warn', detail: 'El mail es inválido', life: 3000});
            return false
        }

        if( mail1.value === '' || mail1.value !== mail2.value){
           toast.add({severity:'warn', summary: 'warn', detail: 'El mail es distinto que la verificacion', life: 3000});
            return false
        }

        return true
    }

    const cancelaConsulta = () => {
        router.push("/");
    }

    return{ nombre, apellido, mail1, mail2, mensajeUsuario,
            enviarConsulta, cancelaConsulta}
  }
}
</script>

<style>

</style>;
