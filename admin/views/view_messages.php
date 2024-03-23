<?php
require_once('../model/db_connection.php');
require_once('../control/view_messages_control.php'); // Include the file where you fetch messages data

// Fetch messages data
$messagesData = getAllMessages();

// Rest of your code
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Messages</title>
    <link rel="stylesheet" href="../styling/view_messages.css">
</head>
<body>
    <div class="container">
        <h1>Contact Messages</h1>
        <?php
        if ($messagesData) {
            echo '<table>';
            echo '<tr><th>Message ID</th><th>User Name</th><th>Email</th><th>Message Text</th><th>Submission Date</th><th>Action</th></tr>';
            foreach ($messagesData as $message) {
                echo '<tr>';
                echo '<td>' . $message['message_id'] . '</td>';
                echo '<td>' . $message['user_name'] . '</td>';
                echo '<td>' . $message['email'] . '</td>';
                echo '<td>' . $message['message_text'] . '</td>';
                echo '<td>' . $message['submission_date'] . '</td>';
                echo '<td>
                        <form action="" method="post">
                            <input type="hidden" name="message_id" value="' . $message['message_id'] . '">
                            <button type="submit" name="mark_as_read">Mark as Read</button>
                        </form>
                      </td>';
                echo '</tr>';
            }
            echo '</table>';
        } else {
            echo '<p class="info-message">No contact messages found.</p>';
        }
        ?>
    </div>
</body>
</html>
