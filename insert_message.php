<?php
// Les détails de la base de données
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "app";
// Créer une connexion à la base de données
$conn = new mysqli($servername, $username, $password, $dbname);

// Vérifier la connexion
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

// Récupérer les données envoyées depuis Flutter
$code = $_POST['password']; // Utilisez 'code' au lieu de 'login'
$message = $_POST['message']; // Utilisez 'message' pour le champ de message

// Préparer et exécuter la requête SQL pour insérer les données
$sql = "INSERT INTO groupe (Code, message) VALUES ('$code', '$message')";

if ($conn->query($sql) === TRUE) {
  echo "Message inséré avec succès";
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}
// Fermer la connexion à la base de données
$conn->close();

?>