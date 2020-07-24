<?php
if (isset($_POST['eventAddress'], $_POST['eventDesc'], $_POST['eventType'])) {
    require_once 'db_config.php';

    $eventType = $_POST['eventType'];
    $eventAddress = $_POST['eventAddress'];
    $eventDesc = $_POST['eventDesc'];
    $approval = "pending";

    $sql = "INSERT INTO tbl_events (eventType, eventAddress, eventDesc, approval) VALUES ('$eventType', '$eventAddress', '$eventDesc', '$approval')";

    $executeQuery = mysqli_query($db_conn, $sql);

    if ($executeQuery) {
        echo (json_encode(array('statusCode' => '1', 'message' => 'Event submitted!')));
    } else {
        echo (json_encode(array('statusCode' => '0', 'message' => 'Error while submitting event!')));
    }
    mysqli_close($db_conn);
} else echo (json_encode(array('statusCode' => '4', 'message' => 'Error in method!')));
return;
