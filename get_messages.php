<?php

header("Access-Control-Allow-Origin: *");

// Autoriser les méthodes de requête GET et POST
header("Access-Control-Allow-Methods: GET, POST");

// Autoriser les en-têtes personnalisés et l'en-tête Content-Type
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

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

// Récupérer le login de l'utilisateur
$sql_get_login = "SELECT login FROM code WHERE Code = '$code'";
$result_login = $conn->query($sql_get_login);

if ($result_login->num_rows > 0) {
  $row_login = $result_login->fetch_assoc();
  $login = $row_login["login"];

  // Récupérer la maladie de l'utilisateur
  $sql_get_disease = "SELECT disease FROM code WHERE Code = '$code'";
  $result_disease = $conn->query($sql_get_disease);

  if ($result_disease->num_rows > 0) {
    $row_disease = $result_disease->fetch_assoc();
    $disease = $row_disease["disease"];

    // Récupérer les messages de l'utilisateur avec son login
    $sql_get_messages = "SELECT c.login, g.message FROM groupe g INNER JOIN code c ON g.Code = c.Code WHERE c.disease = '$disease'";
    $result_messages = $conn->query($sql_get_messages);

    if ($result_messages->num_rows > 0) {
      // Créer un tableau pour stocker les messages avec le login
      $messages = [];
      while($row_messages = $result_messages->fetch_assoc()) {
        $messages[] = ["login" => $row_messages["login"], "message" => $row_messages["message"]];
      }
      // Renvoyer les messages au format JSON
      echo json_encode($messages);
    } else {
      echo "Aucun message trouvé pour cet utilisateur";
    }
  } else {
    echo "Aucune maladie trouvée pour cet utilisateur";
  }
} else {
  echo "Aucun utilisateur trouvé avec ce code";
}

// Fermer la connexion à la base de données
$conn->close();


?>
