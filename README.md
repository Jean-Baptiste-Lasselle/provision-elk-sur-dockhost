
# Dépendances

Cette recette doit être exécutée sur une machine sur laquelle:

* Le système d'exploitation est CentOS 7,
* Le système d'exploitation CentOS 7 est configuré pour être synchronisé avec un serveur NTP
* GIT est installé
* La recette de provision d'un [hôte docker centos](https://github.com/Jean-Baptiste-Lasselle/provision-hote-docker-sur-centos) a été exécutée


Cette recette a pour dépendances:

* Le système CentOS 7,
* un serveur NTP
* GIT 
* La recette de provision d'un [hôte docker centos](https://github.com/Jean-Baptiste-Lasselle/provision-hote-docker-sur-centos)


# Utilisation



## Provision du système ELK 

Exécutez:

```
export PROVISIONING_HOME 
PROVISIONING_HOME=$(pwd)/provision-elk-sur-dockhost
rm -rf $PROVISIONING_HOME
mkdir -p $PROVISIONING_HOME
cd $PROVISIONING_HOME
git clone "https://github.com/Jean-Baptiste-Lasselle/elastic-stack-tuto" . 
sudo chmod +x ./operations.sh
./operations.sh
```
Ou encore, en une seule ligne:
```
export PROVISIONING_HOME && PROVISIONING_HOME=$(pwd)/provision-elk-sur-dockhost && rm -rf $PROVISIONING_HOME && mkdir -p $PROVISIONING_HOME && cd $PROVISIONING_HOME && git clone "https://github.com/Jean-Baptiste-Lasselle/elastic-stack-tuto" . && sudo chmod +x ./operations.sh && ./operations.sh
```



# ANNEXE : System Requirements for ELK


