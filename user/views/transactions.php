<?php
// transactions.php

// Start the session
session_start();

// Include the necessary files and connect to the database
require_once('../model/db_connection.php');
require_once('../control/transactions.php'); // Assume you have a file with transaction-related functions
require_once('../control/account_functions.php'); // Assume you have a file with account-related functions

// Get custid from the session or wherever it's coming from
$custid = $_SESSION['custid'] ?? null; // Use the null coalescing operator to handle potential undefined index

// Check if custid is set
if ($custid) {
    // Retrieve acnumber associated with the custid
    $acnumber = getAccountNumber($custid); // Implement this function in account_functions.php

    // Retrieve transaction details using acnumber
    $transactionDetails = getTransactionDetails($acnumber); // Implement this function in transactions_functions.php
}

// Include header and footer

?>
<?php
include('header.php');
include('footer.php');?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction Details</title>
    <link rel="stylesheet" href="../styling/transactions.css">
</head>

<body class="transactionbody">
    <div class="containir">
        <h1 class="th1">Transaction Details</h1>

        <?php if ($transactionDetails): ?>
            <div class="transaction-info">
                <p><strong>Transaction Number:</strong> <?php echo $transactionDetails['tnumber']; ?></p>
                <p><strong>Account Number:</strong> <?php echo $transactionDetails['acnumber']; ?></p>
                <p><strong>Date of Transaction:</strong> <?php echo $transactionDetails['dot']; ?></p>
                <p><strong>Medium of Transaction:</strong> <?php echo $transactionDetails['medium_of_transaction']; ?></p>
                <p><strong>Transaction Type:</strong> <?php echo $transactionDetails['transaction_type']; ?></p>
                <p><strong>Transaction Amount:</strong> <?php echo $transactionDetails['transaction_amount']; ?></p>
                <!-- Add more fields as needed -->
            </div>
        <?php else: ?>
            <p>Transaction not found.</p>
        <?php endif; ?>
    </div>
</body>

</html>
