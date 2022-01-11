<template>
  <Toast />
  <div class="container surface-200">
    <h1>Administracion de Fechas de Cierre</h1>

    <div class="mt-3">
        <Accordion>
            <AccordionTab>
                <template #header>
                    <span class="ml-2">Feriados o Fechas de Cierre</span>
                </template>
                    <div class="container">
                        <div class="row mt-3">
                            <div class="col-md-4">
                                <span class="p-float-label ">
                                    <Calendar id="basic" v-model="fechaNueva" autocomplete="off" date-format="dd-mm-yy" :disabledDays="disabledDay" :disabled="disbledTable"/>
                                    <label for="basic">Seleccione Fecha </label>
                                </span>
                            </div>
                            <div class="col-md-4 offset-md-4">
                                <span class="p-float-label ">
                                    <InputText id="descripcion" type="text" v-model.trim="descripcionFecha" />
                                    <label for="descripcion">Descripción</label>
                                </span>
                            </div>
                        </div>
                    </div>
                        <Button label="Aceptar" class="p-button-secondary mt-3" @click="altaFecha" :disabled="!fechaNueva || !selecDeporte" /> 
            </AccordionTab>
        </Accordion>

        <Toolbar class="p-mb-4"> 
            <template #start > 
                <!-- <Button label="New" icon="pi pi-plus" class="p-button-success p-mr-2" @click="openNew" /> -->
                <Button label="Borrar Selección" icon="pi pi-trash" class="p-button-danger mr-5" @click="confirmarBorrarSeleccionados" :disabled="!selectedFeriado || !selectedFeriado.length" />
            </template> 

            <template #end> 
                    <!--  <h5>Seleccione una Opción</h5> -->
                <Dropdown  class="w-full inputfield ml-5" id='idDeporte' v-model="selecDeporte" :options="deportes" :style="{width: '150px'}"
                            optionLabel="descripcion" optionValue="id_deporte" @hide="cambioDeporte" placeholder="Seleccione una actividad" />   <!--:tabindex="dropIndex"  -->

            </template> 
        </Toolbar>

        <DataTable ref="dt" :value="planiFeriados" v-model:selection="selectedFeriado" dataKey="id_fecha" :paginator="true" 
            :rows="10" :filters="filters"  :rowsPerPageOptions="[5,10,25]" :disabled="disbledTable"
            paginatorTemplate="FirstPageLink PrevPageLink PageLinks NextPageLink LastPageLink CurrentPageReport RowsPerPageDropdown" 
            
            currentPageReportTemplate="Mostrando {first} a {last} de {totalRecords} Fechas" responsiveLayout="scroll">

            <template #header>
                <div class="table-header p-d-flex p-flex-column p-flex-md-row p-jc-md-between">
                  <h5 class="p-mb-2 p-m-md-0 p-as-md-center">Administrador de Fechas de Cierre</h5>
                  <span class="p-input-icon-left">
                        <i class="pi pi-search" />
                        <InputText v-model="filters['global'].value" placeholder="Buscar..." />
                  </span>
                </div>
            </template>

            <Column selectionMode="multiple" style="width: 3rem" :exportable="false"></Column>

            <Column field="f_cierre" header="Fecha de Cierre" :sortable="true" dataType="date" style="min-width:10rem">
                <template #body="slotProps">
                    {{formatDate(slotProps.data.f_cierre)}}
                </template>                
            </Column>

            <Column field="descripcion_fecha" header="Descripción Fecha" :sortable="true" style="min-width:10rem">
                <template #body="slotProps">
                    {{slotProps.data.descripcion_fecha.toUpperCase()}}
                </template>                
            </Column>

             <Column :exportable="false" style="min-width:8rem">
                <template #body="slotProps">
                    <Button icon="pi pi-trash" class="p-button-rounded p-button-warning" @click="confirmBorrarFecha(slotProps.data)" />
                </template>
            </Column>
        </DataTable>

        <Dialog v-model:visible="ventanaBorrarFecha" :style="{width: '500px'}" header="Confirmar" :modal="true" position="right" >
              <div class="confirmation-content">
                  <i class="pi pi-exclamation-triangle p-mr-3" style="font-size: 2rem" />
                  <span class="ml-3" v-if="Fcierre">Esta seguro de que desea eliminar <b> fecha: {{Fcierre.f_cierre}}</b>?</span>
              </div>
              <template #footer>
                  <Button label="No" icon="pi pi-times" class="p-button-text" @click="ventanaBorrarFecha = false"/>
                  <Button label="Si" icon="pi pi-check" class="p-button-text" @click="borrarFecha" />
              </template>
          </Dialog>

          <Dialog v-model:visible="ventanaBorrarFechas" :style="{width: '500px'}" header="Confirmar" :modal="true" position="left">
              <div class="confirmation-content ">
                  <i class="pi pi-exclamation-triangle p-mr-3" style="font-size: 2rem" />
                  <span class="ml-3"  v-if="Fcierre">Esta seguro de que desea eliminar todas las Fechas seleccionadas ?</span>
              </div>
              <template #footer>
                  <Button label="No" icon="pi pi-times" class="p-button-text" @click="ventanaBorrarFechas = false"/>
                  <Button label="Si" icon="pi pi-check" class="p-button-text" @click="borrarFechasSeleccionadas" />
              </template>
          </Dialog>
    </div>

  </div>
</template>

<script>
import { ref, onMounted, inject, computed } from 'vue';
import { FilterMatchMode } from 'primevue/api';
import { useToast } from 'primevue/usetoast';