Selon la [documentation Officielle Elastic Search ELK](https://www.elastic.co/guide/en/elasticsearch/reference/5.0/vm-max-map-count.html#vm-max-map-count) :

```
Virtual memory


Elasticsearch uses a hybrid mmapfs / niofs directory by default to store its indices. The default operating system limits on mmap counts is likely to be too low, which may result in out of memory exceptions.

On Linux, you can increase the limits by running the following command as root:

sysctl -w vm.max_map_count=262144

To set this value permanently, update the vm.max_map_count setting in /etc/sysctl.conf. To verify after rebooting, run sysctl vm.max_map_count.

The RPM and Debian packages will configure this setting automatically. No further configuration is required.
```


Et voici un exemple de l'erreur obtneue si 'lon ne prend pas en compte cette contrainte système d'Elastic Stack:

```
 * Starting Elasticsearch Server                                         [ OK ]
waiting for Elasticsearch to be up (1/30)
waiting for Elasticsearch to be up (2/30)
waiting for Elasticsearch to be up (3/30)
waiting for Elasticsearch to be up (4/30)
waiting for Elasticsearch to be up (5/30)
waiting for Elasticsearch to be up (6/30)
waiting for Elasticsearch to be up (7/30)
waiting for Elasticsearch to be up (8/30)
waiting for Elasticsearch to be up (9/30)
waiting for Elasticsearch to be up (10/30)
waiting for Elasticsearch to be up (11/30)
waiting for Elasticsearch to be up (12/30)
waiting for Elasticsearch to be up (13/30)
waiting for Elasticsearch to be up (14/30)
waiting for Elasticsearch to be up (15/30)
waiting for Elasticsearch to be up (16/30)
waiting for Elasticsearch to be up (17/30)
waiting for Elasticsearch to be up (18/30)
waiting for Elasticsearch to be up (19/30)
waiting for Elasticsearch to be up (20/30)
waiting for Elasticsearch to be up (21/30)
waiting for Elasticsearch to be up (22/30)
waiting for Elasticsearch to be up (23/30)
waiting for Elasticsearch to be up (24/30)
waiting for Elasticsearch to be up (25/30)
waiting for Elasticsearch to be up (26/30)
waiting for Elasticsearch to be up (27/30)
waiting for Elasticsearch to be up (28/30)
waiting for Elasticsearch to be up (29/30)
waiting for Elasticsearch to be up (30/30)
Couln't start Elasticsearch. Exiting.
Elasticsearch log follows below.
[2018-06-07T05:26:21,574][INFO ][o.e.n.Node               ] [] initializing ...
[2018-06-07T05:26:21,633][INFO ][o.e.e.NodeEnvironment    ] [yfKmdTg] using [1] data paths, mounts [[/var/lib/elasticsearch (/dev/mapper/centos-root)]], net usable_space [44.6gb], net total_space [48gb], types [xfs]
[jibl@pc-65 provision-elk-sur-dockhost]$ clear
[jibl@pc-65 provision-elk-sur-dockhost]$ sudo docker logs 6033f08809ef|more
 * Starting periodic command scheduler cron                              [ OK ]
 * Starting Elasticsearch Server                                         [ OK ]
waiting for Elasticsearch to be up (1/30)
waiting for Elasticsearch to be up (2/30)
waiting for Elasticsearch to be up (3/30)
waiting for Elasticsearch to be up (4/30)
waiting for Elasticsearch to be up (5/30)
waiting for Elasticsearch to be up (6/30)
waiting for Elasticsearch to be up (7/30)
waiting for Elasticsearch to be up (8/30)
waiting for Elasticsearch to be up (9/30)
waiting for Elasticsearch to be up (10/30)
waiting for Elasticsearch to be up (11/30)
waiting for Elasticsearch to be up (12/30)
waiting for Elasticsearch to be up (13/30)
waiting for Elasticsearch to be up (14/30)
waiting for Elasticsearch to be up (15/30)
waiting for Elasticsearch to be up (16/30)
waiting for Elasticsearch to be up (17/30)
waiting for Elasticsearch to be up (18/30)
waiting for Elasticsearch to be up (19/30)
waiting for Elasticsearch to be up (20/30)
waiting for Elasticsearch to be up (21/30)
waiting for Elasticsearch to be up (22/30)
waiting for Elasticsearch to be up (23/30)
waiting for Elasticsearch to be up (24/30)
waiting for Elasticsearch to be up (25/30)
waiting for Elasticsearch to be up (26/30)
waiting for Elasticsearch to be up (27/30)
waiting for Elasticsearch to be up (28/30)
waiting for Elasticsearch to be up (29/30)
waiting for Elasticsearch to be up (30/30)
Couln't start Elasticsearch. Exiting.
Elasticsearch log follows below.
[2018-06-07T05:26:21,574][INFO ][o.e.n.Node               ] [] initializing ...
[2018-06-07T05:26:21,633][INFO ][o.e.e.NodeEnvironment    ] [yfKmdTg] using [1] data paths, mounts [[/var/lib/elasticsearch (/dev/mapper/centos-root)]], net usable_space [44.6gb], net total_space [48gb], types [xfs]
[2018-06-07T05:26:21,634][INFO ][o.e.e.NodeEnvironment    ] [yfKmdTg] heap size [1007.3mb], compressed ordinary object pointers [true]
[2018-06-07T05:26:21,635][INFO ][o.e.n.Node               ] node name [yfKmdTg] derived from node ID [yfKmdTg1TMevn0bJ4WyRyw]; set [node.name] to override
[2018-06-07T05:26:21,635][INFO ][o.e.n.Node               ] version[6.2.4], pid[89], build[ccec39f/2018-04-12T20:37:28.497551Z], OS[Linux/3.10.0-327.el7.x86_64/amd64], JVM[Oracle Corporation/OpenJDK 64-Bit Server VM/
1.8.0_171/25.171-b11]
[2018-06-07T05:26:21,635][INFO ][o.e.n.Node               ] JVM arguments [-Xms1g, -Xmx1g, -XX:+UseConcMarkSweepGC, -XX:CMSInitiatingOccupancyFraction=75, -XX:+UseCMSInitiatingOccupancyOnly, -XX:+AlwaysPreTouch, -Xss
1m, -Djava.awt.headless=true, -Dfile.encoding=UTF-8, -Djna.nosys=true, -XX:-OmitStackTraceInFastThrow, -Dio.netty.noUnsafe=true, -Dio.netty.noKeySetOptimization=true, -Dio.netty.recycler.maxCapacityPerThread=0, -Dlog
4j.shutdownHookEnabled=false, -Dlog4j2.disable.jmx=true, -Djava.io.tmpdir=/tmp/elasticsearch.Mv6FiXSI, -XX:+HeapDumpOnOutOfMemoryError, -XX:+PrintGCDetails, -XX:+PrintGCDateStamps, -XX:+PrintTenuringDistribution, -XX
:+PrintGCApplicationStoppedTime, -Xloggc:logs/gc.log, -XX:+UseGCLogFileRotation, -XX:NumberOfGCLogFiles=32, -XX:GCLogFileSize=64m, -Des.path.home=/opt/elasticsearch, -Des.path.conf=/etc/elasticsearch]
[2018-06-07T05:26:22,187][INFO ][o.e.p.PluginsService     ] [yfKmdTg] loaded module [aggs-matrix-stats]
[2018-06-07T05:26:22,187][INFO ][o.e.p.PluginsService     ] [yfKmdTg] loaded module [analysis-common]
[2018-06-07T05:26:22,187][INFO ][o.e.p.PluginsService     ] [yfKmdTg] loaded module [ingest-common]
[2018-06-07T05:26:22,188][INFO ][o.e.p.PluginsService     ] [yfKmdTg] loaded module [lang-expression]
[2018-06-07T05:26:22,188][INFO ][o.e.p.PluginsService     ] [yfKmdTg] loaded module [lang-mustache]
[2018-06-07T05:26:22,188][INFO ][o.e.p.PluginsService     ] [yfKmdTg] loaded module [lang-painless]
[2018-06-07T05:26:22,188][INFO ][o.e.p.PluginsService     ] [yfKmdTg] loaded module [mapper-extras]
[2018-06-07T05:26:22,188][INFO ][o.e.p.PluginsService     ] [yfKmdTg] loaded module [parent-join]
[2018-06-07T05:26:22,188][INFO ][o.e.p.PluginsService     ] [yfKmdTg] loaded module [percolator]
[2018-06-07T05:26:22,188][INFO ][o.e.p.PluginsService     ] [yfKmdTg] loaded module [rank-eval]
[2018-06-07T05:26:22,188][INFO ][o.e.p.PluginsService     ] [yfKmdTg] loaded module [reindex]
[2018-06-07T05:26:22,188][INFO ][o.e.p.PluginsService     ] [yfKmdTg] loaded module [repository-url]
[2018-06-07T05:26:22,188][INFO ][o.e.p.PluginsService     ] [yfKmdTg] loaded module [transport-netty4]
[2018-06-07T05:26:22,188][INFO ][o.e.p.PluginsService     ] [yfKmdTg] loaded module [tribe]
[2018-06-07T05:26:22,188][INFO ][o.e.p.PluginsService     ] [yfKmdTg] no plugins loaded
[2018-06-07T05:26:24,461][INFO ][o.e.d.DiscoveryModule    ] [yfKmdTg] using discovery type [zen]
[2018-06-07T05:26:24,930][INFO ][o.e.n.Node               ] initialized
[2018-06-07T05:26:24,931][INFO ][o.e.n.Node               ] [yfKmdTg] starting ...
[2018-06-07T05:26:25,048][INFO ][o.e.t.TransportService   ] [yfKmdTg] publish_address {172.17.0.2:9300}, bound_addresses {0.0.0.0:9300}
[2018-06-07T05:26:25,057][INFO ][o.e.b.BootstrapChecks    ] [yfKmdTg] bound or publishing to a non-loopback address, enforcing bootstrap checks
[2018-06-07T05:26:25,059][ERROR][o.e.b.Bootstrap          ] [yfKmdTg] node validation exception
[1] bootstrap checks failed
[1]: max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]
[2018-06-07T05:26:25,061][INFO ][o.e.n.Node               ] [yfKmdTg] stopping ...
[2018-06-07T05:26:25,078][INFO ][o.e.n.Node               ] [yfKmdTg] stopped
[2018-06-07T05:26:25,079][INFO ][o.e.n.Node               ] [yfKmdTg] closing ...
[2018-06-07T05:26:25,090][INFO ][o.e.n.Node               ] [yfKmdTg] closed

```


# ANNEXE

```
 sudo -l -U jibl
[sudo] Mot de passe de jibl : 
Entrées par défaut pour jibl sur pc-65 :
    !visiblepw, always_set_home, match_group_by_gid, env_reset, env_keep="COLORS DISPLAY HOSTNAME HISTSIZE KDEDIR LS_COLORS", env_keep+="MAIL PS1 PS2 QTDIR USERNAME LANG LC_ADDRESS LC_CTYPE", env_keep+="LC_COLLATE
    LC_IDENTIFICATION LC_MEASUREMENT LC_MESSAGES", env_keep+="LC_MONETARY LC_NAME LC_NUMERIC LC_PAPER LC_TELEPHONE", env_keep+="LC_TIME LC_ALL LANGUAGE LINGUAS _XKB_CHARSET XAUTHORITY",
    secure_path=/sbin\:/bin\:/usr/sbin\:/usr/bin

L'utilisateur jibl peut utiliser les commandes suivantes sur pc-65 :
    (ALL) ALL
[jibl@pc-65 ~]$

```

# Sources d'information diverses




* REALEASE 0.0.1 : https://elk-docker.readthedocs.io
<!-- * REALEASE 0.0.2 : https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-getting-started.html  +   https://www.elastic.co/downloads/beats/filebeat -->
<!-- * REALEASE 0.0.3 : http://blog.dbsqware.com/elasticstack-principe-installation-et-premiers-pas/ -->
