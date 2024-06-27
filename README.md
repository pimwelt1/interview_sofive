Pour lancer l'application:
1) Démarrer le frontend react. Go to /frontend,  npm start (s'assurer d'avoir installé axios: npm install axios)
2) Create a database postgresql named sofive_interview and restore the the .sql file with super user postgres 
3) Démarrer le backend. Go to /backend, go build, go run main.go

Comment le site marche:
1) Entrer le nom d'une video (ex: sound of silence)
Si le nom d'existe pas deja dans la base de donnée, une drope zone apparait pour ajouter un fichier .mp4
Une fois un fichier ajouter le nom apparait dans la liste des videos (laisser une vingtaine de seconde pour l'analyse audio)
2) Voir les videos existantes à gauche et clicker pour voir la video
3) Sous la video, ajouter des keywords ou phrases pour acceder à certain passages de la video
