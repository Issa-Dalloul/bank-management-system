<?php
require_once('../model/db_connection.php');

function getAllLoanRequests() {
    global $conn;
    $loanRequests = array();

    $query = "SELECT la.application_id, la.custid, u.username, la.amount, la.status
              FROM loan_applications la
              LEFT JOIN users u ON la.custid = u.custid";
    $result = $conn->query($query);

    if (!$result) {
        echo '<p class="error-message">Error retrieving loan requests: ' . $conn->error . '</p>';
        return $loanRequests;
    }

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $loanRequests[] = $row;
        }
    } else {
        echo '<p class="info-message">No loan requests found. Debug: result set is empty.</p>';
    }

    return $loanRequests;
}

function acceptLoanRequest($applicationId) {
    global $conn;

    // Get loan application details
    $loanApplicationQuery = "SELECT custid, amount FROM loan_applications WHERE application_id = ?";
    $loanApplicationStmt = $conn->prepare($loanApplicationQuery);
    $loanApplicationStmt->bind_param("i", $applicationId);
    $loanApplicationStmt->execute();
    $loanApplicationResult = $loanApplicationStmt->get_result();

    if ($loanApplicationResult->num_rows > 0) {
        $loanApplicationRow = $loanApplicationResult->fetch_assoc();
        $custid = $loanApplicationRow['custid'];
        $amount = $loanApplicationRow['amount'];

        // Debug information
        echo '<p class="info-message">Debug: Loan application details - custid: ' . $custid . ', amount: ' . $amount . '</p>';

        // Insert approved loan into the 'loan' table
        $insertLoanQuery = "INSERT INTO loan (custid, bid, loan_amount) VALUES (?, '101', ?)";
        $insertLoanStmt = $conn->prepare($insertLoanQuery);
        $insertLoanStmt->bind_param("ii", $custid, $amount);
        $insertLoanStmt->execute();

        // Update loan application status to 'accepted'
        $updateStatusQuery = "UPDATE loan_applications SET status = 'accepted' WHERE application_id = ?";
        $updateStatusStmt = $conn->prepare($updateStatusQuery);
        $updateStatusStmt->bind_param("i", $applicationId);
        $updateStatusStmt->execute();

        // Delete the accepted loan application
        $deleteLoanAppQuery = "DELETE FROM loan_applications WHERE application_id = ?";
        $deleteLoanAppStmt = $conn->prepare($deleteLoanAppQuery);
        $deleteLoanAppStmt->bind_param("i", $applicationId);
        $deleteLoanAppStmt->execute();

        echo '<p class="success-message">Loan application accepted successfully!</p>';
    } else {
        echo '<p class="error-message">Error: Loan application not found. Debug: ' . $conn->error . '</p>';
    }
}

function rejectLoanRequest($applicationId) {
    global $conn;

    $query = "DELETE FROM loan_applications WHERE application_id = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $applicationId);

    return $stmt->execute();
}

$loanRequestsData = getAllLoanRequests();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['accept'])) {
        $applicationId = $_POST['application_id'];

        if (acceptLoanRequest($applicationId)) {
            echo '<p class="success-message">Loan request accepted successfully!</p>';
            // Refresh the loan requests after accepting
            $loanRequestsData = getAllLoanRequests();
        } else {
          
        }
    } elseif (isset($_POST['reject'])) {
        $applicationId = $_POST['application_id'];

        if (rejectLoanRequest($applicationId)) {
            echo '<p class="success-message">Loan request rejected successfully!</p>';
            // Refresh the loan requests after rejecting
            $loanRequestsData = getAllLoanRequests();
        } else {
            echo '<p class="error-message">Failed to reject loan request.</p>';
        }
    }
}?>