export default {
    setup() {
        onMounted(() => {
              listarDeportes();
          })

        let selecDeporte = ref();              // usada en el DropDown 
        let planiFeriados = ref();
        let deportes = ref();
        let disbledTable = ref(true);
        const url = inject("url");
        let fechaNueva = ref();
        let descripcionFecha = ref();
        let disabledDay = ref();

        const toast = useToast();
        const dt = ref();
 
        const turnoBorrarDialogo = ref(false);
        const ventanaBorrarFecha = ref(false);
        const ventanaBorrarFechas = ref(false);
        const Fcierre = ref({});
        const selectedFeriado = ref();
        
        const filters = ref({
            'global': {value: null, matchMode: FilterMatchMode.CONTAINS},
        });

        const confirmBorrarFecha = (prod) => {
            Fcierre.value = prod;
            ventanaBorrarFecha.value = true;
        };

        const borrarFecha = () => {
            planiFeriados.value = planiFeriados.value.filter(val => val.id_fecha !== Fcierre.value.id_fecha);
            borrarFechaBase(Fcierre.value.id_fecha);
            ventanaBorrarFecha.value = false;
            Fcierre.value = {};
            toast.add({severity:'success', summary: 'Operación Exitosa', detail: 'Turno Eliminado', life: 3000});
        }

        const exportCSV = () => {
            dt.value.exportCSV();
        };

        const confirmarBorrarSeleccionados = () => {
            ventanaBorrarFechas.value = true;
        };

        const borrarFechasSeleccionadas = () => {
            planiFeriados.value = planiFeriados.value.filter(val => !selectedFeriado.value.includes(val));
            // console.log("que tiene select Turnos",selectedFeriado.value[0].id_fecha)
            // console.log("que tiene select Turnos",selectedFeriado.value[0].mail)
            enviarBorrarFechasSeleccionadas();
            ventanaBorrarFechas.value = false;  
            toast.add({severity:'success', summary: 'Satisfactorio', detail: 'Fechas Eliminadas', life: 3000});
        };

    // *********************************************  MIS RUTUNAS  *********************************************

        const listarDeportes = async () => {              
            await axios.post(url, {opcion:2})
            .then(response=>{
              deportes.value = response.data;
            })
            .catch(function (error) {
              console.log(error);
            });   
        }


        const cambioDeporte =   () => {
            if(selecDeporte.value === '' || selecDeporte.value === undefined){
                disbledTable.value = true ;
                return false
            }else{
                recuperarFechas( selecDeporte.value);
                disbledTable.value = false ;
            }
        }
        
        const borrarFechaBase = async (miId) => {
            await axios.post(url, {opcion:12, id_fecha: miId})
                .then(response =>{
                    const ok = response.data;       
                    
                    console.log('Datos de borrar Fcierre: ',ok)
                })
                .catch(function (error) {
                console.log(error);
                });   
        }

        const enviarBorrarFechasSeleccionadas = () => {
            for (const iterator of selectedFeriado.value) {
              //console.log("en el forOf: ", iterator.id_fecha)
                borrarFechaBase(iterator.id_fecha)
                
            }
        }

        const recuperarFechas = async (deporteSeleccionado) => {
            await axios.post(url, {opcion:3, selecDeporte: deporteSeleccionado})
                .then(response =>{
                    planiFeriados.value = response.data;       
                    
                //      console.log('Datos de planiFeriados en calendar: ',planiFeriados.value)
                })
                .catch(function (error) {
                console.log(error);
                });   

            await axios.post(url, {opcion:5, selecDeporte: deporteSeleccionado })
                .then(response=>{
                const configuraHorarios = response.data;
               
                const  nuevoArray = configuraHorarios[0].dias_sin_atencion;  // viene "0,3,6"  

                disabledDay.value = "[" + nuevoArray +"]";
            
                console.log("dasabled day: ", disabledDay.value)
                })
                .catch(function (error) {
                console.log(error);
                });               
        }

        const formatDate = (dato) => {
            if(dato){
              const d = new Date(dato)

			      	return d.toLocaleDateString();
            }
			    return;
        };


        const altaFecha = async () => {
          if(!fechaNueva.value || !selecDeporte){
            toast.add({severity:'warn', summary: 'Error en Ingreso', detail: 'La fecha no puede estar vacia', life: 3000});
            return false
          }
          await axios.post(url, {opcion:13,  selecDeporte: selecDeporte.value, f_cierre: fechaNueva.value, descripcion: descripcionFecha.value})
            .then(response=>{
              const ok = response.data;
              if(parseInt(ok) > 0){
               planiFeriados.value.push({id_fecha: parseInt(ok), f_cierre: fechaNueva.value, descripcion_fecha: descripcionFecha.value }) 
              }
            })
            .catch(function (error) {
              console.log(error);
            });     
            
            fechaNueva.value = null;
            descripcionFecha.value = null;
        }

        return { dt, turnoBorrarDialogo, ventanaBorrarFecha, ventanaBorrarFechas, Fcierre, selectedFeriado, filters, fechaNueva, disabledDay,
            confirmBorrarFecha, borrarFecha, exportCSV, confirmarBorrarSeleccionados, borrarFechasSeleccionadas, formatDate, altaFecha,
            cambioDeporte, deportes, disbledTable, planiFeriados, selecDeporte,  descripcionFecha}
    }
}

</script>

<style>

</style>