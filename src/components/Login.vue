
<template>
    <Toast />
    <div class="surface-card p-4 shadow-2 border-round w-full lg:w-8">
        <div class="text-center mb-5">
            <img src="../assets/img/Calendario.png" alt="Image" height="50" class="mb-3">
            <div class="text-900 text-3xl font-medium mb-3">Administrador de Turnos</div>
            <span class="text-600 font-medium line-height-3">No tengo Cuenta ?</span>
            <a class="font-medium no-underline ml-2 text-blue-500 cursor-pointer">Crear cuenta ahora!</a>
        </div>

        <div>
            <label for="email1" class="block text-900 font-medium mb-2">Email</label>
            <InputText id="email1" type="text" class="w-full mb-3" v-model.trim="emailLog"/>

            <label for="password1" class="block text-900 font-medium mb-2">Clave</label>
            <Password  id="password1" type="password"  class="w-full mb-3" v-model.trim="claveLog" />

            <div class="flex align-items-center justify-content-between mb-6">
                <div class="flex align-items-center">
                    <Checkbox id="rememberme1" :binary="true" v-model="chkRecordarme" class="mr-2"></Checkbox>
                    <label for="rememberme1">Recordarme</label>
                </div>
                <router-link to="/recuperoclave" class="font-medium no-underline ml-2 text-blue-500 text-right cursor-pointer">Olvide mi clave?</router-link>
            </div>
            <Button label="Ingresar" icon="pi pi-user" class="w-full" @click='verficaUsuario()'></Button>
        </div>
    </div>
</template>


<script>
    import {ref, inject,computed } from 'vue';
    import { useRouter } from "vue-router";
    import { useToast } from 'primevue/usetoast';

    export default {
        setup() {
            let chkRecordarme = ref(false);
            let claveLog = ref();
            let emailLog = ref();
            let logueado = inject('logueado');
            const valEmail = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            let listaError = ref([]);
            const url = inject("url");

            const router = useRouter();
            const toast = useToast();
            const usuario = ref();

            //const usuario = ref( { email: emailLog.value, clave: claveLog.value});
            // Ver si se pone esta clase  p-invalid  a los campos que estan mal ingresados.

            const validoNombre = computed(() => {
                 return !emailLog.value.trim() ? toast.add({severity:'error', summary: 'Campo Obligatorio', detail: 'El Mail no puede estar Vacio', life: 3000}):''

            });

            let camposInvalidos = ()=> {

                listaError.value = [];
                
                if(!emailLog.value){
                    listaError.value.push('mail')
                }else if(! valEmail.test(emailLog.value)) {
                    listaError.value.push('invalido')
                }

                if(!claveLog.value){
                    listaError.value.push('clave')
                }

                if(listaError.value.length>0){

                    for (let index = 0; index < listaError.value.length; index++) {
                      
                        if(listaError.value[index] === 'mail') {
                            toast.add({severity:'error', summary: 'Campo Obligatorio', detail: 'El Mail no puede estar Vacio', life: 5000});
                        }
                        if(listaError.value[index] === 'invalido') {
                            toast.add({severity:'error', summary: 'Campo Obligatorio', detail: 'El Mail ingresado es Inválido', life: 5000});
                        }
                        if(listaError.value[index] === 'clave') {
                            toast.add({severity:'error', summary: 'Campo Obligatorio', detail: 'La clave no puede estar vacia', life: 5000});
                        }

                    }
                    return true
                }else{
                    return  false    //No encontro errores
                }

            };     // fin funcion campos ivalidos


            const verficaUsuario =  async () => {

                if(camposInvalidos()){
                     return 
                }

                await axios.post(url, {opcion: 1,  mail: emailLog.value })
                    .then( response =>{
                        usuario.value = response.data
                    })
                    .catch(function (error) {
                        console.log(error);
                    })  

                if(!usuario.value.length){
                     emailLog.value = '';
                     claveLog.value = '';
                     
                     toast.add({severity:'warn', summary: 'Acceso denegado', detail: 'Usuario o Clave incorrecta', life: 3000});
                     return  
                }

                if(emailLog.value !== usuario.value[0].mail ){
                    emailLog.value = '';
                    claveLog.value = '';
                     
                     toast.add({severity:'warn', summary: 'Acceso denegado', detail: 'Usuario o Clave incorrecta', life: 3000});
                     return 
                }

                if(claveLog.value !== usuario.value[0].clave ){
                    emailLog.value = '';
                    claveLog.value = '';
                     
                    toast.add({severity:'warn', summary: 'Acceso denegado', detail: 'Usuario o Clave incorrecta', life: 3000});
                    return 
                }

                        
                toast.add({severity:'success', summary: 'Bienvenido', detail: 'Acceso Concedido', life: 3000});
                logueado.value = true;

      
                localStorage.setItem('turnos', logueado.value);
       
                setTimeout(function(){
                    router.push("/");

                },2000);       

            }


            return{chkRecordarme, claveLog, emailLog, usuario, logueado,
                    verficaUsuario}
        },
    }
</script>

