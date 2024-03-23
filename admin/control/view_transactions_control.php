<?php
require_once('../model/db_connection.php');

function getAllTransactions() {
    global $conn;
    $transactions = array();

    // Modify the query to include the username
    $query = "SELECT t.tnumber, t.acnumber, t.dot, t.medium_of_transaction, t.transaction_type, t.transaction_amount, u.username
              FROM trandetails t
              JOIN account a ON t.acnumber = a.acnumber
              JOIN users u ON a.custid = u.custid";
    $result = $conn->query($query);

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $transactions[] = $row;
        }
    }

    return $transactions;
}

$transactionsData = getAllTransactions();
?>
