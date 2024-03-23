<?php
// transactions_functions.php

// Include the necessary files and connect to the database
require_once('../model/db_connection.php');

// Function to get transaction details by acnumber
function getTransactionDetails($acnumber) {
    global $conn;

    $query = "SELECT * FROM trandetails WHERE acnumber = '$acnumber'";
    $result = $conn->query($query);

    if ($result->num_rows > 0) {
        return $result->fetch_assoc();
    } else {
        return null;
    }
}
?>
