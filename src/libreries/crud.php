<?php
    cors();

 //  header('Access-Control-Allow-Origin: *');

include_once 'conexion.php';
$objeto = new Conexion();
$conexion = $objeto->Conectar();
//echo 'ENTRE AL CRUD';

$_POST = json_decode(file_get_contents("php://input"), true);
$opcion = (isset($_POST['opcion'])) ? $_POST['opcion'] : '';


$horaTurno = date('Y-m-d', strtotime((isset($_POST['fechaTurno'])) ? $_POST['fechaTurno'] : ''));
$id_usuario = (isset($_POST['id_usuario'])) ? $_POST['id_usuario'] : '';                             
$selecDeporte = (isset($_POST['selecDeporte'])) ? $_POST['selecDeporte'] : '';

$hoy =  date("Y-m-d") . " 00:00:00"; 

$nombre = (isset($_POST['nombre'])) ? $_POST['nombre'] : '';
$apellido = (isset($_POST['apellido'])) ? $_POST['apellido'] : '';
$mail = (isset($_POST['mail'])) ? $_POST['mail'] : '';
$mensaje = (isset($_POST['mensaje'])) ? $_POST['mensaje'] : '';

//$fturno = (isset($_POST['fturno'])) ? $_POST['fturno'] : '';   da una hora menos y repite la hora
$fturno = date('Y-m-d H:i:s', strtotime((isset($_POST['fturno'])) ? $_POST['fturno'] : ''));

$bloqueado = (isset($_POST['bloqueado'])) ? $_POST['bloqueado'] : '';
$clave = (isset($_POST['clave'])) ? $_POST['clave'] : '';
$domicilio = (isset($_POST['domicilio'])) ? $_POST['domicilio'] : '';
$telefono = (isset($_POST['telefono'])) ? $_POST['telefono'] : '';
$f_nacimiento = date('Y-m-d H:i:s', strtotime((isset($_POST['f_nacimiento'])) ? $_POST['f_nacimiento'] : ''));

$id_turno = (isset($_POST['id_turno'])) ? $_POST['id_turno'] : '';


// $path1 = (isset($_POST['path1'])) ? $_POST['path1'] : '';
// $orden = (isset($_POST['orden'])) ? $_POST['orden'] : '';
// $borrado = (isset($_POST['borrado'])) ? $_POST['borrado'] : '';
// $imagen_path = (isset($_POST['imagen_path'])) ? $_POST['imagen_path'] : '';
// $footer = (isset($_POST['footer'])) ? $_POST['footer'] : ''; 
// $marca = (isset($_POST['marca'])) ? $_POST['marca'] : '';
// $modelo = (isset($_POST['modelo'])) ? $_POST['modelo'] : '';
// $stock = (isset($_POST['stock'])) ? $_POST['stock'] : '';

