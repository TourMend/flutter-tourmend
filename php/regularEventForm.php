<?php
if (isset($_POST['eventAddress'], $_POST['eventDesc'], $_POST['eventType'], $_POST['eventName'], $_POST['from'], $_POST['to'])) {
    require_once 'db_config.php';

    $eventName = $_POST['eventName'];
    $eventAddress = $_POST['eventAddress'];
    $eventDesc = $_POST['eventDesc'];
    $eventType = $_POST['eventType'];
    $fromDate = $_POST['from'];
    $toDate = $_POST['to'];
    $approval = "pending";

    $sql = "INSERT INTO tbl_events (eventName, eventAddress, eventType, description, fromDate, toDate, approval) VALUES ('$eventName','$eventAddress','$eventType','$eventDesc','$fromDate','$toDate','$approval')";


    $executeQurey = mysqli_query($db_conn, $sql);

    if ($executeQurey) {
        echo (json_encode(array('statusCode' => '1', 'message' => 'Event submitted!')));
    } else {
        echo (json_encode(array('statusCode' => '0', 'message' => 'Error while submitting event!')));
    }
    mysqli_close($db_conn);
} else echo (json_encode(array('statusCode' => '4', 'message' => 'Error in method!')));
return;
