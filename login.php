<?php
session_start([
    'use_cookies' => 1, // Enable cookies if available
    'use_only_cookies' => 0, // Allow session ID in URL if cookies are disabled
    'use_trans_sid' => 1 // Enable transparent SID support (appends session ID to URL)
]);

// Ensure the session cookie expires when the browser is closed
session_set_cookie_params(0);

$correctPassword = "8145302135";

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    if ($_POST["password"] === $correctPassword) {
        $_SESSION["authenticated"] = true;
        header("Location: index?" . session_name() . "=" . session_id()); // Pass session ID in URL
        exit;
    } else {
        $error = "Incorrect password!";
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="icon" type="image/x-icon" href="/icons/cloud.png">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=arrow_circle_right" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
        }
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: #ffffff;
        }
        .login-container {
            background: #ffffff;
            padding: 50px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            text-align: center;
            width: 600px;
            height:600px;
        }
        .logo {
            width:280px;
            margin-bottom: 20px;
        }
        h2 {
            margin-bottom: 20px;
            color: #1d1d1f;
            font-weight: 600;
            font-size: 26px;
        }
        .input-container {
            position: relative;
            width: 100%;
        }
        input {
            width: 100%;
            padding: 14px;
            padding-right: 40px;
            border: 1px solid  #fad648;
            border-radius: 12px;
            font-size: 18px;
            background: #f5f5f7;
            outline: none;
            transition: 0.3s ease-in-out;
        }
        input:focus {
            border-color: #0071e3;
            background: #ffffff;
        }
        .arrow-button {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            background: transparent;
            border: none;
            cursor: pointer;
            font-size: 24px;
            color: #0071e3;
        }
    </style>
</head>
<body>
    <div class="login-container">
<video class="logo" autoplay loop muted>
    <source src="/icons/login.mp4" type="video/mp4">
    Your browser does not support the video tag.
</video>
        <h2>Enter Password</h2>
        <form method="POST">
            <div class="input-container" style="display:flex;justify-content:center;">
                <input type="password" name="password" placeholder="Enter your password" required>
                <button type="submit" class="arrow-button"><span class="material-symbols-outlined" style="font-size:2rem;color:rgb(113, 113, 113);font-weight:200;">
arrow_circle_right
</span></button>
            </div>
            <!-- <div style="color:grey;margin-top:30px;font-size:0.3rem;">
                Designed And Developed by Suchibrata
            </div> -->
        </form>
    </div>
</body>
</html>


