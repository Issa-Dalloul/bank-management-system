<?php
// account_functions.php

// Include the necessary files and connect to the database
require_once('../model/db_connection.php');

// Function to get the account number associated with a custid
function getAccountNumber($custid) {
    global $conn;

    $query = "SELECT acnumber FROM account WHERE custid = '$custid'";
    $result = $conn->query($query);

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        return $row['acnumber'];
    } else {
        return null;
    }
}
?>
