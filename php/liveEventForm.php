<?php

if (isset($_POST['eventAddress'], $_POST['eventDesc'], $_POST['eventType'])) {
    require_once 'db_config.php';

    $eventAddress = $_POST['eventAddress'];
    $eventDesc = $_POST['eventDesc'];
    $eventType = $_POST['eventType'];

    $sql = "INSERT INTO tbl_events (eventaddress, eventType, description) VALUES ('$eventAddress','$eventType','$eventDesc')";


    $executeQurey = mysqli_query($db_conn, $sql);

    if ($executeQurey) {
        echo (json_encode(array('statusCode' => '1', 'message' => 'Event submitted!')));
    } else {
        echo (json_encode(array('statusCode' => '0', 'message' => 'Error while submitting event!')));
    }
    mysqli_close($db_conn);
} else echo (json_encode(array('statusCode' => '4', 'message' => 'Error in method!')));
return;
