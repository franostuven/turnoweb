//  NO ESTARIA FUNCIONANDO
// mode de uso en el template 
// <input v-model="myInput" v-input-upper />

export default {
    bind: function (el, _, vnode) {
      // uppercase transform
      console.log("entre inicio de funcion: ", el)

      el.transformUpper = function () {
        const start = el.selectionStart
        el.value = el.value.toUpperCase()
        el.setSelectionRange(start, start)
        vnode.componentInstance.$emit('input', el.value.toUpperCase())
        console.log("entre: ", vnode)
      }
      // add event listener
      el.addEventListener('input', function () {
        el.transformUpper()
      })
    },
    unbind: function (el) {
      el.removeEventListener('input', el.transformUpper)
    }
  }