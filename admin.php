<?php
require 'config.php';

// Handle Logout
if (isset($_GET['action']) && $_GET['action'] === 'logout') {
    unset($_SESSION['is_admin']);
    header('Location: admin.php');
    exit();
}

// Handle Login Submission
$loginError = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['admin_password'])) {
    $submittedPassword = $_POST['admin_password'] ?? '';

    if (password_verify($submittedPassword, ADMIN_PASSWORD_HASH)) {
        $_SESSION['is_admin'] = true;
        header('Location: admin.php');
        exit();
    } else {
        $loginError = 'Incorrect password!';
    }
}

// Check if user is logged in
$isLoggedIn = $_SESSION['is_admin'] ?? false;

// Handle Actions (Only for Logged-In Admins)
if ($isLoggedIn && $_SERVER['REQUEST_METHOD'] === 'POST') {
    
    // Verify CSRF Token
    $submittedToken = $_POST['csrf_token'] ?? '';
    if (!hash_equals($_SESSION['csrf_token'], $submittedToken)) {
        die('CSRF token validation failed!');
    }

    // 1. Handle Message Deletion
    if (isset($_POST['delete_id'])) {
        $deleteId = (int)$_POST['delete_id'];
        if ($deleteId > 0) {
            $stmt = $pdo->prepare("DELETE FROM messages WHERE id = :id");
            $stmt->execute([':id' => $deleteId]);
            $_SESSION['admin_notice'] = "Message #{$deleteId} deleted successfully.";
        }
    }

    // 2. Handle Service Creation
    if (isset($_POST['add_service'])) {
        $key   = htmlspecialchars($_POST['service_key'] ?? '');
        $title = htmlspecialchars($_POST['title'] ?? '');
        $class = htmlspecialchars($_POST['class_name'] ?? '');
        $icon  = htmlspecialchars($_POST['icon'] ?? '');
        $desc  = htmlspecialchars($_POST['description'] ?? '');

        if (!empty($key) && !empty($title) && !empty($desc)) {
            $stmt = $pdo->prepare("INSERT INTO services (service_key, class_name, icon, title, description) VALUES (:key, :class, :icon, :title, :desc)");
            $stmt->execute([
                ':key'   => $key,
                ':class' => $class,
                ':icon'  => $icon,
                ':title' => $title,
                ':desc'  => $desc
            ]);
            $_SESSION['admin_notice'] = "New service '{$title}' created successfully!";
        }
    }

    // 3. Handle Service Update (EDIT)
    if (isset($_POST['edit_service'])) {
        $serviceId = (int)$_POST['service_id'];
        $key       = htmlspecialchars($_POST['service_key'] ?? '');
        $title     = htmlspecialchars($_POST['title'] ?? '');
        $class     = htmlspecialchars($_POST['class_name'] ?? '');
        $icon      = htmlspecialchars($_POST['icon'] ?? '');
        $desc      = htmlspecialchars($_POST['description'] ?? '');

        if ($serviceId > 0 && !empty($key) && !empty($title) && !empty($desc)) {
            $stmt = $pdo->prepare("UPDATE services SET service_key = :key, class_name = :class, icon = :icon, title = :title, description = :desc WHERE id = :id");
            $stmt->execute([
                ':key'   => $key,
                ':class' => $class,
                ':icon'  => $icon,
                ':title' => $title,
                ':desc'  => $desc,
                ':id'    => $serviceId
            ]);
            $_SESSION['admin_notice'] = "Service '{$title}' updated successfully!";
        }
    }

    // 4. Handle Service Deletion
    if (isset($_POST['delete_service_id'])) {
        $serviceId = (int)$_POST['delete_service_id'];
        if ($serviceId > 0) {
            $stmt = $pdo->prepare("DELETE FROM services WHERE id = :id");
            $stmt->execute([':id' => $serviceId]);
            $_SESSION['admin_notice'] = "Service deleted successfully.";
        }
    }

    header('Location: admin.php');
    exit();
}

// Handle CSV Export
if ($isLoggedIn && isset($_GET['action']) && $_GET['action'] === 'export_csv') {
    $stmt = $pdo->prepare("SELECT client_name, client_email, created_at FROM messages WHERE subscribed = 1 ORDER BY created_at DESC");
    $stmt->execute();
    $subscribers = $stmt->fetchAll();

    $filename = "subscribers_" . date('Y-m-d') . ".csv";
    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename="' . $filename . '"');

    $output = fopen('php://output', 'w');
    fputcsv($output, ['Name', 'Email Address', 'Date Subscribed']);

    foreach ($subscribers as $sub) {
        fputcsv($output, [
            $sub['client_name'],
            $sub['client_email'],
            date('Y-m-d H:i', strtotime($sub['created_at']))
        ]);
    }

    fclose($output);
    exit();
}

