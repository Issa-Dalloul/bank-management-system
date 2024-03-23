<?php
require_once('../model/db_connection.php');

// Check if the form is submitted
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Retrieve form data
    $user_name = $_POST['user_name'];
    $email = $_POST['email'];
    $message_text = $_POST['message_text'];

    // Insert data into the contact_messages table
    $query = "INSERT INTO contact_messages (user_name, email, message_text) 
              VALUES ('$user_name', '$email', '$message_text')";
    
    if ($conn->query($query)) {
      
        // Redirect to the home page
        header("Location: ../views/homepage.php");
        exit(); // Ensure that no more code is executed after the redirect
    } else {
        echo "Error: " . $conn->error;
    }
}
?>