switch($opcion){
    case 0:
       // DEVUELVE EL MAIL DEL USUARIO PARA TURNOS  (Llamado desde  TURNOS.VUE)

        $consulta = "SELECT id_cliente, mail, clave FROM clientes WHERE mail = ?";	
        $resultado = $conexion->prepare($consulta);
        $resultado->execute(array($mail));                        
        $data=$resultado->fetchAll(PDO::FETCH_ASSOC);
        break;     

    case 1:    //turno
        // OBTIENE EL ACCESO DE LOS USUARIOS Y PERMISOS  (Llamado desde el Login.vue)
        //  CAMBIE TABLA USUARIOS por USUARIO ya que tuve que meterla en ESTRIBO.
        $consulta = "SELECT mail, clave FROM usuarios WHERE mail = ?";	
        $resultado = $conexion->prepare($consulta);
        $resultado->execute(array($mail));                        
        $data=$resultado->fetchAll(PDO::FETCH_ASSOC);
        break;     
        
    case 2:    //turno
        // ENVIA LA LISTA DE DEPORTES O ACTIVIDADES QUE NO ESTAN DESACTIVADOS (LLAMADO DESDE Turnos.vue)
        $consulta = "SELECT id_deporte, descripcion, anticipacion, usuarios_por_turno FROM deporte WHERE desactivado = ?";		
        $resultado = $conexion->prepare($consulta);
        $resultado->execute(array(0));                        
        $data=$resultado->fetchAll(PDO::FETCH_ASSOC);
        break;     

    case 3:   //turno
        // Extrae los dias feriados, festivos o cerrados del deporte enviado. (TURNOS.VUE)
        $consulta = "SELECT f_cierre FROM feriados_cerrado WHERE id_deporte = ?";		
        $resultado = $conexion->prepare($consulta);
        $resultado->execute(array($selecDeporte));    
        $data=$resultado->fetchAll();                       
        break;         

    case 4:   //turno
        //  Extrae la lista de fechas y horas de los TURNOS segun la Disciplina (Deporte)
      //  $consulta = "DELETE FROM links WHERE id_link=? ";		
        $consulta = "SELECT id_turno, id_deporte, id_usuario, f_turno, cancelado FROM turnos WHERE  id_deporte = ? AND f_turno >= ?";
        $resultado = $conexion->prepare($consulta);
        $resultado->execute(array($selecDeporte, $hoy ));  
        $data=$resultado->fetchAll(PDO::FETCH_ASSOC);             
        break;         
 
    case 5:     //turno
        // Extrae los horarios del deporte seleccionado, hora y dias de apertura  y cierre de la entidad
        // saca los links de los menues (PANTALLA)
        $consulta = "SELECT d_desde, d_hasta, d_hora, h_hora, intervalo FROM horarios WHERE id_deporte = ?" ;
        $resultado = $conexion->prepare($consulta);
        $resultado->execute(array($selecDeporte));                        
        $data=$resultado->fetchAll(PDO::FETCH_ASSOC);
        break;

    case 6:
        // Envia los datos de una consulta o pregunta para ser leida (CONTACTO.VUE)
        $consulta = "INSERT INTO consultas (  nombre, apellido, mail, mensaje, fecha) VALUES (?, ?, ?, ?, ?) ";	
        $resultado = $conexion->prepare($consulta);
        $resultado->execute(array($nombre,  $apellido, $mail, $mensaje, $hoy));     
        break;

    case 7:
        // EXTRAE SOLO HORAS DE LOS TURNOS DE UN DEPORTE Y FECHA DETERMINADA
        $consulta = "SELECT  id_usuario, f_turno  FROM turnos WHERE  id_deporte = ? AND f_turno = ?";
        $resultado = $conexion->prepare($consulta);
        $resultado->execute(array($selecDeporte, $fturno));                                    
        $data=$resultado->fetchAll(PDO::FETCH_ASSOC);
        break;        

    case 8:
        // INSERTA EL TURNO SOLICIATDO POR EL USUARIO  (turnos.vue)
        $consulta = "INSERT INTO turnos ( id_deporte, id_usuario, f_turno) VALUES (?, ?, ?) ";	
        $resultado = $conexion->prepare($consulta);
        $resultado->execute(array($selecDeporte, $id_usuario, $fturno));                        
        break;        

    case 9:
        // saca los links de los menues (PANILLA COMPLETA DE MENU-TITULOS Y LINKS)
        //mail, clave , nombre, domicilio, f_nacimiento, telefono, bloqueado,
        $consulta ="INSERT INTO clientes ( mail, clave , nombre, domicilio, f_nacimiento, telefono, bloqueado) VALUES (?, ?, ?, ?, ?, ?, ?) ";
        $resultado = $conexion->prepare($consulta);
        $resultado->execute(array($mail, $clave , $nombre, $domicilio, $f_nacimiento, $telefono, $bloqueado));                        
        break;        

    case 10:
        // Saca solo los Menues  para el DropDown (Llamado desde links.vue)
        $consulta = "SELECT id_turno, deporte.descripcion, id_usuario, clientes.mail, clientes.nombre, clientes.telefono, f_turno, cancelado 
                        FROM turnos, deporte, clientes 
                        WHERE turnos.id_deporte = deporte.id_deporte 
                        AND turnos.id_usuario = clientes.id_cliente 
                        AND turnos.id_deporte = ?
                        AND f_turno >= ? 
                        ORDER BY f_turno";
        $resultado = $conexion->prepare($consulta);
        $resultado->execute(array($selecDeporte, $hoy ));  
        $data=$resultado->fetchAll(PDO::FETCH_ASSOC);             
        break;         
        
    case 11:
        // Saca solo los Titulos para el DropDown (Llamado desde links.vue)
        $consulta = "DELETE FROM turnos WHERE id_turno = ?"; 
        $resultado = $conexion->prepare($consulta);
        $resultado->execute(array($id_turno));                        
        break;

    case 99:
        // BORRA UN TITULO Y TODOS SUS LINK ASOCIADOS (LLAMADO DESDE TARJETAS.VUE)  se hace un borrado logico
        //  $consulta = "DELETE FROM links WHERE id_link=? ";	
        
        $consulta = "UPDATE titulos SET borrado=?  
                    WHERE id_titulo=? ";		
        $resultado = $conexion->prepare($consulta);
        $resultado->execute(array(1, $id_titulo));      

        $consulta = "UPDATE links SET borrado=?  
                    WHERE id_titulo=? ";		
        $resultado = $conexion->prepare($consulta);
        $resultado->execute(array(1, $id_titulo));                           
        break;    
        
    case 99: 
        // ACTUALIZA UN EDIT DE UN TITULO (LLAMADO DESDE TARJETAS.VUE)
        $consulta = "UPDATE titulos SET id_menu=?,  descripcion_titulo=?, 
                            imagen_path=?,  footer=?  
                        WHERE id_titulo=? ";		
        $resultado = $conexion->prepare($consulta);
        $resultado->execute(array($id_menu, $descripcion_titulo, $imagen_path, $footer, $id_titulo));                        
        $data=$resultado->fetchAll(PDO::FETCH_ASSOC);
        break;    
        
    case 99:
        // INSERTA EN LA TABLA DE TITULO EL NUEVO TITULOS (LLAMADO DESDE TARJETAS.VUE)
        $consulta = "INSERT INTO titulos (id_menu, descripcion_titulo, imagen_path, footer) VALUES(?, ?, ?, ?) ";	
        $resultado = $conexion->prepare($consulta);
        $resultado->execute(array($id_menu,  $descripcion_titulo, $imagen_path, $footer));                        
        break;
            
            
}

