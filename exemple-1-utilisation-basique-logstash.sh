#!/bin/bash
# ----------------------------------------------------------------------------------------------------------------------
# 

######### -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -
######### -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -
# - 
# - Environnement hérité
# - 
# 
# export NOM_CONTENEUR_ELK1=conteneur-elk-jibl
# -----------------------------------------------------------------------------------------------------------------------



# -----------------------------------------------------------------------------------------------------------------------
# opérations
# -----------------------------------------------------------------------------------------------------------------------
#

# Attention, ceci est une exécution interactive: la commande attendra une arrivée de données sur l'entrée standard
# export NOM_CONTENEUR_ELK1=conteneur-elk-jibl
clear
echo "Pressez la touche clavier retour chariot, pour démarrer le plugin logstash permettant de lire des logs depuis l'entrée standard."
echo "Lorsque le plugin aura terminé son démarrage, il affichera la phrase \"The stdin plugin is now waiting for input:\" "
echo "Dès lors, à chaque fois que vous saisirez une chaîne de caractère, puis "
echo " la touche clavier retour chariot, la chaîne de caractères que vous aurez saisie sera envoyé à Logstash. "
echo " Vous pourrez le vérifier en requêtant ElasticSearch avec la requête [http://192.168.1.16:9200/_search?pretty] (évidemment, vous remplacerez [192.168.1.16] par le nom de domaine, ou l'adresse IP configuré pour votre hôte Docker) "
sudo docker exec -it $NOM_CONTENEUR_ELK1 /bin/bash -c "/opt/logstash/bin/logstash --path.data /tmp/logstash/data -e 'input { stdin { } } output { elasticsearch { hosts => [\"localhost\"] } }'"

# /opt/logstash/bin/logstash --path.data /tmp/logstash/data -e 'input { stdin { } } output { elasticsearch { hosts => ["localhost"] } }'