#!/bin/bash
# Hôte Docker sur centos 7


# DOCKER BARE-METAL-INSTALL - CentOS 7
# sudo systemctl stop docker
# sudo systemctl start docker


# --------------------------------------------------------------------------------------------------------------------------------------------
##############################################################################################################################################
#########################################							ENV								##########################################
##############################################################################################################################################
# --------------------------------------------------------------------------------------------------------------------------------------------
export MAISON_OPERATIONS
# MAISON_OPERATIONS=$(pwd)/provision-app-plus-elk.io
MAISON_OPERATIONS=$(pwd)

# -
export NOMFICHIERLOG
NOMFICHIERLOG="$(pwd)/provision-elk.log"



######### -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -
######### -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -
# -
# export ADRESSE_IP_HOTE_DOCKER_ELK
# export ADRESSE_IP_HOTE_DOCKER_ELK_PAR_DEFAUT
# ADRESSE_IP_HOTE_DOCKER_ELK_PAR_DEFAUT=0.0.0.0

export NOM_CONTENEUR_ELK1=conteneur-elk-jibl
# la "latest" d'Elastic Stack
export NOM_IMAGE_ELK1=sebp/elk
# export ADRESSE_IP_HOTE_DOCKER_ELK_PAR_DEFAUT
# ADRESSE_IP_HOTE_DOCKER_ELK_PAR_DEFAUT=0.0.0.0

######### -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -
######### -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -


# --------------------------------------------------------------------------------------------------------------------------------------------
##############################################################################################################################################
#########################################							FONCTIONS						##########################################
##############################################################################################################################################



# --------------------------------------------------------------------------------------------------------------------------------------------
# Cette fonction permet de demander interactivement à l'utilisateur du
# script, quelle est l'adresse IP, dans l'hôte Docker, que l'instance ....
demander_addrIP_PourJeNeSaisQuelleRaison () {

	echo "Quelle questio?"
	echo "Cette adresse est à  choisir parmi:"
	echo " "
	ip addr|grep "inet"|grep -v "inet6"|grep "enp\|wlan"
	echo " "
	read ADRESSE_IP_CHOISIE
	if [ "x$ADRESSE_IP_CHOISIE" = "x" ]; then
       ADRESSE_IP_HOTE_DOCKER_ELK=ADRESSE_IP_HOTE_DOCKER_ELK_PAR_DEFAUT
	else
	ADRESSE_IP_HOTE_DOCKER_ELK=$ADRESSE_IP_CHOISIE
	fi
	echo " Binding Adresse IP choisit pour le serveur Gogs: $ADRESSE_IP_HOTE_DOCKER_ELK";
}

# --------------------------------------------------------------------------------------------------------------------------------------------
# Cette fonction permet d'appliquer les configurations du système d'exploitation pré-requises par ELK.
ajusterLeSystemSpecialementPourELK () {

# [prérequis 1] "limit on mmap counts equal to 262,144 or more"
# cf. [https://www.elastic.co/guide/en/elasticsearch/reference/5.0/vm-max-map-count.html#vm-max-map-count]

VALEUR_MAX_MAP_COUNT_AVANT=$(sysctl vm.max_map_count)
echo "Avant l'ajustement du système pour l'installation d'ELK: [$VALEUR_MAX_MAP_COUNT_AVANT]" >> $NOMFICHIERLOG
sudo sysctl -w vm.max_map_count=262144 >> $NOMFICHIERLOG
VALEUR_MAX_MAP_COUNT_APRES=$(sysctl vm.max_map_count)
echo "Après l'ajustement du système pour l'installation d'ELK: [$VALEUR_MAX_MAP_COUNT_APRES]" >> $NOMFICHIERLOG

# [prérequis 2] "le port IP 5044 doit être ouvert pour l'hôte réseau exécutant le processus Filebeat (permettant de traiter les logs applicatifs avec Elastic Stack)"
# cf. https://elk-docker.readthedocs.io/#usage
# 

# [prérequis 3] "le port IP 5601 doit être ouvert pour l'hôte réseau exécutant le processus Kibana Web Interface "
# cf. https://elk-docker.readthedocs.io/#usage
# 

# [prérequis 4] "le port IP 9200 doit être ouvert pour l'hôte réseau exécutant le processus du moteur Elastic Serach, pour sa \"JSON interface\" (API REST)"
# cf. https://elk-docker.readthedocs.io/#usage
# 

# [prérequis 4] "le port IP 9300 doit être ouvert pour l'hôte réseau exécutant le processus du moteur Elastic Serach, pour sa \"Transport interface\"  "
# cf. https://elk-docker.readthedocs.io/#usage
# 

}


