<?php

include "conn.php";

if($_SERVER['REQUEST_METHOD'] == "POST"){
    $response = array();
    $uname = $_POST['uname'];
    $pass = md5($_POST['pass']);
    $cek = "SELECT * FROM users WHERE uname='$uname'";
    $result = mysqli_fetch_array(mysqli_query($con, $cek));

    if(isset($result)){
        $response['value'] = 2;
        $response['message'] = 'Username Telah Digunakan';
        echo json_encode($response);

    } else{
        $insert = "INSERT INTO users VALUES('', '$uname', '$pass')";
        if(mysqli_query($con, $insert)){
            $response ['value'] = 1;
            $response ['message'] = "Berhasil didaftarkan";
            echo json_encode($response);

        }else{
            $response['value'] = 0;
            $response['message'] = "Gagal Didaftarkan";
            echo json_encode($response);
        }
    }
}
