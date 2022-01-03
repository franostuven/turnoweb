<template>

    <div class="container ">
        <Toast />
        <div class="card">
                 
            <Toolbar class="p-mb-4"> 
                <template #start > 
                    <!-- <Button label="New" icon="pi pi-plus" class="p-button-success p-mr-2" @click="openNew" /> -->
                    <Button label="Borrar Selección" icon="pi pi-trash" class="p-button-danger mr-5" @click="confirmarBorrarSeleccionados" :disabled="!selectedTurnos || !selectedTurnos.length" />
                 </template> 

                 <template #end> 
                        <!--  <h5>Seleccione una Opción</h5> -->
                    <Dropdown  class="w-full inputfield ml-5" id='idDeporte' v-model="selecDeporte" :options="deportes" :style="{width: '150px'}"
                               optionLabel="descripcion" optionValue="id_deporte" @hide="cambioDeporte" placeholder="Seleccione una actividad" />   <!--:tabindex="dropIndex"  -->
 
                 </template> 

            </Toolbar>


            <DataTable ref="dt" :value="PlaniTurnos" v-model:selection="selectedTurnos" dataKey="id_turno" :disabled="disbledTable"
                :paginator="true" :rows="10" :filters="filters"
                paginatorTemplate="FirstPageLink PrevPageLink PageLinks NextPageLink LastPageLink CurrentPageReport RowsPerPageDropdown" :rowsPerPageOptions="[5,10,25]"
                currentPageReportTemplate="Mostrando {first} a {last} de {totalRecords} Turnos" responsiveLayout="scroll">

                <template #header>
                    <div class="table-header p-d-flex p-flex-column p-flex-md-row p-jc-md-between">
                      <h5 class="p-mb-2 p-m-md-0 p-as-md-center">Administrador de Turnos</h5>
                      <span class="p-input-icon-left">
                            <i class="pi pi-search" />
                            <InputText v-model="filters['global'].value" placeholder="Buscar..." />
                      </span>
                    </div>
                </template>
  
                <Column selectionMode="multiple" style="width: 3rem" :exportable="false"></Column>
                <Column field="f_turno" header="Fecha de Turno" :sortable="true" style="min-width:10rem">
                   <template #body="slotProps">
                        {{formatDate(slotProps.data.f_turno)}}
                    </template>                
                </Column>

                <Column field="mail" header="Mail" :sortable="true" style="min-width:12rem"></Column>
                <Column field="nombre" header="Nombre" :sortable="true" style="min-width:16rem"></Column>

                <Column field="telefono" header="Telefono" style="min-width:8rem"></Column>
                <Column field="cancelado" header="Cancelado" :sortable="true" style="min-width:12rem">
                    <template #body="slotProps">
                       <span>{{estadoDelTurno(slotProps.data.cancelado)}}</span>
                    </template>
                </Column>

               <Column :exportable="false" style="min-width:8rem">
                    <template #body="slotProps">
                        <Button icon="pi pi-trash" class="p-button-rounded p-button-warning" @click="confirmBorrarTurno(slotProps.data)" />
                    </template>
                </Column>
            </DataTable>
        </div>

        <Dialog v-model:visible="ventanaBorrarTurno" :style="{width: '500px'}" header="Confirmar" :modal="true" position="right" >
            <div class="confirmation-content">
                <i class="pi pi-exclamation-triangle p-mr-3" style="font-size: 2rem" />
                <span class="ml-3" v-if="turno">Esta seguro de que desea eliminar este turno de ? <b>{{turno.nombre}}  fecha: {{turno.f_turno}}</b>?</span>
            </div>
            <template #footer>
                <Button label="No" icon="pi pi-times" class="p-button-text" @click="ventanaBorrarTurno = false"/>
                <Button label="Si" icon="pi pi-check" class="p-button-text" @click="borrarTurno" />
            </template>
        </Dialog>

        <Dialog v-model:visible="ventanaBorrarTurnos" :style="{width: '500px'}" header="Confirmar" :modal="true" position="left">
            <div class="confirmation-content ">
                <i class="pi pi-exclamation-triangle p-mr-3" style="font-size: 2rem" />
                <span v-if="turno">Esta seguro de que desea eliminar todos los turnos seleccionados ?</span>
            </div>
            <template #footer>
                <Button label="No" icon="pi pi-times" class="p-button-text" @click="ventanaBorrarTurnos = false"/>
                <Button label="Si" icon="pi pi-check" class="p-button-text" @click="borrarTurnosSeleccionados" />
            </template>
        </Dialog>
	</div>
</template>

<script>
import { ref, onMounted, inject } from 'vue';
import { FilterMatchMode } from 'primevue/api';
import { useToast } from 'primevue/usetoast';

