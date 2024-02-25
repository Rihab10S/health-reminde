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
$med_name = $_POST['medicine_name'];
$nombre_de_fois = $_POST['number_of_times'];
$avant_apres = $_POST['before_or_after'];
$time1 = $_POST['time_1'];
$time2 = $_POST['time_2'];
$time3 = $_POST['time_3'];
$login = $_POST['login'];
$password = $_POST['password'];

// Requête d'insertion des données dans la table reminder
$sql = "INSERT INTO reminder (Code, med_name, nombre_de_fois, avant_apres, time1, time2, time3)
        VALUES ('$password', '$med_name', '$nombre_de_fois', '$avant_apres', '$time1', '$time2', '$time3')";

if ($conn->query($sql) === TRUE) {
    echo "Données insérées avec succès";
} else {
    echo "Erreur lors de l'insertion des données: " . $conn->error;
}

// Fermeture de la connexion
$conn->close();

?>
