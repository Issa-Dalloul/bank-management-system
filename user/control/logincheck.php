<?php
require_once('../model/db_connection.php');
session_start();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];

    // Use a prepared statement to prevent SQL injection
    $login_query = $conn->prepare("SELECT * FROM users WHERE username = ? AND password = ?");
    $login_query->bind_param("ss", $username, $password);
    $login_query->execute();
    $login_result = $login_query->get_result();

    if ($login_result->num_rows > 0) {
        $row = $login_result->fetch_assoc();

        // Store user ID, username, and custid in the session
        $_SESSION['user_id'] = $row['userid'];
        $_SESSION['username'] = $row['username'];

        if ($row['user_type'] == 'admin') {
            header("Location: ../admin/views/homepage.php");
            exit();
        } else {
            $_SESSION['custid'] = $row['custid'];
            header("Location: ../views/homepage.php");
            exit();
        }
    } else {
        // If no matches found, redirect to login page
        header("Location: ../views/login.php");
        exit();
    }
} else {
    // If not a POST request, redirect to login page
    header("Location: ../views/login.php");
    exit();
}
?>