// Fetch Service to Edit (if requested via GET)
$editingService = null;
if ($isLoggedIn && isset($_GET['edit_service_id'])) {
    $editId = (int)$_GET['edit_service_id'];
    $stmt = $pdo->prepare("SELECT * FROM services WHERE id = :id");
    $stmt->execute([':id' => $editId]);
    $editingService = $stmt->fetch();
}

// Retrieve & clear notification notice
$adminNotice = $_SESSION['admin_notice'] ?? '';
unset($_SESSION['admin_notice']);
?>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | <?php echo $businessName; ?></title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="admin-container">

        <?php if (!$isLoggedIn): ?>
            <!-- LOGIN FORM -->
            <h1>🔒 Admin Login</h1>
            <?php if ($loginError): ?>
                <p style="color: #c53030; font-weight: bold;"><?php echo $loginError; ?></p>
            <?php endif; ?>

            <form action="admin.php" method="POST" style="max-width: 320px; margin-top: 20px;">
                <div class="form-group">
                    <label class="form-label">Password:</label>
                    <input type="password" name="admin_password" class="form-control" required autofocus>
                </div>
                <button type="submit" class="button" style="margin-top: 10px;">Login →</button>
            </form>
            <p style="margin-top: 25px;"><a href="index.php">← Back to main site</a></p>

        <?php else: ?>
            <!-- ADMIN DASHBOARD -->
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <h1>⚙️ Admin Management Dashboard</h1>
                <div style="display: flex; gap: 10px;">
                    <a href="admin.php?action=export_csv" class="button" style="background: #10b981; color: #ffffff; text-decoration: none; padding: 8px 14px; font-size: 0.9rem; font-weight: bold; border-radius: 6px;">
                        Export Subscribers CSV 📊
                    </a>
                    <a href="admin.php?action=logout" class="button" style="background: #e2e8f0; color: #1e293b; text-decoration: none; padding: 8px 14px; font-size: 0.9rem; font-weight: bold; border-radius: 6px;">
                        Logout 🚪
                    </a>
                </div>
            </div>

            <?php if (!empty($adminNotice)): ?>
                <div class="banner-success" style="margin-top: 15px;">
                    <?php echo htmlspecialchars($adminNotice); ?>
                </div>
            <?php endif; ?>

            <!-- EDIT SERVICE MODAL (Renders when edit_service_id is in URL) -->
            <?php if ($editingService): ?>
                <div class="modal-overlay">
                    <div class="modal-content">
                        <h3>✏️ Edit Service: <?php echo htmlspecialchars($editingService['title']); ?></h3>
                        <form action="admin.php" method="POST" style="margin-top: 15px;">
                            <input type="hidden" name="csrf_token" value="<?php echo $_SESSION['csrf_token']; ?>">
                            <input type="hidden" name="edit_service" value="1">
                            <input type="hidden" name="service_id" value="<?php echo $editingService['id']; ?>">

                            <div class="form-group">
                                <label class="form-label">Service Key (Slug):</label>
                                <input type="text" name="service_key" value="<?php echo htmlspecialchars($editingService['service_key']); ?>" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Title:</label>
                                <input type="text" name="title" value="<?php echo htmlspecialchars($editingService['title']); ?>" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Icon / Emoji:</label>
                                <input type="text" name="icon" value="<?php echo htmlspecialchars($editingService['icon']); ?>" class="form-control">
                                <span class="emoji-hint">Press Win + . (Windows) or Cmd + Ctrl + Space (Mac) for emoji picker</span>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Color Class:</label>
                                <input type="text" name="class_name" value="<?php echo htmlspecialchars($editingService['class_name']); ?>" class="form-control">
                            </div>
                            <div class="form-group">
                                <label class="form-label">Description:</label>
                                <textarea name="description" rows="3" class="form-control" required><?php echo htmlspecialchars($editingService['description']); ?></textarea>
                            </div>

                            <div style="display: flex; gap: 10px; margin-top: 15px;">
                                <button type="submit" class="btn-primary">Save Changes ✓</button>
                                <a href="admin.php" class="button" style="background: #e2e8f0; color: #475569; text-decoration: none; padding: 10px 16px; font-weight: bold; border-radius: 6px;">Cancel</a>
                            </div>
                        </form>
                    </div>
                </div>
            <?php endif; ?>

            <!-- SECTION 1: SERVICES MANAGER -->
            <h2 style="margin-top: 30px;">🛠️ Manage Services</h2>
            <div class="admin-grid">
                <!-- Add Service Form -->
                <div class="admin-card">
                    <h3>Add New Service</h3>
                    <form action="admin.php" method="POST" style="margin-top: 15px;">
                        <input type="hidden" name="csrf_token" value="<?php echo $_SESSION['csrf_token']; ?>">
                        <input type="hidden" name="add_service" value="1">

                        <div class="form-group">
                            <label class="form-label">Service Key (Slug):</label>
                            <input type="text" name="service_key" placeholder="e.g. translation" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Title:</label>
                            <input type="text" name="title" placeholder="Official Translation" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Icon / Emoji:</label>
                            <input type="text" name="icon" placeholder="📝" class="form-control">
                            <span class="emoji-hint">Press Win + . or Cmd + Ctrl + Space to pick emojis</span>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Color Class:</label>
                            <input type="text" name="class_name" placeholder="pink / blue / green / purple" class="form-control">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Description:</label>
                            <textarea name="description" rows="3" class="form-control" required></textarea>
                        </div>

                        <button type="submit" class="btn-primary">Add Service +</button>
                    </form>
                </div>

                <!-- Existing Services Table -->
                <div class="admin-card">
                    <h3>Active Services</h3>
                    <?php
                    $stmt = $pdo->query("SELECT * FROM services ORDER BY id ASC");
                    $servicesList = $stmt->fetchAll();
                    ?>
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>Icon</th>
                                <th>Title</th>
                                <th>Key</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($servicesList as $s): ?>
                                <tr>
                                    <td style="font-size: 1.2rem;"><?php echo htmlspecialchars($s['icon']); ?></td>
                                    <td><strong><?php echo htmlspecialchars($s['title']); ?></strong></td>
                                    <td><code><?php echo htmlspecialchars($s['service_key']); ?></code></td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="admin.php?edit_service_id=<?php echo $s['id']; ?>" class="btn-warning">Edit ✏️</a>
                                            <form action="admin.php" method="POST" onsubmit="return confirm('Delete this service?');">
                                                <input type="hidden" name="csrf_token" value="<?php echo $_SESSION['csrf_token']; ?>">
                                                <input type="hidden" name="delete_service_id" value="<?php echo $s['id']; ?>">
                                                <button type="submit" class="btn-danger">Delete 🗑️</button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- SECTION 2: MESSAGES TABLE -->
            <h2 style="margin-top: 40px;">📩 Received Messages</h2>
            <?php
            $stmt = $pdo->query("SELECT * FROM messages ORDER BY created_at DESC");
            $messages = $stmt->fetchAll();
            ?>

            <p style="margin-top: 10px;">Total Submissions: <strong><?php echo count($messages); ?></strong></p>

            <?php if (empty($messages)): ?>
                <p>No messages received yet.</p>
            <?php else: ?>
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Message</th>
                            <th>Subscribed?</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($messages as $msg): ?>
                            <tr>
                                <td><?php echo date('Y-m-d H:i', strtotime($msg['created_at'])); ?></td>
                                <td><strong><?php echo htmlspecialchars($msg['client_name']); ?></strong></td>
                                <td><a href="mailto:<?php echo htmlspecialchars($msg['client_email']); ?>"><?php echo htmlspecialchars($msg['client_email']); ?></a></td>
                                <td><?php echo nl2br(htmlspecialchars($msg['client_message'])); ?></td>
                                <td>
                                    <?php if ($msg['subscribed']): ?>
                                        <span class="badge badge-yes">✓ Yes</span>
                                    <?php else: ?>
                                        <span class="badge badge-no">✗ No</span>
                                    <?php endif; ?>
                                </td>
                                <td>
                                    <form action="admin.php" method="POST" onsubmit="return confirm('Are you sure you want to delete this message?');">
                                        <input type="hidden" name="csrf_token" value="<?php echo $_SESSION['csrf_token']; ?>">
                                        <input type="hidden" name="delete_id" value="<?php echo $msg['id']; ?>">
                                        <button type="submit" class="btn-danger">Delete 🗑️</button>
                                    </form>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            <?php endif; ?>

            <p style="margin-top: 25px;"><a href="index.php">← Back to main site</a></p>

        <?php endif; ?>

    </div>
</body>
</html>