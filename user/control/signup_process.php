<?php
require_once('../model/db_connection.php');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Retrieve form data
    $fname = $_POST['fname'];
    $mname = $_POST['mname'];
    $ltname = $_POST['ltname'];
    $city = $_POST['city'];
    $mobileno = $_POST['mobileno'];
    $occupation = $_POST['occupation'];
    $dob = $_POST['dob'];
    $username = $_POST['username'];
    $password = $_POST['password'];
    $email = $_POST['email'];

    // Insert data into the customer table
    $query_customer = "INSERT INTO customer (fname, mname, ltname, city, mobileno, occupation, dob)
                      VALUES ('$fname', '$mname', '$ltname', '$city', '$mobileno', '$occupation', '$dob')";

    if ($conn->query($query_customer)) {
        // Get the custid of the newly inserted customer
        $custid = $conn->insert_id;

        // Insert data into the users table
        $query_user = "INSERT INTO users (custid, username, password, email, user_type)
                       VALUES ('$custid', '$username', '$password', '$email', 'customer')";

        if ($conn->query($query_user)) {
            echo "User registered successfully!";
            // Redirect the user to the login page
            header("Location: ../views/login.php");
            exit();
        } else {
            echo "Error: " . $conn->error;
        }
    } else {
        echo "Error: " . $conn->error;
    }
}

// ... existing code for user signup ...

// Assuming $custid and $bid are generated or obtained elsewhere
$opening_balance = 0.0; // Set an initial balance
$aod = date('Y-m-d'); // Assuming you want to set the account opening date to the current date
$atype = 'Savings'; // Change this according to your account types
$astatus = 'Active';

// Insert data into the account table
$query = "INSERT INTO account (custid, bid, opening_balance, aod, atype, astatus) 
          VALUES ('$custid', '$bid', '$opening_balance', '$aod', '$atype', '$astatus')";

if ($conn->query($query)) {
    // Account created successfully
} else {
    // Handle the error
    echo "Error: " . $conn->error;
}
?>

