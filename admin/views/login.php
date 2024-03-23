<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../styling/login.css">
    <title>Login - Dbank</title>
</head>
<body>

<div class="container">
    <form action="../control/logincheck.php" method="post">
        <h2>Login As Admin</h2>
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>

        <button type="submit">Login</button>
    </form>
  
</div>

</body>
</html>
