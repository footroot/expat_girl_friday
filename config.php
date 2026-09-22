<?php
session_start();
require_once 'db.php';

$businessName = 'Expat Girl Friday';
$location = 'Xàtiva, Spain';
$phoneNumber = '+34 722 116 205';
$whatsappNumber = '34722116205';

// functions
function greetClient($name = '')
{
    if (empty($name)) {
        return 'Welcome to Expat Girl Friday! ' . $name . '';
    }
    // return "Welcome to Expat Girl Friday, ". $name . "!";
}

// Services list array we declare arrays with $name = [ ... ]
// we can loop through them in the HTML to create the cards dynamically.
// This is a more maintainable approach than hardcoding each card in the HTML.
// Services list (Array)
$stmt = $pdo->query("SELECT * FROM services");
$dbServices = $stmt->fetchAll();

$services = [];
foreach ($dbServices as $row) {
    $services[] = [
        'key'           => $row['service_key'],
        'class'         => $row['class_name'],
        'icon'          => $row['icon'],
        'title'         => $row['title'],
        'description'   => $row['description'],
        // keep default list items or add a separate table for service items later
        'items'         =>['Local assistance', 'Reliable service', 'Personalized support']

    ];
}

?>