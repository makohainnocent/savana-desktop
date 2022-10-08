<?php 
header("Access-Control-Allow-Origin: *");

if($_GET["address"]) {
    file_put_contents("address.html",$_GET["address"]);

    file_put_contents("commandId.html",$_GET["commandId"]);

    echo "ok";

    exit();
 }
?>