<?php
header("Access-Control-Allow-Origin: *");

// Autoriser les méthodes de requête GET et POST
header("Access-Control-Allow-Methods: GET, POST");

// Autoriser les en-têtes personnalisés et l'en-tête Content-Type
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// Informations de connexion à la base de données
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "app";

// Création de la connexion
$conn = new mysqli($servername, $username, $password, $dbname);

// Vérification de la connexion
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Récupération des données du formulaire
$medicine_name = $_POST['medicine_name'];
$number_of_times = $_POST['number_of_times'];
$before_or_after = $_POST['before_or_after'];
$time_1 = $_POST['time_1'];
$time_2 = $_POST['time_2'];
$time_3 = $_POST['time_3'];
$login = $_POST['login']; // Supposons que ce soit le code
$password = $_POST['password']; // Supposons que ce soit le mot de passe

// Vérification de l'authenticité de la mise à jour
$sql_auth = "SELECT * FROM reminder WHERE Code = '$password'";
$result_auth = $conn->query($sql_auth);

if ($result_auth->num_rows > 0) {
    // Authentification réussie, effectuer la mise à jour
    $sql = "INSERT INTO reminder (Code, med_name, nombre_de_fois, avant_apres, time1, time2, time3)
        VALUES ('$password', '$med_name', '$nombre_de_fois', '$avant_apres', '$time1', '$time2', '$time3')";

    $sql_update = "UPDATE reminder SET med_name = '$medicine_name', nombre_de_fois = '$number_of_times', avant_apres = '$before_or_after', time1 = '$time_1', time2 = '$time_2', time3 = '$time_3' WHERE Code = '$password'";
    
    if ($conn->query($sql_update) === TRUE) {
        echo "Mise à jour réussie";
    } else {
        echo "Erreur lors de la mise à jour : " . $conn->error;
    }
} else {
    echo "Erreur d'authentification : Code ou mot de passe incorrect";
}

// Fermeture de la connexion
$conn->close();

?>
