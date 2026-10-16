<?php
require_once 'config.php';
http_response_code(404);
?>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Page Not Found | <?php echo htmlspecialchars($businessName ?? 'Site'); ?></title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <style>
        .error-container {
            min-height: 70vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 20px;
        }
        .error-code {
            font-size: 6rem;
            font-weight: 900;
            color: #ef4444;
            line-height: 1;
            margin: 0;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1 class="error-code">404</h1>
        <h2>Oops! Page Not Found</h2>
        <p style="color: #64748b; max-width: 450px; margin: 15px 0 25px;">
            The page you are looking for might have been moved, deleted, or never existed.
        </p>
        <a href="index" class="button" style="background: #2563eb; color: #ffffff; text-decoration: none; padding: 12px 24px; border-radius: 8px; font-weight: bold;">
            ← Return to Homepage
        </a>
    </div>
</body>
</html>