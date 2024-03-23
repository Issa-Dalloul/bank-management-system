<?php
if (session_status() === PHP_SESSION_NONE) {
    // Only start the session if it's not already started
    session_start();
}

// Check if the user is logged in and the username is set in the session
if (isset($_SESSION['username'])) {
    $username = $_SESSION['username'];
} else {
    // Redirect or handle the case where the username is not set
    // For example, you can redirect to the login page
    header("Location: login.php");
    exit();
}
?>
<script src="https://kit.fontawesome.com/7552b865b0.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="../styling/header.css">
<!-- Nunito Font -->
<div class="head">
<nav class="nav">
    <div class="nav-items">
        <div class="logo nav-item" style=" padding: 3px 3px;"></div>
        <a href="homepage.php" class="nav-item" style="  padding: 10px 15px; border-radius: 5px;">Home</a>
        <a href="myaccount.php" class="nav-item" style="  padding: 10px 15px; border-radius: 5px;">My Account</a>
        <a href="transactions.php" class="nav-item" style="  padding: 10px 15px; border-radius: 5px;">Transactions</a>
        <a href="loans.php" class="nav-item" style="  padding: 10px 15px; border-radius: 5px;">Loans</a>
        <a href="../control/logout.php" class="nav-item" style="background-color:red;color:white;padding: 10px 15px; border-radius: 5px;">Logout</a>
    </div>
    <div class="right">
        <div class="icons">
            <i class="fa-solid fa-gear"></i>
            <i class="nots fa-solid fa-bell"></i>
        </div>
        <div class="profile">
            <h3><?php echo $username; ?></h3>
            <a href="myaccount.php"> <img  src="../image/1177568.png" alt=""> </a> 
        </div>
    </div>
</nav>
</div>