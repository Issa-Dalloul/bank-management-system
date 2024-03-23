<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Transactions</title>
    <link rel="stylesheet" href="../styling/view_transactions.css">
</head>
<body>
    <div class="container">
        <h1>View Transactions</h1>
        <?php include('../control/view_transactions_control.php'); ?>
        <div class="transaction-list">
            <?php
            if ($transactionsData) {
                echo '<table>';
                echo '<tr><th>Transaction Number</th><th>Account Number</th><th>Date</th><th>Medium of Transaction</th><th>Transaction Type</th><th>Transaction Amount</th><th>Customer Username</th></tr>';
                foreach ($transactionsData as $transaction) {
                    echo '<tr>';
                    echo '<td>' . $transaction['tnumber'] . '</td>';
                    echo '<td>' . $transaction['acnumber'] . '</td>';
                    echo '<td>' . $transaction['dot'] . '</td>';
                    echo '<td>' . $transaction['medium_of_transaction'] . '</td>';
                    echo '<td>' . $transaction['transaction_type'] . '</td>';
                    echo '<td>' . $transaction['transaction_amount'] . '</td>';
                    echo '<td>' . $transaction['username'] . '</td>';
                    echo '</tr>';
                }
                echo '</table>';
            } else {
                echo '<p>No transactions found.</p>';
            }
            ?>
        </div>
    </div>
</body>
</html>
