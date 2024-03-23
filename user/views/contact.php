<?php include('header.php'); ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- <link rel="stylesheet" href="styling/main.css"> Assuming you have a main.css for general styling -->
    <link rel="stylesheet" href="../styling/contact.css"> <!-- Styling specific to the Contact Us page -->
    <title>Contact Us - Dbank</title>
</head>
<body>

<div class="container">
    <section class="contact-section">
        <h2>Contact Us</h2>
        <p>If you have any questions or inquiries, feel free to reach out to us. Our dedicated team is here to assist you.</p>

        <form action="../control/submit_contact.php" method="post">
    <!-- Add your form fields here -->
    <input type="text" name="user_name" placeholder="Your Name" required>
    <input type="email" name="email" placeholder="Your Email" required>
    <textarea name="message_text" placeholder="Your Message" required></textarea>
    <button type="submit">Submit</button>
</form>
    </section>
</div>

<?php include 'footer.php'; ?>

</body>
</html>
