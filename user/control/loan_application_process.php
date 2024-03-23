<?php
// Start the session
session_start();

// Include the necessary files and connect to the database
require_once('../model/db_connection.php');

// Check if the user is logged in
// Skip the login check

// Get the user ID from the session, assuming 'custid' is used for logged-in users
$user_id = isset($_SESSION['custid']) ? $_SESSION['custid'] : null;

// Get the loan amount from the form
$amount = $_POST['amount'];

// Insert the loan application into the database
$application_query = "INSERT INTO loan_applications (custid, amount) VALUES ('$user_id', '$amount')";
$conn->query($application_query);

// Close the database connection
$conn->close();

// Redirect the user after applying for a loan
// Redirect to any desired page or leave it empty
header("Location: ../views/loans.php");
exit();
?>
