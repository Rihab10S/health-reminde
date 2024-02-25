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
    // Vérification si les champs password et disease sont définis
    if (isset($_POST['password']) && isset($_POST['disease']) && isset($_POST['login'])) {
        // Échapper les caractères spéciaux pour éviter les injections SQL
        $password = mysqli_real_escape_string($conn, $_POST['password']);
        $disease = mysqli_real_escape_string($conn, $_POST['disease']);
        $login = mysqli_real_escape_string($conn, $_POST['login']);
        // Préparer et exécuter la requête d'insertion
        $stmt = $conn->prepare("INSERT INTO code (Code, disease, login) VALUES (?, ?, ?)");
        $stmt->bind_param("sss", $password, $disease, $login );

        if ($stmt->execute()) {
            echo "Enregistrement ajouté avec succès";
        } else {
            echo "Erreur lors de l'ajout de l'enregistrement : " . $conn->error;
        }

        $stmt->close();
    } else {
        echo "Les champs password et disease ne sont pas définis.";
    }
} else {
    echo "Les données doivent être envoyées via la méthode POST.";
}

// Fermer la connexion à la base de données
$conn->close();
?>
