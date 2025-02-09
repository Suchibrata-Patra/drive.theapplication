<?php
$githubUsername = "Suchibrata-Patra";  // Your GitHub username
$githubRepo = "drive.theapplication";  // Your repository name
$githubBranch = "main";  // Change if using another branch
$githubToken = "YOUR_GITHUB_TOKEN";  // Replace with new GitHub token

// Handle File Upload
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_FILES['file'])) {
    $file = $_FILES['file'];
    $fileName = basename($file['name']);
    $fileTempPath = $file['tmp_name'];

    if (!file_exists($fileTempPath)) {
        die(json_encode(["status" => "error", "message" => "Temporary file not found"]));
    }

    $fileContent = base64_encode(file_get_contents($fileTempPath));
    $fileName = preg_replace("/[^A-Za-z0-9_\-\.]/", "_", $fileName); // Sanitize file name
    $filePath = rawurlencode($fileName);
    $apiUrl = "https://api.github.com/repos/$githubUsername/$githubRepo/contents/$filePath";

    // Check if file exists (get SHA)
    $ch = curl_init($apiUrl);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        "Authorization: Bearer $githubToken",
        "User-Agent: PHP-File-Uploader"
    ]);
    $existingFileResponse = curl_exec($ch);
    $existingFileData = json_decode($existingFileResponse, true);
    curl_close($ch);

    $fileSHA = isset($existingFileData['sha']) ? $existingFileData['sha'] : null;

    // Prepare data for GitHub API
    $data = [
        "message" => "Upload $fileName",
        "content" => $fileContent,
        "branch"  => $githubBranch
    ];

    if ($fileSHA) {
        $data["sha"] = $fileSHA;
    }

    $dataJson = json_encode($data);

    // Upload file using cURL
    $ch = curl_init($apiUrl);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "PUT");
    curl_setopt($ch, CURLOPT_POSTFIELDS, $dataJson);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        "Authorization: Bearer $githubToken",
        "User-Agent: PHP-File-Uploader",
        "Content-Type: application/json"
    ]);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);

    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    file_put_contents("debug_log.txt", print_r(json_decode($response, true), true)); // Debugging

    if ($httpCode == 201 || $httpCode == 200) {
        $responseData = json_decode($response, true);
        $fileUrl = $responseData['content']['html_url'];
        echo json_encode(["status" => "success", "message" => "File uploaded successfully!", "url" => $fileUrl]);
    } else {
        echo json_encode(["status" => "error", "message" => "Upload failed!", "response" => json_decode($response, true)]);
    }
    exit;
}

// Handle Fetching File List
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $apiUrl = "https://api.github.com/repos/$githubUsername/$githubRepo/contents/";

    $ch = curl_init($apiUrl);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        "Authorization: Bearer $githubToken",
        "User-Agent: PHP-File-Uploader"
    ]);
    $response = curl_exec($ch);
    curl_close($ch);

    $files = json_decode($response, true);
    if (is_array($files)) {
        $fileList = [];
        foreach ($files as $file) {
            if ($file['type'] === 'file') {
                $fileList[] = ["name" => $file['name'], "url" => $file['html_url']];
            }
        }
        echo json_encode(["status" => "success", "files" => $fileList]);
    } else {
        echo json_encode(["status" => "error", "message" => "Failed to fetch files"]);
    }
    exit;
}

echo json_encode(["status" => "error", "message" => "Invalid request"]);
?>
