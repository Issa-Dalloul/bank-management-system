<!-- signup.php -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../styling/signup.css">
    <title>Sign Up</title>
</head>
<body>

<div class="container">
    <h2>Sign Up</h2>
    <form action="../control/signup_process.php" method="post">
        <input type="text" name="fname" placeholder="First Name" required>
        <input type="text" name="mname" placeholder="Middle Name" required>
        <input type="text" name="ltname" placeholder="Last Name" required>
        <input type="text" name="city" placeholder="City" required>
        <input type="text" name="mobileno" placeholder="Mobile Number" required>
        <input type="text" name="occupation" placeholder="Occupation" required>
        <input type="date" name="dob" required>
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>
        <input type="email" name="email" placeholder="Email" required>
        <button type="submit">Sign Up</button>
    </form>
    <p>Already have an account? <a href="login.php">Login here</a></p>
</div>

</body>
</html>
