<?php
    class Conexion{
        public static function Conectar(){
            //define('servidor', '192.168.0.58'); // produccion 192.168.0.58
            define('servidor', 'localhost'); // desarrollo
            define('nombre_bd', 'turnos-web'); 
            define('usuario', 'root');  //desarrollo
            define('password', '');	//desarrollo
            //define('usuario', 'usuarioestribo');  // produccion
            //define('password', 'v9Nsn1EJwIK3');	  // produccion

            $opciones = array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8');			
            try{
                $conexion = new PDO("mysql:host=".servidor."; dbname=".nombre_bd, usuario, password, $opciones);
                return $conexion;
            }catch (Exception $e){ 
                die("El error de Conexión es: ". $e->getMessage());
            }
        }
    }

    //PARA DESARROLLO LOCAL HAY QUE COMENTAR LA CONEXION QUE DICE PRODUCCION Y DESCOMENTAR LAS QUE DICEN 
    // DESARROLLO.  PARA PRODUCCION ES LO INVERSO.
    // HACER LO MISMO con la variable "let url" EN LOS ARCHIVOS:    ListarPantallas.vue 
    //                                                              ListarTablas.vue
    //                                                              MenuAlterno.vue
    //                                                              Links.vue
    //                                                              Tarjetas.vue   
    //                                                              LOGIN.VUE

    //$link = 'mysql:host=localhost;dbname=gestionregistral_presupuestos;charset=utf8';   // EL HOST ,  EL NOMBRE DE LA DB
    //$usuario = 'gestionregistral_francisco';                                       // USUARIO 
    //$pass ='Marzo1967*';                                               // CLAVE
?>
