<?php

if (isset($_POST['username'], $_POST['email'], $_POST['password'])) {

    require_once 'db_config.php';

    $email = $_POST['email'];
    $username = $_POST['username'];
    $password = $_POST['password'];
    $checkEmail = "SELECT * FROM user_info WHERE email =  $email";

    $checkresultEmail = mysqli_query($db_conn, $checkEmail);
    
    //check if email already exists	
    if (mysqli_num_rows($checkresultEmail) > 0) {
        echo (json_encode(array('statusCode' => '2', 'message' => 'This email address already has an account')));
        
        return;
    } else {
        // mail ( string $to , string $subject , string $message , array|string $additional_headers = [] , string $additional_params = "" ) : bool
       
        $subject = "Account Activation!";
        $message = "Hi, $username! Welcome to the TourMend. Enter the link below to activate your account
        http://localhost/TourMendWebServices/activate.php?email=$email";
        // From header chaincha
        $header = "FROM:TourMend.MP@gmail.com";

        if(mail($email, $subject, $message, $header)) {
            
            $hashedPassword = sha1($password);
            $status = "inactive";
            $sql = "INSERT INTO user_info (username, email, password, image, reset_code, status) VALUES ('$username', '$email', '$hashedPassword', '', '', '$status')";

            $executeQurey = mysqli_query($db_conn, $sql);

            if ($executeQurey) {
                echo (json_encode(array('statusCode' => '1', 'message' => 'User successfully registered!')));
            } else {
                echo (json_encode(array('statusCode' => '0', 'message' => 'Error while registering user!')));
            }
        } else {

            echo (json_encode(array('statusCode' => '3', 'message' => 'Email address is wrong!')));
        }
    } 
    mysqli_free_result($checkEmail);
    mysqli_close($db_conn);
} else {
    echo (json_encode(array('statusCode' => '4', 'message' => 'Error in method!')));
}
?>