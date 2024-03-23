<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Customers</title>
    <link rel="stylesheet" href="../styling/view_customers.css">
</head>
<body>
    <div class="container">
        <h1>View Customers</h1>
        <?php include('../control/view_customers.php'); ?>
        <div class="customer-list">
            <?php
            if ($customersData) {
                echo '<table>';
                echo '<tr><th>CustID</th><th>First Name</th><th>Middle Name</th><th>Last Name</th><th>City</th><th>Mobile No</th><th>Occupation</th><th>DOB</th><th>Actions</th></tr>';
                foreach ($customersData as $customer) {
                    echo '<tr>';
                    echo '<td>' . $customer['custid'] . '</td>';
                    echo '<td>' . $customer['fname'] . '</td>';
                    echo '<td>' . $customer['mname'] . '</td>';
                    echo '<td>' . $customer['ltname'] . '</td>';
                    echo '<td>' . $customer['city'] . '</td>';
                    echo '<td>' . $customer['mobileno'] . '</td>';
                    echo '<td>' . $customer['occupation'] . '</td>';
                    echo '<td>' . $customer['dob'] . '</td>';
                    echo '<td>';
                    echo '<form action="" method="post">';
                    echo '<input type="hidden" name="custid" value="' . $customer['custid'] . '">';

                    // Display existing customer data in input fields
                    echo '<input type="text" name="fname" value="' . $customer['fname'] . '" required>';
                    echo '<input type="text" name="mname" value="' . $customer['mname'] . '" required>';
                    echo '<input type="text" name="ltname" value="' . $customer['ltname'] . '" required>';
                    echo '<input type="text" name="city" value="' . $customer['city'] . '" required>';
                    echo '<input type="text" name="mobileno" value="' . $customer['mobileno'] . '" required>';
                    echo '<input type="text" name="occupation" value="' . $customer['occupation'] . '" required>';
                    echo '<input type="text" name="dob" value="' . $customer['dob'] . '" required>';

                    echo '<input type="submit" name="update_customer" value="Update">';
                    echo '<input type="submit" name="remove" value="Remove">';
                    echo '</form>';
                    echo '</td>';
                    echo '</tr>';
                }
                echo '</table>';
            } else {
                echo '<p>No customers found.</p>';
            }
            ?>
        </div>
    </div>
</body>
</html>
