<?php
require 'config.php';

// 2. Process form when submitted via POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = htmlspecialchars($_POST['client_name'] ?? '');
    $email = filter_var($_POST['client_email'] ?? '', FILTER_SANITIZE_EMAIL);
    $message = htmlspecialchars($_POST['client_message'] ?? '');
    $subscribe = isset($_POST['subscribe']) ? 1 : 0;

    if (!empty($name) && !empty($email) && !empty($message)) {
        // Insert message into database using PDO Prepared Statement
        $sql = 'INSERT INTO messages (client_name, client_email, client_message, subscribed)
        VALUES (:name, :email, :message, :subscribed)';

        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            ':name' => $name,
            ':email' => $email,
            ':message' => $message,
            ':subscribed' => $subscribe
        ]);

        // Confirmation banner
        $_SESSION['form_message'] = 'Thank you, ' . $name . '! Your message has been sent' . ($subscribe ? " and you're subscribed to updates!" : '!');
    }
}

// Redirect back to index.php#contact (PRG pattern)
header('Location: index.php#contact');
exit();

?>