<?php
require_once('../model/db_connection.php');

function getAllMessages() {
    global $conn;
    $messages = array();

    $query = "SELECT * FROM contact_messages";
    $result = $conn->query($query);

    if (!$result) {
        echo '<p class="error-message">Error retrieving messages: ' . $conn->error . '</p>';
        return $messages;
    }

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $messages[] = $row;
        }
    } else {
        // echo '<p class="info-message">No messages found. Debug: result set is empty.</p>';
    }

    return $messages;
}

function markAsRead($messageId) {
    global $conn;

    $query = "DELETE FROM contact_messages WHERE message_id = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $messageId);

    return $stmt->execute();
}

$messagesData = getAllMessages();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['mark_as_read'])) {
        $messageId = $_POST['message_id'];

        if (markAsRead($messageId)) {
            echo '<p class="success-message">Message marked as read and deleted successfully!</p>';
            // Refresh the messages after marking as read
            $messagesData = getAllMessages();
        } else {
            echo '<p class="error-message">Failed to mark message as read.</p>';
        }
    }
}
?>
