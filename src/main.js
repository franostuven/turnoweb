import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import PrimeVue from 'primevue/config';
import Button from 'primevue/button';
import InputText from 'primevue/inputtext';
import Toast from 'primevue/toast';
import ToastService from 'primevue/toastservice';
import Message from 'primevue/message';
import AutoComplete from 'primevue/autocomplete';
import Calendar from 'primevue/calendar';
import InputMask from 'primevue/inputmask';
import InputNumber from 'primevue/inputnumber';
import InputSwitch from 'primevue/inputswitch';
import Password from 'primevue/password';
import SpeedDial from 'primevue/speeddial';
import SplitButton from 'primevue/splitbutton';
import Accordion from 'primevue/accordion';
import AccordionTab from 'primevue/accordiontab';
import Card from 'primevue/card';
import Sidebar from 'primevue/sidebar';
import Menubar from 'primevue/menubar';
import Avatar from 'primevue/avatar';
import Dropdown from 'primevue/dropdown';
import DataTable from 'primevue/datatable';
import Column from 'primevue/column';
import ColumnGroup from 'primevue/columngroup';
import Toolbar from 'primevue/toolbar';
import Dialog from 'primevue/dialog';
import Breadcrumb from 'primevue/breadcrumb';
import Checkbox from 'primevue/checkbox';
import InlineMessage from 'primevue/inlinemessage';
import Textarea from 'primevue/textarea';

import 'primevue/resources/themes/saga-blue/theme.css'       //theme
import 'primevue/resources/primevue.min.css'                 //core css
import 'primeicons/primeicons.css'                           //icons

//flexBox  (con la primera se incluyen todas las de abajo)
import 'primeflex/primeflex.css';
/*
import 'primeflex/src/_variables.scss';
import 'primeflex/src/_grid.scss';
import 'primeflex/src/_formlayout.scss';
import 'primeflex/src/_display.scss';
import 'primeflex/src/_text.scss';
import 'primeflex/src/flexbox/_flexbox.scss';
import 'primeflex/src/_spacing.scss';
import 'primeflex/src/_elevation.scss';
 */


const app = createApp(App);

app.use(store);
app.use(router);
app.use(PrimeVue, {
        ripple: true, 
        inputStyle: 'filled',
        locale: {
            accept: 'Aceptar',
            reject: 'Rechazar',
            dayNames: ["Domingo", "Lunes","Martes", "Miércoles", "Jueves","Viernes","Sábado" ],
            dayNamesShort: ["Dom", "Lun", "Mar", "Mié", "Jue", "Vie", "Sáb"],
            dayNamesMin: ["D", "L", "M", "X", "J", "V", "S"],
            monthNames: [
              "Enero",
              "Febrero",
              "Marzo",
              "Abril",
              "Mayo",
              "Junio",
              "Julio",
              "Agosto",
              "Septiembre",
              "Octubre",
              "Noviembre",
              "Diciembre",
            ],
            monthNamesShort: [
              "Ene",
              "Feb",
              "Mar",
              "Abr",
              "May",
              "Jun",
              "Jul",
              "Ago",
              "Sep",
              "Oct",
              "Nov",
              "Dic",
            ],
            today: "Hoy",
            clear: "Borrar",
            weekHeader: "Sm",
            es: {
               firstDayOfWeek: 1
            },
        }
});
app.use(ToastService);

app.component('Button',Button);
app.component('InputText',InputText);
app.component('Toast',Toast);
app.component('Message',Message);
app.component('AutoComplete',AutoComplete);
app.component('Calendar',Calendar);
app.component('InputMask',InputMask);
app.component('InputNumber',InputNumber);
app.component('InputSwitch',InputSwitch);
app.component('Password',Password);
app.component('SpeedDial',SpeedDial);
app.component('SplitButton',SplitButton);
app.component('Accordion',Accordion);
app.component('AccordionTab',AccordionTab);
app.component('Card',Card);
app.component('Sidebar',Sidebar);
app.component('Menubar',Menubar);
app.component('Avatar',Avatar);
app.component('Dropdown',Dropdown);
app.component('DataTable',DataTable);
app.component('Column',Column);
app.component('ColumnGroup',ColumnGroup);
app.component('Toolbar',Toolbar);
app.component('Dialog',Dialog);
app.component('Breadcrumb',Breadcrumb);
app.component('Checkbox',Checkbox);
app.component('InlineMessage',InlineMessage);
app.component('Textarea',Textarea);

app.mount('#app');



