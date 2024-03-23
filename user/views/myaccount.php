<?php
// Start the session
session_start();

// Check if the user is logged in
if (!isset($_SESSION['user_id'])) {
    // Redirect to the login page if not logged in
    header("Location: login.php");
    exit();
}

// Include the database connection file
require_once('../model/db_connection.php');

// Retrieve the user ID from the session
$user_id = $_SESSION['user_id'];

// Query to retrieve user information
$query = "SELECT * FROM users WHERE userid = $user_id";
$result = $conn->query($query);

// Check if user data is found
if ($result->num_rows > 0) {
    // Fetch user data
    $user_data = $result->fetch_assoc();
} else {
    // Redirect or display an error message if user not found
    header("Location: error.php");
    exit();
}

// Close the database connection
$conn->close();
?>
<?php include('header.php'); ?>
<?php include('footer.php'); ?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Account</title>
    <link rel="stylesheet" href="../styling/myaccount.css"> <!-- Link to your stylesheet -->
</head>


<body>
    <div class="containar">
        <h1>My Account</h1>

        <div class="user-info">
            <p><strong>User ID:</strong> <?php echo $user_data['userid']; ?></p>
            <p><strong>Username:</strong> <?php echo $user_data['username']; ?></p>
            <p><strong>Email:</strong> <?php echo $user_data['email']; ?></p>
            <p><strong>User Type:</strong> <?php echo $user_data['user_type']; ?></p>
            <!-- Add more fields as needed -->
        </div>
    </div>
</body>

</html>