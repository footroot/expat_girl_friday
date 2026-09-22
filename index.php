<?php
require 'config.php';

// 1. Retrieve & clear message from session (if set from previous submission)
$formMessage = $_SESSION['form_message'] ?? '';
unset($_SESSION['form_message']);

?>



<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><?php echo $businessName; ?> | Your Local Helping Hand</title>
<link href="https://fonts.googleapis.com/css2?family=Caveat:wght@500;700&family=Nunito:wght@400;700;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="style.css">
</head>
<body>
<header>
<a class="brand" href="#home">
    ♡ <?php echo $businessName; ?>
</a>

<button id="menuToggle" aria-expanded="false">☰</button>

<nav id="nav">
    <a href="#home">Home</a>
    <a href="#services">Services</a>
    <a href="#contact">Contact</a>
    <a class="nav-button" href="#contact">Contact us</a>
</nav>
</header>
<main>
<section class="hero" id="home">
    <div class="hero-copy">
        <div class="sun">☀</div>
        <h1>Expat Girl Friday ♡</h1>
        <div class="highlight">Your local helping hand<br>in Spain</div>
        
        <!-- we dont have to put a name on the greeting until we have a session open -->
        <p><?php echo greetClient(); ?></p>
        
        <p>Friendly <b>•</b> Reliable <b>•</b> Practical <b>•</b> Bilingual</p>
        <a class="button" href="#services">Discover our services →</a>
    </div>
    <div class="landscape">
        <div class="mountain one">

        </div>
        <div class="mountain two">

        </div>
        <div class="castle">🏰</div>
        <div class="village">🏘️ 🏠 🏡</div>
        <div class="fruit">🍊</div>
        <div class="plant">🌿</div>
    </div>
</section>
<section class="intro">
    <div>🇬🇧 <span>♡</span> 🇪🇸</div>
    <p>Whether you are new to Spain, need help with an official appointment, have furniture to collect, or simply need a reliable pair of hands — Expat Girl Friday is here to help.</p>
</section>
<section id="services" class="services">
    <div class="heading">
        <span>〰</span>
        <h2>Our Services</h2>
        <span>〰</span>
    </div>
        <div class="grid">
            <?php foreach ($services as $service): ?>
                <article class="card <?php echo $service['class']; ?>">


                    <div class="art"><?php echo $service['icon']; ?></div>
                    
                    
                    <h3><?php echo $service['title']; ?></h3>
                    <p><?php echo $service['description']; ?></p>
                    <ul>
                        <?php foreach ($service['items'] as $item): ?>
                            <li><?php echo $item; ?></li>
                        <?php endforeach; ?>
                    </ul>
                    <button class="details" data-service="<?php echo $service['key']; ?>">More information</button>

                </article>
                <?php endforeach; ?>
        </div>

</section>

<section class="quick">
    <a href="#services">💬 Interpreting</a>
<a href="#services">🚐 Van & Collections</a>
<a href="#services">✈️ Airport Runs</a>
<a href="#services">🅿️ Secure Parking</a>
</section>

<!-- CONTACT SECTION -->
<section id="contact" class="contact">
<div>
    <h2>Get in touch!</h2>
    <div class="line"></div>

<!-- DISPLAY GREEN SUCCESS BANNER -->
<?php if (!empty($formMessage)): ?>
    <div id="successBanner" class="banner-success">
        <?php echo $formMessage; ?>
    </div>
<?php endif; ?>

<!-- REFACTORED CONTACT FORM -->
<form action="process-form.php" method="POST" class="contact-form">
    <div class="form-group">
        <label class="form-label">Your Name:</label>
        <input type="text" name="client_name" class="form-control" required>
    </div>

    <div class="form-group">
        <label class="form-label">Your Email:</label>
        <input type="email" name="client_email" class="form-control" required>
    </div>

    <div class="form-group">
        <label class="form-label">Your Message:</label>
        <textarea name="client_message" rows="3" class="form-control" required></textarea>
    </div>

    <div class="form-group-lg">
        <label class="form-checkbox-label">
            <input type="checkbox" name="subscribe" value="1" checked> 
            Subscribe to local news, offers & updates ♡
        </label>
    </div>

    <button type="submit" class="button">Send Message →</button>
</form>


    <div class="contact-details">
        <a href="https://wa.me/<?php echo $whatsappNumber; ?>" target="_blank">
            ☎ <span><b>Phone / WhatsApp</b><?php echo $phoneNumber; ?><br></span>
        </a>

        <a href="mailto:expatgirlfriday@gmail.com">
            ✉ <span><b>Email</b>expatgirlfriday@gmail.com</span>
        </a>

        <div>
            ●
            <span>
                <b>Location</b>
                <?php echo $location; ?><br>
                Serving the surrounding area
            </span>
        </div>
    </div>

    <a class="button" href="mailto:expatgirlfriday@gmail.com">
        Contact us →
    </a>
</div>

<div class="contact-art">
    Local help,<br>
    when you<br>
    need it most ♡<br>
    🏔️ 🏘️
</div>
</section>
</main>
<footer><p>♡ Experience Spain with one less thing to worry about. ♡</p><small>© <span id="year"></span> Expat Girl Friday</small>
</footer>
<div class="modal" id="modal" hidden>
    <div class="modal-box">
        <button id="close">×</button>
        <div id="modalIcon">♡</div>
        <h2 id="modalTitle"></h2>
        <p id="modalText"></p>
        <a class="button" href="mailto:expatgirlfriday@gmail.com">Contact us →</a>
    </div>
</div>
<script src="script.js"></script>
</body>
</html>