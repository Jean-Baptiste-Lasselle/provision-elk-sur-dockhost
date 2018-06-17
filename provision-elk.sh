#!/bin/bash
# ----------------------------------------------------------------------------------------------------------------------
# 

######### -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -
######### -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -
# - 
# - Environnement hérité
# - 
# 
export NOM_IMAGE_ELK1=sebp/elk
# export NOM_CONTENEUR_ELK1=conteneur-elk-jibl
export NOM_CONTENEUR_ELK1=conteneur-elk-jibl2
# -----------------------------------------------------------------------------------------------------------------------



# -----------------------------------------------------------------------------------------------------------------------
# opérations
# -----------------------------------------------------------------------------------------------------------------------
#


# Il est possible de spécifier des numéros de versions, pour chacun des 3 composants Elastic Search, Logstash et Kibana, pour les images docker "tirées" du repository docker officiel Elastic Stack, en utilisant les tags publiés sur ce repository public et officiel.
# exemple:  'sudo docker pull sebp/elk:E1L1K4' permet de "tirer" les images Elasticsearch 1.7.3, Logstash 1.5.5, and Kibana 4.1.2
sudo docker pull sebp/elk


# on lance un conteneur
# sudo docker run -p 5601:5601 -p 9200:9200 -p 5044:5044 -it --name $NOM_CONTENEUR_ELK1 $NOM_IMAGE_ELK1
# sudo docker run -it --name $NOM_CONTENEUR_ELK1 -p 5601:5601 -p 9200:9200 -p 5044:5044 -p 9300:9300 $NOM_IMAGE_ELK1
sudo docker run --restart=always --name $NOM_CONTENEUR_ELK1 -p 5601:5601 -p 9200:9200 -p 5044:5044 -p 9300:9300 -d $NOM_IMAGE_ELK1