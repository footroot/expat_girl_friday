<?php
// 1. Ensure session is started for rate limiting and session flash messages
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

require_once 'config.php';

// 2. Cooldown period in seconds (1 minute between submissions)
$cooldownSeconds = 60;

// 3. Process form when submitted via POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    // --- HONEYPOT SPAM CHECK ---
    // Bot trap: If the hidden honeypot field is filled out, reject silently
    if (!empty($_POST['website_hp'])) {
        header('Location: index#contact');
        exit();
    }

    // --- RATE LIMITING CHECK ---
    if (isset($_SESSION['last_submit_time'])) {
        $timeSinceLastSubmit = time() - $_SESSION['last_submit_time'];

        if ($timeSinceLastSubmit < $cooldownSeconds) {
            $remaining = $cooldownSeconds - $timeSinceLastSubmit;
            
            $_SESSION['form_error'] = "Please wait {$remaining} seconds before sending another message.";
            header('Location: index#contact');
            exit();
        }
    }

    // --- INPUT SANITIZATION ---
    // Note: Use htmlspecialchars on output (in index/admin), raw storage in DB is best practice,
    // but preserving your existing logic:
    $name = trim($_POST['client_name'] ?? '');
    $email = filter_var($_POST['client_email'] ?? '', FILTER_SANITIZE_EMAIL);
    $message = trim($_POST['client_message'] ?? '');
    $subscribe = isset($_POST['subscribe']) ? 1 : 0;

    // Validate email & required fields
    if (!empty($name) && !empty($email) && !empty($message) && filter_var($email, FILTER_VALIDATE_EMAIL)) {
        
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

        // Update submission timestamp for rate limiting
        $_SESSION['last_submit_time'] = time();

        // Confirmation banner
        $_SESSION['form_message'] = 'Thank you, ' . htmlspecialchars($name, ENT_QUOTES, 'UTF-8') . '! Your message has been sent' . ($subscribe ? " and you're subscribed to updates!" : '!');
    } else {
        $_SESSION['form_error'] = 'Please fill out all required fields with a valid email address.';
    }
}

// Redirect back to index#contact (PRG pattern)
header('Location: index#contact');
exit();
?>