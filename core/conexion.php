<?php

class conexion {
    private $host;
    private $user;
    private $password;
    private $database;
    private $port;
    private $conexion;


    public function __construct() {
        $listadatos = $this->datosConexion();
        foreach ($listadatos as $key => $value) {
            $this->host = $value['host'];
            $this->user = $value['user'];
            $this->password = $value['password'];
            $this->database = $value['database'];
            $this->port = $value['port'];
        }       
        try {
            $this->conexion = new PDO("pgsql:host=$this->host;port=$this->port;dbname=$this->database", $this->user, $this->password);
            $this->conexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (Exception $e) {
            die('No se ha podido conectar: ' . $e->getMessage());
        }


    }

    private function datosConexion(){
        $direccion = dir(__DIR__);      
        $jsondata = file_get_contents($direccion->path ."/"."config");
        return json_decode($jsondata,true);
    }

    private function convertirUTF8($array){
        array_walk_recursive($array, function(&$item, $key){
            if(!mb_detect_encoding($item, 'utf-8', true)){
                $item = utf8_encode($item);
            }
        });
        return $array;
    }

    public function obtenerDatos($sql){
        $resultado = $this->conexion->query($sql);
        $resultadoArray = array();
        foreach ($resultado as $key => $value) {
            $resultadoArray[] = $value;
        }
        return $this->convertirUTF8($resultadoArray);
    }

    public function nonQuery($sql){
        $resultado = $this->conexion->query($sql);
        return $this->conexion->lastInsertId();
    }

    //INSERT
    public function nonQueryId($sql){
        $resultado = $this->conexion->query($sql);
        $filas = $this->conexion->lastInsertId();
        if($filas >= 1){
            return $this->conexion->insert_id;
        }else{
            return 0;
        }
    }









}

?>