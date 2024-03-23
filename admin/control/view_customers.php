<?php
require_once('../model/db_connection.php');

function getAllCustomers() {
    global $conn;
    $customers = array();

    $query = "SELECT * FROM customer";
    $result = $conn->query($query);

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $customers[] = $row;
        }
    }

    return $customers;
}

function updateCustomer($custid, $fname, $mname, $ltname, $city, $mobileno, $occupation, $dob) {
    global $conn;

    $query = "UPDATE customer SET fname=?, mname=?, ltname=?, city=?, mobileno=?, occupation=?, dob=? WHERE custid=?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("sssssssi", $fname, $mname, $ltname, $city, $mobileno, $occupation, $dob, $custid);

    return $stmt->execute();
}

function removeCustomer($custid) {
    global $conn;

    $query = "DELETE FROM customer WHERE custid=?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $custid);

    return $stmt->execute();
}

$customersData = getAllCustomers();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['update_customer'])) {
        $custid = $_POST['custid'];
        $fname = $_POST['fname'];
        $mname = $_POST['mname'];
        $ltname = $_POST['ltname'];
        $city = $_POST['city'];
        $mobileno = $_POST['mobileno'];
        $occupation = $_POST['occupation'];
        $dob = $_POST['dob'];

        if (updateCustomer($custid, $fname, $mname, $ltname, $city, $mobileno, $occupation, $dob)) {
            echo '<p class="success-message">Customer updated successfully!</p>';
            // Refresh the customer data after update
            $customersData = getAllCustomers();
        } else {
            echo '<p class="error-message">Failed to update customer.</p>';
        }
    } elseif (isset($_POST['remove'])) {
        $custid = $_POST['custid'];

        if (removeCustomer($custid)) {
            echo '<p class="success-message">Customer removed successfully!</p>';
            // Refresh the customer data after removal
            $customersData = getAllCustomers();
        } else {
            echo '<p class="error-message">Failed to remove customer.</p>';
        }
    }
}
?>
