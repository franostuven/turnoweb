<template>
    <Toast />
    <div>
        <div class="container justify-container-center surface-100 p-1 mt-3">
            <h1 class="ml-2">Administrador de usuarios</h1>
          
            <div class="p-fluid p-grid">
                <div class="p-field p-col-12 p-md-4 p-mb-3">
                    <span class="p-float-label p-input-icon-left">
                      <i class="pi pi-envelope" />
                      <InputText id="email1" type="text" class="w-full mb-3" v-model.trim="mail" @blur="buscoMail"  :class="error"/>
                      <label for="email1" class="block text-900 font-medium mb-2">Ingrese Email del Nuevo Usuario</label>
                    </span>
                    <small style="color:red">{{mensaje}}</small>  
                </div>
                <div class="p-field p-col-12 p-md-4 p-mb-3">
                    <span class="p-float-label p-input-icon-left">
                        <i class="pi pi-lock" />
                        <InputText id="clave" type="text" class="w-full mb-3" @focus="ponerClave" v-model.trim="clave" />
                        <label for="clave">Ingrese una clave o siga y queda la por defecto</label>
                    </span>
                </div>
                <div class="p-field p-col-12 p-md-4 p-mb-3">
                    <span class="p-float-label p-input-icon-left">
                        <i class="pi pi-user-plus" />
                        <InputText id="inputtext-left" type="text" class="w-full mb-3"  v-model.trim="nombre" />
                        <label for="inputtext-left">Ingrese el Nombre del Usuario</label>
                    </span>
                </div>
                <div class="p-field p-col-12 p-md-4 p-mb-3">
                    <span class="p-float-label p-input-icon-left">
                        <i class="pi pi-map-marker" />
                        <InputText id="domicilio" type="text" class="w-full mb-3" v-model.trim="domicilio" />
                        <label for="domicilio">Ingrese el Domicilio</label>
                    </span>
                </div>
                <div class="p-field p-col-12 p-md-4 p-mb-3">
                    <span class="p-float-label p-input-icon-left">
                        <Calendar id="nacimiento" v-model="f_nacimiento" class="w-full mb-3"  :showIcon="true"  dateFormat="dd-mm-yy"/>
                        <label for="nacimiento">Seleccione la fecha de Nacimiento</label>
                    </span>
                </div>
                <div class="p-field p-col-12 p-md-4 p-mb-3">
                    <span class="p-float-label p-input-icon-left">
                        <i class="pi pi-phone" />
                        <InputText id="telefono" type="text" class="w-full mb-3" v-model.trim="telefono" />
                        <label for="telefono">Ingrese el Telefono</label>
                    </span>
                </div>     
                <div class="p-formgroup-inline">
                    <div class="p-field-checkbox p-md-4">
                        <span class="p-float-label p-input-icon-left">
                            <Checkbox  id="bloqueado" type="text" v-model="bloqueado" :binary="true" />
                            <label for="bloqueado">Bloquear Usuario</label>
                        </span>
                    </div>                                                                           
                    <div class="p-field">
                        <span class="ml-3">
                          <b style="color: red">{{bloqueado?"BLOQUEADO":''}}</b>
                          </span>
                    </div>
                </div>  
            </div>
            <div class="flex justify-content-center mb-3">
              <Button label="Dar de Alta" @click="altaUsuario()" :disabled="botonAceptar"  class="p-button-lg p-button-rounded mr-3"/>
              <Button label="Cancelar" @click="salirSinGrabar()" class="p-button-lg p-button-rounded " />
            </div>
       </div>
    </div>

</template>

<script>
  import {inject, computed, ref} from 'vue';
  import { useRouter } from "vue-router";
  import { useToast } from 'primevue/usetoast';

  export default {
  
    setup(){
      
      const url = inject("url");
      const router = useRouter();
      const toast = useToast();

      let mail = ref();
      let clave = ref();
      let nombre = ref();
      let domicilio = ref();
      let f_nacimiento = ref();
      let telefono =  ref();
      let bloqueado = ref(false);
      let botonAceptar = ref(true);
      let mensaje = ref('')

      const valEmail = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

      const ponerClave = () => {
        if(!clave.value){
          clave.value = 1234
        }
        return
      }

      const buscoMail = async (e) => {
         if(!valEmail.test(e.target.value)) {
           toast.add({severity:'error', summary: 'Campo Obligatorio', detail: 'El Mail No puede estar vacio y debe ser válido', life: 5000});
           mensaje.value = "El mail es Inválido, ingrese un mail válido para continuar"
           botonAceptar.value = true;
           return false
         }

          let verif_mail = '';

          await axios.post( url, {opcion: 0, mail: e.target.value})
                .then( response =>{
                  verif_mail = response.data ;  
                })
                .catch(function (error) {
                  console.log(error);
                });   

          if(verif_mail.length > 0){
            console.log("entre al if del length", verif_mail[0].mail )
            mensaje.value = "El mail ingresado ya existe en la base de datos NO SE PUEDE DAR DE ALTA 2 VECES."    
            toast.add({severity:'error', summary: 'ERROR USUARIO', detail: 'El Usuario ingresado '+ verif_mail[0].mail +' YA esta Registrado', life: 5000});
            botonAceptar.value = true
            return false
          }else{
            mensaje.value ="";
            botonAceptar.value = false;
            return
          }           
      }

      const error = computed(() => {
          return !mail.value ? "p-invalid" : ''

      });

      const salirSinGrabar = () => {
          router.push("/");
      }

      const altaUsuario = async () => {

           await axios.post(url, {opcion: 9,  mail: mail.value,  clave: clave.value, nombre: nombre.value, domicilio: domicilio.value,
                                  f_nacimiento: f_nacimiento.value, telefono: telefono.value, bloqueado: bloqueado.value})
                .then( response =>{
                  const  ok = response.data
                  console.log(ok)
                })
                .catch(function (error) {
                    console.log(error);
                })  

                        
          toast.add({severity:'success', summary: 'Alta correcta', detail: 'Se dio de alta correctamente', life: 3000});
 
          setTimeout(function(){
              router.push("/");
          },2000);       

      }

      return{ mail, clave , nombre, domicilio, f_nacimiento, telefono, bloqueado, error, botonAceptar, mensaje,
              salirSinGrabar, altaUsuario, ponerClave, buscoMail }
    }
  }
</script>

