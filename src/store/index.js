import { createStore } from 'vuex'

export default createStore({
  state: {
    fecha_Turno : null,
    hora_Turno : null
  },
  mutations: {
    setFechaTurno(state, payload){
      state.fecha_Turno = payload;
    },
    setHoraTurno(state, payload){
      state.hora_Turno = payload;
    }
  },
  actions: {
    obtenerFecha({ commit }, f_turno){

       const fecha = Date(f_turno); 
       
       commit('setFechaTurno', fecha);
     },
    obtenerHora({ commit },horaTurno){

       const hora = horaTurno.getHours();
       commit('setHoraTurno', hora);
  /*     m_turno.value = fecha_turno.getMonth();
      y_turno.value = fecha_turno.getFullYear();
      fechaturno = new Date(`${f_turno.value}/${m_turno.value}/${y_turno.value}`);  
 */
    }
  },
  modules: {
  }
})
