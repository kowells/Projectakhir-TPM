<?php

include "conn.php";

if ($_SERVER['REQUEST_METHOD'] == "POST") {
    $response = array();
    $uname = $_POST['uname'];
    $pass = md5($_POST['pass']);

    $cek = "SELECT * FROM users WHERE uname='$uname' and pass='$pass'";
    $result = mysqli_fetch_array(mysqli_query($con, $cek));

    if (isset($result)) {
        $response['value'] = 1;
        $response['message'] = 'Login Berhasil';
        $response['uname'] = $uname;
        $response['pass'] = $pass;
        echo json_encode($response);
    } else {

        $response['value'] = 0;
        $response['message'] = "Username atau Password Salah";
        echo json_encode($response);
    }
}
