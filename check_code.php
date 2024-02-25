<?php
header("Access-Control-Allow-Origin: *");

// Autoriser les méthodes de requête GET et POST
header("Access-Control-Allow-Methods: GET, POST");

// Autoriser les en-têtes personnalisés et l'en-tête Content-Type
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// Connexion à la base de données
$servername = "localhost"; // Adresse IP de votre serveur MySQL
$username = "root"; // Nom d'utilisateur MySQL
$password = ""; // Mot de passe MySQL
$dbname = "app"; // Nom de la base de données

// Création de la connexion
$conn = new mysqli($servername, $username, $password, $dbname);

// Vérification de la connexion
if ($conn->connect_error) {
    die("La connexion à la base de données a échoué : " . $conn->connect_error);
}

// Vérification si les données sont envoyées via POST
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Vérification si les champs code et login sont définis
    if (isset($_POST['code']) && isset($_POST['login'])) {
        // Échapper les caractères spéciaux pour éviter les injections SQL
        $code = mysqli_real_escape_string($conn, $_POST['code']);
        $login = mysqli_real_escape_string($conn, $_POST['login']);

        // Préparer et exécuter la requête de sélection pour le code
        $stmt_code = $conn->prepare("SELECT * FROM code WHERE Code = ?");
        $stmt_code->bind_param("s", $code);
        $stmt_code->execute();
        $result_code = $stmt_code->get_result();

        // Préparer et exécuter la requête de sélection pour le login
        $stmt_login = $conn->prepare("SELECT * FROM code WHERE Login = ?");
        $stmt_login->bind_param("s", $login);
        $stmt_login->execute();
        $result_login = $stmt_login->get_result();

        if ($result_code->num_rows > 0 && $result_login->num_rows > 0) {
            // Le code et le login existent dans la base de données
            echo "exists";
        } else {
            // Le code ou le login n'existe pas dans la base de données
            echo "not_exists";
        }

        $stmt_code->close();
        $stmt_login->close();
    } else {
        // Les champs code et login ne sont pas définis
        echo "missing_fields";
    }
} else {
    // Les données doivent être envoyées via la méthode POST
    echo "post_required";
}

// Fermer la connexion à la base de données
$conn->close();
?>
