<?php
require_once "core/conexion.php";

$conexion = new conexion();

$sql = "INSERT INTO pacientes (cedula) VALUES ('123456789')";

print_r($conexion->nonQuery($sql));

?>