export default {
    setup() {
        onMounted(() => {
              listarDeportes();
          })

        let selecDeporte = ref();              // usada en el DropDown 
        let PlaniTurnos = ref();
        let deportes = ref();
        let disbledTable = ref(true);
        const url = inject("url");


        const toast = useToast();
        const dt = ref();
 
        const turnoBorrarDialogo = ref(false);
        const ventanaBorrarTurno = ref(false);
        const ventanaBorrarTurnos = ref(false);
        const turno = ref({});
        const selectedTurnos = ref();
        
        const filters = ref({
            'global': {value: null, matchMode: FilterMatchMode.CONTAINS},
        });

        const confirmBorrarTurno = (prod) => {
            turno.value = prod;
            ventanaBorrarTurno.value = true;
        };

        const borrarTurno = () => {
            PlaniTurnos.value = PlaniTurnos.value.filter(val => val.id_turno !== turno.value.id_turno);
            borrarTurnoBase(turno.value.id_turno);
            ventanaBorrarTurno.value = false;
            turno.value = {};
            toast.add({severity:'success', summary: 'Operación Exitosa', detail: 'Turno Eliminado', life: 3000});
        }

        const exportCSV = () => {
            dt.value.exportCSV();
        };

        const confirmarBorrarSeleccionados = () => {
            ventanaBorrarTurnos.value = true;
        };

        const borrarTurnosSeleccionados = () => {
            PlaniTurnos.value = PlaniTurnos.value.filter(val => !selectedTurnos.value.includes(val));
            // console.log("que tiene select Turnos",selectedTurnos.value[0].id_turno)
            // console.log("que tiene select Turnos",selectedTurnos.value[0].mail)
            enviarBorrarTurnosSeleccionados();
            ventanaBorrarTurnos.value = false;  
            toast.add({severity:'success', summary: 'Satisfactorio', detail: 'Turnos Eliminados', life: 3000});
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
                recuperarTurnos( selecDeporte.value);
                disbledTable.value = false ;
            }
        }
        
        const borrarTurnoBase = async (miTurno) => {
            await axios.post(url, {opcion:11, id_turno: miTurno})
                .then(response =>{
                    const ok = response.data;       
                    
                    console.log('Datos de borrar turno: ',ok)
                })
                .catch(function (error) {
                console.log(error);
                });   
        }

        const enviarBorrarTurnosSeleccionados = () => {
            for (const iterator of selectedTurnos.value) {
              //console.log("en el forOf: ", iterator.id_turno)
                borroTurnoBase(iterator.id_turno)
                
            }
        }
        
        const borroTurnoBase = async (turnoAborrar) => {
            await axios.post(url, {opcion:11, id_turno: turnoAborrar})
                .then(response =>{
                    const ok = response.data;       
                    console.log("respuesta del delete en grupo: ",ok)
                    
                //      console.log('Datos de PlaniTurnos en calendar: ',PlaniTurnos.value)
                })
                .catch(function (error) {
                console.log(error);
                });                  
        }


        const recuperarTurnos = async (deporteSeleccionado) => {
          await axios.post(url, {opcion:10, selecDeporte: deporteSeleccionado})
            .then(response =>{
                PlaniTurnos.value = response.data;       
                
            //      console.log('Datos de PlaniTurnos en calendar: ',PlaniTurnos.value)
            })
            .catch(function (error) {
              console.log(error);
            });   
        }


        const formatDate = (dato) => {
            if(dato){
              const d = new Date(dato)

			      	return d.toLocaleDateString() + ' - ' + d.toLocaleTimeString();;
            }
			    return;
        };

        const estadoDelTurno = (dato) => {
          if(parseInt(dato) == 1){
            return "CANCELADO"
          }else{
            return "ACTIVO"
          }

        };

        return { dt, turnoBorrarDialogo, ventanaBorrarTurno, ventanaBorrarTurnos, turno, selectedTurnos, filters, 
            confirmBorrarTurno, borrarTurno, exportCSV, confirmarBorrarSeleccionados, borrarTurnosSeleccionados,
            cambioDeporte, deportes, disbledTable, PlaniTurnos, selecDeporte, formatDate, estadoDelTurno}
    }
}

</script>

<style lang="css" scoped>
  .table-header {
      display: flex;
      align-items: center;
      justify-content: space-between;

      @media screen and (max-width: 960px) {
          align-items: start;
    }
  }


  .p-dialog .turno-image {
      width: 50px;
      margin: 0 auto 2rem auto;
      display: block;
  }

  .confirmation-content {
      display: flex;
      align-items: center;
      justify-content: center;
  }

</style>