if(isset($data)){
    print json_encode($data, JSON_UNESCAPED_UNICODE);
}else{
    print 'ok';
}

$conexion = NULL;

/**
 *  An example CORS-compliant method.  It will allow any GET, POST, or OPTIONS requests from any
 *  origin.
 *
 *  In a production environment, you probably want to be more restrictive, but this gives you
 *  the general idea of what is involved.  For the nitty-gritty low-down, read:
 *
 *  - https://developer.mozilla.org/en/HTTP_access_control
 *  - https://fetch.spec.whatwg.org/#http-cors-protocol
 *
 */
function cors() {
    
    // Allow from any origin
    if (isset($_SERVER['HTTP_ORIGIN'])) {
      
        // Decide if the origin in $_SERVER['HTTP_ORIGIN'] is one
        // you want to allow, and if so:
        header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
        header('Access-Control-Allow-Credentials: true');
        header('Access-Control-Max-Age: 86400');    // cache for 1 day
    }
    
    // Access-Control headers are received during OPTIONS requests
    if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
        
        if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD']))
            // may also be using PUT, PATCH, HEAD etc
            header("Access-Control-Allow-Methods: GET, POST, OPTIONS");         
        
        if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']))
            header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");
    
        exit(0);
    }
    
    //echo "You have CORS!";
}