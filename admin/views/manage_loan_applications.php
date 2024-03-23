<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Loans</title>
    <link rel="stylesheet" href="../styling/view_loans.css">
</head>
<body>
    <div class="container">
        <h1>View Loans Requests</h1>
        <?php include('../control/view_loans_control.php'); ?>
        <div class="loan-list">
            <?php
            if ($loanRequestsData) {
                echo '<table>';
                echo '<tr><th>Application ID</th><th>Customer ID</th><th>Customer Username</th><th>Amount</th><th>Status</th><th>Action</th></tr>';
                foreach ($loanRequestsData as $loanRequest) {
                    echo '<tr>';
                    echo '<td>' . $loanRequest['application_id'] . '</td>';
                    echo '<td>' . $loanRequest['custid'] . '</td>';
                    echo '<td>' . $loanRequest['username'] . '</td>';
                    echo '<td>' . $loanRequest['amount'] . '</td>';
                    echo '<td>' . $loanRequest['status'] . '</td>';
                    echo '<td>
                            <form action="" method="post">
                                <input type="hidden" name="application_id" value="' . $loanRequest['application_id'] . '">
                                <button type="submit" name="accept">Accept</button>
                                <button type="submit" name="reject">Reject</button>
                            </form>
                          </td>';
                    echo '</tr>';
                }
                echo '</table>';
            } else {
               
            }
            ?>
        </div>
    </div>
</body>
</html>
