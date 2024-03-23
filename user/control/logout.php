<?php
session_start();

// Destroy the session data
session_destroy();

// Redirect to the login page
header("Location: ../views/login.php");
exit();
?>
