<?php
// Start the session
session_start();

// Include the necessary files and connect to the database
require_once('../model/db_connection.php');
?>
<?php include('../views/header.php'); ?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Loans</title>
    <link rel="stylesheet" href="../styling/transactions.css">
    <!-- Add any necessary stylesheets or scripts here -->
</head>

<body>
    <div class="container">
        <h1>Loan Details</h1>

        <?php
        // Check if "custid" key is set in the session
        if (isset($_SESSION['custid'])) {
            // Retrieve custid from the session
            $custid = $_SESSION['custid'];

            // Query to check if the user has loans
            $loan_query = "SELECT * FROM loan WHERE custid = '$custid'";
            $loan_result = $conn->query($loan_query);

            if ($loan_result->num_rows > 0) {
                // User has loans, display loan details
                while ($loan_row = $loan_result->fetch_assoc()) {
                    echo "<p>Loan Amount: $" . $loan_row['loan_amount'] . "</p>";
                    // Add more details as needed
                }
            } else {
                // User has no loans
                echo "<p>You have no loans.</p>";
            }
        } else {
            // Handle the case when "custid" key is not set in the session
            echo "<p>User not logged in.</p>";
        }
        ?>
    </div>
    <div class="container">
        <h1>Apply for a Loan</h1>

        <form action="../control/loan_application_process.php" method="post">
            <label for="amount">Loan Amount:</label>
            <input type="number" id="amount" name="amount" required>

            <button type="submit">Submit Application</button>
        </form>
    </div>
</body>

</html>

<?php include('../views/footer.php'); ?>
