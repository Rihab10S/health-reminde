<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST");
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

// Fonction pour vérifier si une alarme doit être déclenchée
function checkAlarms($conn) {
    $now = date('H:i:s'); // Heure actuelle

    // Récupérer les heures stockées dans la base de données
    $sql = "SELECT * FROM reminder";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        // Parcourir les heures stockées
        while($row = $result->fetch_assoc()) {
            // Vérifier si une heure stockée correspond à l'heure actuelle
            if ($now == $row["time1"] || $now == $row["time2"] || $now == $row["time3"]) {
                // Si une alarme doit être déclenchée, afficher un message
                echo "Alarme déclenchée";
                return;
            }
        }
    }
    // Si aucune alarme n'est déclenchée, afficher un message
    echo "Aucune alarme à déclencher";
}

// Appel de la fonction pour vérifier les alarmes
checkAlarms($conn);

// Fermeture de la connexion
$conn->close();
?>