# --------------------------------------------------------------------------------------------------------------------------------------------
# 
# Cette fonction permet d'attendre que le conteneur soit dans l'état healthy
# Cette fonction prend un argument, nécessaire sinon une erreur est générée (TODO: à implémenter avec exit code)
checkHealth () {
	export ETATCOURANTCONTENEUR=starting
	export ETATCONTENEURPRET=healthy
	export NOM_DU_CONTENEUR_INSPECTE=$1
	
	while  $(echo "+provision+girofle+ $NOM_DU_CONTENEUR_INSPECTE - HEALTHCHECK: [$ETATCOURANTCONTENEUR]">> $NOMFICHIERLOG); do
	
	ETATCOURANTCONTENEUR=$(sudo docker inspect -f '{{json .State.Health.Status}}' $NOM_DU_CONTENEUR_INSPECTE)
	if [ $ETATCOURANTCONTENEUR == "\"healthy\"" ]
	then
		echo " +++provision+  elk +  $NOM_DU_CONTENEUR_INSPECTE est prêt - HEALTHCHECK: [$ETATCOURANTCONTENEUR]">> $NOMFICHIERLOG
		break;
	else
		echo " +++provision+  elk +  $NOM_DU_CONTENEUR_INSPECTE n'est pas prêt - HEALTHCHECK: [$ETATCOURANTCONTENEUR] - attente d'une seconde avant prochain HealthCheck - ">> $NOMFICHIERLOG
		sleep 1s
	fi
	done	
}
# ---------------------------------------------------------
# [description]
# ---------------------------------------------------------
# Cette fonction permet d'attendre que le
# conteneur soit dans l'état running
# Cette fonction prend un argument, nécessaire
# sinon une erreur est générée (TODO: à implémenter avec
# exit code)
checkDockerContainerRunningStatus() {
	export ETATCOURANTCONTENEUR=starting
	export ETATCONTENEURPRET=running
	export NOM_DU_CONTENEUR_INSPECTE=$1
	
	while  $(echo "+provision+girofle+ $NOM_DU_CONTENEUR_INSPECTE - HEALTHCHECK: [$ETATCOURANTCONTENEUR]">> $NOMFICHIERLOG); do
	
	ETATCOURANTCONTENEUR=$(sudo docker inspect -f '{{json .State.Status}}' $NOM_DU_CONTENEUR_INSPECTE)
	if [ $ETATCOURANTCONTENEUR == "\"$ETATCONTENEURPRET\"" ]
	then
		echo " +++provision+ elk +  $NOM_DU_CONTENEUR_INSPECTE est prêt - STATUS: [$ETATCOURANTCONTENEUR]">> $NOMFICHIERLOG
		break;
	else
		echo " +++provision+ elk +  $NOM_DU_CONTENEUR_INSPECTE n'est pas prêt - STATUS: [$ETATCOURANTCONTENEUR] - attente d'une seconde avant prochain HealthCheck - ">> $NOMFICHIERLOG
		sleep 1s
	fi
	done	
}

# --------------------------------------------------------------------------------------------------------------------------------------------
##############################################################################################################################################
#########################################							OPS								##########################################
##############################################################################################################################################
# --------------------------------------------------------------------------------------------------------------------------------------------


# rm  -rf $MAISON_OPERATIONS
# mkdir -p $MAISON_OPERATIONS
# cd $MAISON_OPERATIONS
rm -f $NOMFICHIERLOG
touch $NOMFICHIERLOG


echo " +++provision+  elk +  COMMENCEE  - " >> $NOMFICHIERLOG


# PARTIE INTERACTIVE
clear
echo " "
echo "##########################################################"
echo "##########################################################"
echo " "

# demander_addrIP_PourJeNeSaisQuelleRaison

echo " " >> $NOMFICHIERLOG
echo "##########################################################" >> $NOMFICHIERLOG
echo "##########################################################" >> $NOMFICHIERLOG
echo "########### Installation ELK en cours..." >> $NOMFICHIERLOG
echo "##########################################################" >> $NOMFICHIERLOG
echo " " >> $NOMFICHIERLOG
clear

echo "########### "
echo "########### "
echo "########### Installation ELK en cours..."
echo "########### "

# PARTIE SILENCIEUSE

# on rend les scripts à exécuter, exécutables.
sudo chmod +x ./provision-elk.sh >> $NOMFICHIERLOG


# --------------------------------------------------------------------------------------------------------------------------------------------
# 			PROVISION PAR DES CONTENURS
# --------------------------------------------------------------------------------------------------------------------------------------------

# 0. Pré-requis Système / ELK
ajusterLeSystemSpecialementPourELK
# 1. provision ELK 
./provision-elk.sh >> $NOMFICHIERLOG

# 2. healthcheck
checkDockerContainerRunningStatus $NOM_CONTENEUR_ELK1
echo "########### "
echo "########### "
echo "########### Installation ELK terminée."
echo "########### "

